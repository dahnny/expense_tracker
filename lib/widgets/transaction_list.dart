import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: userTransactions.isEmpty ?
            Column(
              children: <Widget>[
                Text('There are no transactions yet',style: Theme.of(context).textTheme.title,),
                SizedBox(height: 20,),
                Container(height:200,child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))
              ],
            ):ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          child: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.title,
                        textAlign: TextAlign.left,
                      )),
                      Text(
                        DateFormat.yMMMd().format(userTransactions[index].date),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.left,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
            );
          },
          itemCount: userTransactions.length,
        ));
  }
}
