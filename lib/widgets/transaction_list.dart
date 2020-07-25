import 'package:flutter/material.dart';
import '../models/Transcation.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteRecord;
  TransactionList(this.transactionList, this.deleteRecord);

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(),
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: transactionList.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transaction to display',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/waithing.png',
                      // height: constrains.maxHeight*0.5,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (bCtx, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Container(
                        width: 100,
                        height: 50,
                        //padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                            child: Text(
                          '₹${transactionList[index].price.toStringAsFixed(0)}',
                        )),
                      ),
                      title: Text(
                        transactionList[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactionList[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 410
                          ? FlatButton.icon(onPressed: () => deleteRecord(transactionList[index].id), icon: Icon(Icons.delete), label: Text('Delete Item'),textColor: Colors.red,)
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteRecord(transactionList[index].id),
                              color: Theme.of(context).errorColor,
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
