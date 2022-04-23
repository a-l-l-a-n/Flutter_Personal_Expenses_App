import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter the Title:",
                ),
                keyboardType: TextInputType.text,
                controller: titleController,
                validator: (v) {
                  if (v.toString().trim().isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter the Amount: ",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                //onSubmitted: (txt) => amountController.text = txt,
                controller: amountController,
                validator: (v) {
                  if (v.toString().trim().isEmpty) {
                    return "Amount cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate == null
                      ? 'Pick a date'
                      : 'Picked Date:${DateFormat.yMd().format(_selectedDate)}'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextButton.icon(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 16, vertical: 13)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2)),
                      ),
                      onPressed: datePicker,
                      icon: Icon(CupertinoIcons.calendar),
                      label: Text(
                        'Choose Date',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12.5)),
                ),
                icon: Icon(Icons.add_circle_outline),
                label: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) return;

                  String title = titleController.text;
                  double amount =
                      double.parse(amountController.text.toString());
                  if (title.isNotEmpty && amount > 0 && _selectedDate != null)
                    widget.addTransaction(title, amount, _selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
