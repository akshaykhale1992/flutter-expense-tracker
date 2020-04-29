import 'package:expense_tracker/models/database_helpers.dart';
import 'package:flutter/material.dart';
import '../widgets/add_expense_widget.dart';

class AddExpenseActivity extends StatelessWidget {
  final db_helper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    Future<double> getAllExpenses() async {
      double result = (await this.db_helper.getAllExpenses()) ?? 0;
      return result;
    }

    Future<double> getAllIncomes() async {
      double result = (await this.db_helper.getAllIncomes()) ?? 0;
      return result;
    }

    Future<double> getBalance() async {
      double result = (await this.db_helper.getBalance()) ?? 0;
      return result;
    }

    return MaterialApp(
      title: 'Expense Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                "Expense Tracker",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              child: Text(
                "Current Balance:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
              ),
              child: FutureBuilder<double>(
                  future:
                      getBalance(), // Even on Flutter website it's without parentheses but did not work.
                  builder:
                      (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Expenses",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Incomes",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<double>(
                        future:
                            getAllExpenses(), // Even on Flutter website it's without parentheses but did not work.
                        builder: (BuildContext context,
                            AsyncSnapshot<double> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                  Expanded(
                    flex: 1,
                    child: FutureBuilder<double>(
                        future:
                            getAllIncomes(), // Even on Flutter website it's without parentheses but did not work.
                        builder: (BuildContext context,
                            AsyncSnapshot<double> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AddExpenseWidget(),
            )
          ],
        ),
      ),
    );
  }
}
