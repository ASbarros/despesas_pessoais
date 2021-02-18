import 'package:financas_pessoais/models/category_model.dart';
import 'package:financas_pessoais/models/expenses_model.dart';
import 'package:financas_pessoais/repositorys/category_repository.dart';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signin;
import 'dart:convert' show json, utf8;

import '../expenses_repository.dart';
import 'google_auth_client.dart';

class BackupRepository {
  final _nameFile = 'backup_bd_finansas_pessoais.json';
  final _repositoryCategory = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();

  Future<Map<String, dynamic>> writeBackup() async {
    final listCategories = await _repositoryCategory.fetchCategories();
    final listExpenses = await _repositoryExpenses.fetchExpenses();
    final obj = {'categories': listCategories, 'expenses': listExpenses};
    try {
      final googleSignIn =
          signin.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveScope]);
      final account = await googleSignIn.signIn();

      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final list = utf8.encode(json.encode(obj));

      final mediaStream = Future.value(list).asStream();
      final media = drive.Media(mediaStream, list.length);
      final driveFile = drive.File();

      driveFile.name = _nameFile;

      final listFiles = await driveApi.files.list();

      for (var i = 0; i < listFiles.files.length; i++) {
        if (listFiles.files[i].name.contains(_nameFile)) {
          await driveApi.files.delete(listFiles.files[i].id);
        }
      }
      await driveApi.files.create(driveFile, uploadMedia: media);
      return {'success': true, 'msg': ''};
    } on Exception catch (_, e) {
      print(e);
      return {'success': false, 'msg': e};
    }
  }

  Future<Map<String, dynamic>> readBackup() async {
    try {
      final googleSignIn =
          signin.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveScope]);
      final account = await googleSignIn.signIn();

      final authHeaders = await account.authHeaders;
      final authenticateClient = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(authenticateClient);

      final list = await driveApi.files.list();
      drive.Media files;
      for (var i = 0; i < list.files.length; i++) {
        if (list.files[i].name.contains(_nameFile)) {
          files = await driveApi.files.get(list.files[i].id,
              downloadOptions: drive.DownloadOptions.FullMedia);
          break;
        }
      }
      final stream = await files.stream;
      var dataStore = <int>[];
      stream.listen((data) {
        print('DataReceived: ${data.length}');
        dataStore.insertAll(dataStore.length, data);
      }, onDone: () {
        final data = json.decode(utf8.decode(dataStore));

        for (var i in data['categories']) {
          _repositoryCategory.insert(CategoryModel.fromMap(json.decode(i)));
        }
        for (var i in data['expenses']) {
          _repositoryExpenses.insert(ExpensesModel.fromMap(json.decode(i)));
        }
        print('Task Done');
      }, onError: (error) {
        print('Some Error $error');
      });

      return {'success': true, 'msg': ''};
    } on Exception catch (_, e) {
      print(e);
      return {'success': false, 'msg': e};
    }
  }
}
