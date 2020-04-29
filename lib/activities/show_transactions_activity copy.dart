import 'package:expense_tracker/models/database_helpers.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import './add_expense_activity.dart';

class Transactions extends State<ShowTransactionsActivity> {
  ShowTransactionsActivity showTransactionActivity;
  Transactions(this.showTransactionActivity);

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void initState() => showTransactionActivity.onLoad(context);
}

class ShowTransactionsActivity extends StatefulWidget {
  String TextBoxText = "Transactions will appear here";
  List<Map<String, dynamic>> transactions = List<Map<String, dynamic>>();
  State<StatefulWidget> createState() => Transactions(this);

  void onLoad(Context context) {
    final databaseHelper = DatabaseHelper.instance;
    databaseHelper
        .queryAllRows()
        .then((List<Map<String, dynamic>> rows) => {this.transactions = rows});
  }

  Widget generateListview() {
    List<Widget> rows = List<Widget>();
    int index = 0;
    for (var transaction in this.transactions) {
      Widget listElement = Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(30),
        // decoration: BoxDecoration(border: Border.only(color: Colors.blueAccent)),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(transaction['description'],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 2)),
                    Text(transaction['amount'].toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 2))
                  ],
                )
              ],
            )),
      );
      rows.insert(index, listElement);
      index++;
    }
    return ListView(
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Tracker',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Expense Tracker'),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: this.generateListview(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddExpenseActivity()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ));
  }
}
