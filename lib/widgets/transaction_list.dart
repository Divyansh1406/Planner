import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transaction added yet",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ), //add some spacing between two widgits
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            //scrollable list that has infinite height (cant have) thats why it is in a container with height
            //using ListView.builder(itemBuilder:(ctx,index) {return }) helps to render a list that loads what is on screen and save memory
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: FittedBox(
                          child: Text(
                        '₹${transactions[index].amount}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          onPressed: (){deleteTx(transactions[index].id);},
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.error)),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            deleteTx(transactions[index].id);
                          },
                        ), //a widget to be shown at the end of ListTile
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
