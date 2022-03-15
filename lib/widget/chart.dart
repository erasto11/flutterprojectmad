import 'package:first/moder/transaction.dart';
import 'package:first/widget/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../moder/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var sumAmount = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date1.day == weekDay.day &&
            recentTransaction[i].date1.month == weekDay.month &&
            recentTransaction[i].date1.year == weekDay.year) {
          sumAmount = sumAmount + recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': sumAmount
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  Widget build(BuildContext context) {
    print(groupTransactionValue);
    return  Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: groupTransactionValue.map((data) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      (data['day'] as String),
                      (data['amount'] as double),
                      (data['amount'] as double) / maxSpending));
            }).toList(),
          ),
        ),
      );
    
  }
}
