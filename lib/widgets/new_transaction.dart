import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void addNewTransaction() {
    String txTitle = titleController.text;
    double txAmount = double.parse(amountController.text);

    if (txTitle.isNotEmpty && txAmount > 0) {
      widget.addTx(txTitle, txAmount);
      Navigator.of(context).pop();
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
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text('Date yet not selected'),
                FlatButton(
                  child: Text('Choose date',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Theme.of(context).primaryColor)),
                  onPressed: () {},
                )
              ],
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              elevation: 4,
              child: Text(
                'Add transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
