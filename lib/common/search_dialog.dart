import 'package:financas_pessoais/controllers/expenses_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchDialog extends StatelessWidget {
  final String? initialText;

  SearchDialog({Key? key, this.initialText}) : super(key: key);
  final _controller = HomeController();

  void _openSelectDateModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Data inicial: '),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: _controller.startDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        ).then((pickedDate) {
                          if (pickedDate == null) {
                            return;
                          }

                          _controller.startDate = pickedDate;
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    Text(_controller.startDate == null
                        ? ''
                        : '${_controller.startDate?.day}/${_controller.startDate?.month}/${_controller.startDate?.year}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Data final: '),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.calendar),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: _controller.endDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        ).then((pickedDate) {
                          if (pickedDate == null) {
                            return;
                          }

                          _controller.endDate = pickedDate;
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                    Text(_controller.endDate == null
                        ? ''
                        : '${_controller.endDate?.day}/${_controller.endDate?.month}/${_controller.endDate?.year}'),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                suffixIcon: PopupMenuButton<int>(
                  icon: Icon(FontAwesomeIcons.filter),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          'Filtrar por Data',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    ];
                  },
                  onSelected: (index) {
                    if (index == 1) {
                      _openSelectDateModal(context);
                    }
                  },
                ),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
