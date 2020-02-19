import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  Function deleteTransactions;

  TransactionList(this.userTransactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: userTransactions.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'There are no transactions yet',
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          ))
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItem(userTransaction: userTransactions[index], deleteTransactions: deleteTransactions);
                },
                itemCount: userTransactions.length,
              ));
  }
}
