import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'new shoes',
      amount: 58.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'new clothes',
      amount: 39.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'new food',
      amount: 39.23,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'new book',
      amount: 58.21,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'new ball',
      amount: 2.19,
      date: DateTime.now(),
    ),
  ];
  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(),
        TransactionList(_userTransactions),
      ],
    );
  }
}
