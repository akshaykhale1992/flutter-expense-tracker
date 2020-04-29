import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transaction_model.dart';
import '../models/database_helpers.dart';

class AddExpenseWidget extends StatelessWidget {
  final amountTextFieldController = TextEditingController();
  final descriptionTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextField(
                controller: descriptionTextFieldController,
                style: TextStyle(fontSize: 25),
                decoration:
                    InputDecoration(labelText: "Enter Expense Description")),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextField(
                controller: amountTextFieldController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(labelText: "Enter Expense Amount")),
          ),
          Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              margin: const EdgeInsets.only(bottom: 15),
              child: RaisedButton(
                padding: new EdgeInsets.all(10),
                onPressed: () {
                  final transaction = TransactionModel(
                      amount: double.parse(amountTextFieldController.text),
                      description: descriptionTextFieldController.text);
                  final database_helper = DatabaseHelper.instance;
                  database_helper.insert(transaction);
                  final snackBar =
                      SnackBar(content: Text("Transaction Added Successfully"));
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                color: const Color.fromARGB(255, 66, 165, 245),
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                      fontSize: 25,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              )),
          Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              margin: const EdgeInsets.only(bottom: 15),
              child: RaisedButton(
                padding: new EdgeInsets.all(10),
                onPressed: () {
                  final database_helper = DatabaseHelper.instance;
                  database_helper.deleteAllRecords();
                  final snackBar = SnackBar(
                      content: Text("All the Transactions are cleared"));
                  Scaffold.of(context).showSnackBar(snackBar);
                },
                color: const Color.fromARGB(255, 66, 165, 245),
                child: Text(
                  "Clear All Transactions",
                  style: TextStyle(
                      fontSize: 25,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              )),
        ],
      ),
    );
  }
}
