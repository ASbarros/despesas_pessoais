import 'package:financas_pessoais/repositorys/backup/backup_repository.dart';
import 'package:flutter/material.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final _repository = BackupRepository();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool done;

  @override
  void initState() {
    super.initState();
    setState(() {
      done = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Center(
        child: Visibility(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton.icon(
                icon: Icon(Icons.upload_sharp),
                label: Text('Backup'),
                onPressed: () async {
                  setState(() {
                    done = false;
                  });
                  final res = await _repository.writeBackup();
                  if (res['success']) {
                    setState(() {
                      done = true;
                    });
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Criado com sucesso!'),
                      duration: Duration(seconds: 5),
                    ));
                  } else {
                    setState(() {
                      done = true;
                    });
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Falha ao criar!'),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton.icon(
                label: Text('Restaurar'),
                icon: Icon(Icons.file_download),
                onPressed: () async {
                  setState(() {
                    done = false;
                  });
                  final res = await _repository.readBackup();
                  if (res['success']) {
                    setState(() {
                      done = true;
                    });
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Restaurado sem falhas!'),
                      duration: Duration(seconds: 5),
                    ));
                  } else {
                    setState(() {
                      done = true;
                    });
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Falha ao restaurar!'),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ),
            ],
          ),
          replacement: CircularProgressIndicator(),
          visible: done,
        ),
      ),
    );
  }
}
