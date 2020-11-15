import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transacton> listTrans;
  final Function deltrans;
  TransactionList(this.listTrans, this.deltrans);
  @override
  Widget build(BuildContext context) {
    return listTrans.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  "No transactions",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
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
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 7,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 7,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${listTrans[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    listTrans[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(listTrans[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      deltrans(listTrans[index].id.toString());
                    },
                  ),
                ),
              );
            },
            itemCount: listTrans.length,
          );
  }
}
