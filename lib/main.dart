import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> transaction = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('chart'),
              elevation: 5,
            ),
          ),
          Column(
            children: transaction.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        tx.amount.toString(),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(tx.title),
                        Text(tx.date.toString()),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
