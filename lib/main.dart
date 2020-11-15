import 'dart:io';

import 'package:app_2/models/transaction.dart';
import 'package:app_2/widgets/chart.dart';
import 'package:app_2/widgets/new_transaction.dart';
import 'package:app_2/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.green,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacton> _userTransactions = [
    // Transacton(
    //   id: 't1',
    //   amount: 12.12,
    //   title: "Dildo",
    //   date: DateTime.now(),
    // ),
    // Transacton(
    //   id: 't2',
    //   amount: 42.22,
    //   title: "Dildo (Black) ",
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transacton> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void addTransaction(txTitle, txAmount, txDate) {
    final tx = Transacton(
        id: DateTime.now().toString(),
        amount: txAmount,
        date: txDate,
        title: txTitle);
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.65,
      child: TransactionList(_userTransactions, deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show charts'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.35,
                child: Chart(recentTransactions),
              ),
            if (!isLandscape) txList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.65,
                      child: Chart(recentTransactions),
                    )
                  : txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => startAddNewTransaction(context),
            ),
    );
  }
}
