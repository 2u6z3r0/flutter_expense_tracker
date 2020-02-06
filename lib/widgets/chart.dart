import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (int index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var tx in recentTransactions) {
        if (weekDay.day == tx.date.day &&
            weekDay.month == tx.date.month &&
            weekDay.year == tx.date.year) {
          totalSum += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get _totalAmountSpent {
    return recentTransactions.fold(0.0, (sum, tx) {
      return sum += tx.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            ..._groupedTransactionValues.reversed.map((tx) {
              return Expanded(
                  child: ChartBar(
                spentAmount: tx['amount'],
                label: tx['day'],
                spentAmountPrcntOfTotal: _totalAmountSpent == 0.0
                    ? 0.0
                    : (tx['amount'] as double) / _totalAmountSpent,
              ));
            }).toList(),
          ],
        ),
      ),
    );
  }
}
