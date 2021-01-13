import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

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
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${widget.transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(widget.transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 450
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => widget.deleteTransactions(
                            widget.transactions[index].id,
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => widget.deleteTransactions(
                              widget.transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: widget.transactions.length,
          );
  }
}
