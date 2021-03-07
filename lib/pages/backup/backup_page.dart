import 'package:financas_pessoais/repositorys/backup/backup_repository.dart';
import 'package:flutter/material.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final _repository = BackupRepository();

  bool done = false;

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
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Center(
        child: Visibility(
          replacement: CircularProgressIndicator(),
          visible: done,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Falha ao criar! ${res['msg']}'),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                      content: Text('Falha ao restaurar! ${res['msg']}'),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
