import 'package:flutter/material.dart';

import '../../providers/backup_provider.dart';

class BackupPage extends StatelessWidget {
  final _backup = BackupProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.upload_sharp),
              label: Text('Backup'),
              onPressed: () async {
                _backup.writeCounter();
                /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: _backupController.writeCounter,
                  ),
                  content: Text('Falha ao criar! '),
                  duration: Duration(seconds: 5),
                )); */
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              label: Text('Restaurar'),
              icon: Icon(Icons.file_download),
              onPressed: () {
                /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                  content: Text('Restaurado sem falhas!'),
                  duration: Duration(seconds: 5),
                ));

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                  content: Text('Falha ao restaurar! '),
                  duration: Duration(seconds: 5),
                )); */
                _backup.readCounter(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
