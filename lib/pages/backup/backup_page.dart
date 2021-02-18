import 'package:financas_pessoais/repositorys/backup/backup_repository.dart';
import 'package:flutter/material.dart';

class BackupPage extends StatelessWidget {
  final _repository = BackupRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _repository.writeBackup,
          child: Text('Fazer Backup'),
        ),
      ),
    );
  }
}
