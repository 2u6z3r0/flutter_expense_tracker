import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                  child: Text('₹${transaction.amount.toStringAsFixed(1)}')),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle:
              Text(DateFormat.yMMMd().format(transaction.date).toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // IconButton(
              //   icon: Icon(Icons.edit),
              //   color: Theme.of(context).primaryColor,
              //   onPressed: () {},
              // ),
              MediaQuery.of(context).size.width > 420
                  ? TextButton.icon(
                      onPressed: () => deleteTransaction(transaction.id),
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      // textColor: Theme.of(context).errorColor,
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTransaction(transaction.id),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
