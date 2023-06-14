import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectDate == null)
      return;
    widget.addTx(_titleController.text, double.parse(_amountController.text),
        _selectDate);
    Navigator.of(context)
        .pop(); //automatically closes the modal sheet when we are done entering data
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  //these controller saves user input
                  onSubmitted: (_) => _submitData()
                  // onChanged: (val){
                  //   titleInput=val;
                  // },
                  ),
              //to take input
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) =>
                    _submitData(), //an argument that we dont use (_)
                // onChanged: (val){ //use when we enter or change something in textfield as an input
                //   amountInput=val;
                // },
              ),
              // input decoration and labelText helps to give hint in the input box means initial text appearing over input field before we type
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectDate == null
                            ? 'No Date Chosen'
                            : 'Picked! Date: ${DateFormat.yMd().format(_selectDate!)}')),
                    //If we know that the passed object will not be null at any point we can add '!' at the end that ensures value will not be null.
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              "Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              _presentDatePicker();
                            },
                          )
                        : TextButton(
                            onPressed: () {
                              _presentDatePicker();
                            },
                            child: Text(
                              "Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                },
                child: Text('Add Transaction'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
