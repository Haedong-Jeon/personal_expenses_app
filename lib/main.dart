import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // 세로 모드 고정 코드
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'openSans',
                  fontSize: 20,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    void _addNewTransaction(String title, double amount, DateTime chosenDate) {
      final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString(),
      );
      setState(() {
        _userTransactions.add(newTx);
      });
    }

    void _startAddNewTransaction(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(handler: _addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
    }

    void _deleteTransaction(String id) {
      setState(() {
        _userTransactions.removeWhere((transaction) => transaction.id == id);
      });
    }

    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'personal expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('personal expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final transactionListWidget = Container(
      height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'show chart!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
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
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!isLandscape) transactionListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    )
                  : transactionListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('show chart!'),
                        Switch.adaptive(
                          activeColor: Theme.of(context).primaryColor,
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
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.3,
                      child: Chart(
                        recentTransactions: _recentTransactions,
                      ),
                    ),
                  if (!isLandscape) transactionListWidget,
                  if (isLandscape)
                    _showChart
                        ? Container(
                            height: (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.3,
                            child: Chart(
                              recentTransactions: _recentTransactions,
                            ),
                          )
                        : transactionListWidget,
                ],
              ),
            ),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
