import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final Function addTx;

  NewTransaction(this.addTx);

  void addNewTransaction() {
    String txTitle = titleController.text;
    double txAmount = double.parse(amountController.text);

    if (txTitle.isNotEmpty && txAmount > 0) {
      addTx(txTitle, txAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Titile'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Colors.purple,
              onPressed: () {
                addNewTransaction();
              },
            )
          ],
        ),
      ),
    );
  }
}
