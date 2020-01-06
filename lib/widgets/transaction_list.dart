import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  transactions[index].amount.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('dd MMM yyyy').format(transactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
