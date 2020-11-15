import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();
  DateTime selectedDate;
  final amountInput = TextEditingController();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  void submitData() {
    if (titleInput.text.isEmpty ||
        double.parse(amountInput.text) <= 0 ||
        selectedDate == null) {
      return;
    }
    widget.addtx(
      titleInput.text,
      double.parse(amountInput.text),
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleInput,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInput,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Date'
                          : "Picked Date : ${DateFormat.yMd().format(selectedDate)}",
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: submitData,
                child: Text('Add Transaction'),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
