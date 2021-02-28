import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FooterHome extends StatelessWidget {
  const FooterHome({
    Key key,
    @required this.totalValue,
  }) : super(key: key);

  final double totalValue;

  String get valueFormatted {
    final numberFormat = NumberFormat.currency(locale: 'pt_br');

    return numberFormat.format(totalValue).substring(4);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total: R\$ $valueFormatted',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
