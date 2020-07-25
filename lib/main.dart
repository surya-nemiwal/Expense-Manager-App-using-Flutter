import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/Transcation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Manager",
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.cyan,
        errorColor: Colors.red,
        fontFamily: 'QuickSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: ExpManager(),
    );
  }
}

class ExpManager extends StatefulWidget {
  @override
  ExpManagerState createState() => ExpManagerState();
}

class ExpManagerState extends State<ExpManager> {
  List<Transaction> transactionList = [];
  bool showChart = true;

  void deleteRecord(id) {
    setState(() {
      transactionList.removeWhere((element) => element.id == id);
    });
  }

  DateTime currentdate = DateTime.now();
  List<Transaction> get resentTransactions {
    return transactionList
        .where(
          (transaction) => transaction.date.isAfter(
            currentdate.subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void addRecord({String title, double amount, DateTime date}) {
    setState(() {
      transactionList.add(
        Transaction(
          name: title,
          price: amount,
          date: date,
          id: date.toString(),
        ),
      );
    });
  }

  void startAddNewTransaction(ctx) {
    showModalBottomSheet<void>(
        context: ctx,
        builder: (BuildContext bCtx) {
          return NewTransaction(addRecord);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape ? true : false;
    final appBar = AppBar(
      title: Text("Expense Manager"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
      width: double.infinity,
      child: TransactionList(transactionList, deleteRecord),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart'),
                    Switch(
                      value: showChart,
                      onChanged: (val) => setState(() {
                        showChart = val;
                      }),
                    ),
                  ],
                ),
              if (isLandScape)
                if (showChart)
                  Container(
                    height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * .7,
                    child: Chart(resentTransactions),
                  ),
              if (isLandScape) if (!showChart) txListWidget,
              if (!isLandScape)
                Container(
                  height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * .3,
                  child: Chart(resentTransactions),
                ),
              if (!isLandScape) txListWidget,
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startAddNewTransaction(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
