// import 'dart:math';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spentAmount;
  final double spentAmountPrcntOfTotal;

  const ChartBar(
      {required this.label,
      required this.spentAmount,
      required this.spentAmountPrcntOfTotal});

  @override
  Widget build(BuildContext context) {
    print(spentAmountPrcntOfTotal.toString());
    print(spentAmount.toString());
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('₹${spentAmount!.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: spentAmountPrcntOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // color: Colors
                          //     .primaries[Random().nextInt(Colors.primaries.length)],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label!)),
          )
        ],
      );
    });
  }
}
