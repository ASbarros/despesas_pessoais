import 'package:flutter/material.dart';

class PageDefault extends StatelessWidget {
  const PageDefault({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            'Nenhum dado encontrado!',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
