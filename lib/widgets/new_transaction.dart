import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  const NewTransaction({super.key, required this.addTX});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTX(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                onChanged: (_) => _submitData,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: (_) => _submitData,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate == null
                            ? "No date chosen"
                            : "Date picked: ${DateFormat.yMd().format(_selectedDate!)}")),
                    MaterialButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: const Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
