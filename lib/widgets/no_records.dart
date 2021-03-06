import 'package:flutter/material.dart';

class NoRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'No records added yet!',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Image.asset(
              'assets/images/no_data_found.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
