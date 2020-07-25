import 'package:flutter/material.dart';
import '../models/Transcation.dart';
import 'package:intl/intl.dart';
import './chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> resentTransactions;
  Chart(this.resentTransactions);

  double get overallTotal {
    double tmp = 0;
    for (int i = 0; i < resentTransactions.length; i++) {
      tmp += resentTransactions[i].price;
    }
    return tmp;
  }

  List<Map<String, Object>> get chartData {
    return List.generate(7, (index) {
      double totalamount = 0;
      DateTime currentDate = DateTime.now().subtract(Duration(days:index));
      for (int i = 0; i < resentTransactions.length; i++) {
        if (resentTransactions[i].date.day == currentDate.day && resentTransactions[i].date.month == currentDate.month && resentTransactions[i].date.year == currentDate.year) {
          totalamount += resentTransactions[i].price;
        }
      }

      return {
        'amount': totalamount,
        'day': DateFormat.E().format(currentDate).substring(0, 3),
      };
    });
  }

  double get totalAmount {
    return resentTransactions.fold(
      0.0,
      (previousValue, element) => previousValue + element.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double overallTotal = totalAmount;
    // print(resentTransactions);
    return Card(
    margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: chartData.map((data) {
            return ChartBar(
              totalAmount: data['amount'],
              day: data['day'],
              percentOfOverallTotal: overallTotal == 0 ? 0 : (data['amount'] as double) / overallTotal,
            );
          }).toList(),
        ),
      ),
    );
  }
}
