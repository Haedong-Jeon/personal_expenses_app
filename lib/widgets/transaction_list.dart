import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions, this.deleteTransactions);

  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                transaction: widget.transactions[index],
                mediaQuery: mediaQuery,
                deleteTx: widget.deleteTransactions,
              );
            },
            itemCount: widget.transactions.length,
          );
  }
}
