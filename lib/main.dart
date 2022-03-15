import './widget/chart.dart';
import 'package:first/widget/newTransaction.dart';
import 'package:first/widget/transactionList.dart';
import './moder/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
      title: 'Flutter App',
      home: MyAppNw(),
    );
  }
}

class MyAppNw extends StatefulWidget {
  // String title;
  //String amount;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppNw> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 't1',
      title: 'shoes',
      amount: 233.1,
      date1: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'phone',
      amount: 333.1,
      date1: DateTime.now(),
    ),
  ];
  List<Transaction> get _resentTransaction {
    return _transaction.where((tx) {
      return tx.date1.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTx(String txTitle, double txamount, DateTime choosenDate) {
    final nwTx = Transaction(
        title: txTitle,
        amount: txamount,
        date1: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      _transaction.add(nwTx);
    });
  }

  void _startAddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tx) => tx.id == id);
    });
  }

  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('transaction'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddingTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                //color: Colors.grey,
                child: Chart(_resentTransaction)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_transaction, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddingTransaction(context)),
    );
  }
}
