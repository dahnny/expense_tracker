import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      //This subtracts days from the present date
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      //go through every transaction in the list
      for (int i = 0; i < recentTransactions.length; i++) {
        //check if the transaction date equals that of the week and get the total amount
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    //sum signifies the new variable that takes the value 0.0
    // item signifies the object in the list
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(
              data['day'],
              data['amount'],
              totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
            ));
          }).toList(),
        ),
      ),
    );
  }
}
