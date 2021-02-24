import 'package:financas_pessoais/providers/chart_pie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool selected;
  final double size;
  final Color textColor = const Color(0xff505050);
  final int idCategory;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.selected = true,
    this.size = 16,
    this.idCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartPieProvider = Provider.of<ChartPieProvider>(context);
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          child: Checkbox(
            value: selected,
            checkColor: color,
            activeColor: color,
            onChanged: (_) {
              chartPieProvider.toggle(idCategory);
            },
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
        )
      ],
    );
  }
}
