import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalAmount;
  final String day;
  final double percentOfOverallTotal;
  ChartBar({this.totalAmount, this.day, this.percentOfOverallTotal});
  @override
  Widget build(BuildContext context) {
    return Flexible(
          fit: FlexFit.tight,
          child: LayoutBuilder(
            builder:(ctx,constrains) => 
              Column(
                children: <Widget>[
                  Container(
                    height: constrains.maxHeight*0.15,
                    child: FittedBox(
                      child: Text(
                        '₹${totalAmount.toStringAsFixed(0)}',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constrains.maxHeight*0.05,
                  ),
                  Container(
                    height: constrains.maxHeight*0.6,
                    width: 10,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            color: Color.fromRGBO(220, 200, 200, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: percentOfOverallTotal,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constrains.maxHeight*0.05,
                  ),
                  Container(
                    height: constrains.maxHeight*0.15,
                    child: Text(
                      day,
                    ),
                  ),
                ],
        ),
             ),
  
    );
  }
}
