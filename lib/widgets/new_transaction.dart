import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _pickedDate;

  void addNewTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }

    String txTitle = _titleController.text;
    double txAmount = double.parse(_amountController.text);

    if (txTitle.isNotEmpty && txAmount > 0 && _pickedDate != null) {
      widget.addTx(txTitle, txAmount, _pickedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _pickedDate = selectedDate;
      });
    });
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
              controller: _titleController,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _pickedDate == null
                        ? 'No Date Choosen!'
                        : DateFormat('dd/MM/yyyy').format(_pickedDate),
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Choose date',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _presentDatePicker,
                )
              ],
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              elevation: 4,
              child: Text(
                'Add transaction',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).buttonColor),
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
