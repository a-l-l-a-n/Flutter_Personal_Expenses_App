import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _selectedDate;

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return null;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Enter the Title:",
                    ),
                    keyboardType: TextInputType.text,
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Enter the Amount: ",
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    //onSubmitted: (txt) => amountController.text = txt,
                    controller: amountController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedDate == null
                          ? 'Pick a date'
                          : 'Picked Date:${DateFormat.yMd().format(_selectedDate)}'),
                      TextButton(
                        onPressed: datePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      String title = titleController.text;
                      double amount =
                          double.parse(amountController.text.toString());
                      if (title.isNotEmpty &&
                          amount > 0 &&
                          _selectedDate != null)
                        widget.addTransaction(title, amount, _selectedDate);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
