import 'package:flutter/material.dart';
import 'package:demo_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  const TransactionList(
      {super.key, required this.transaction, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? const Center(
            child: Text(
              "No transaction added yet.",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text("\$${transaction[index].amount}")),
                      )),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(
                      transaction[index].date,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => deleteTx(transaction[index].id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: transaction.length,
          );
  }
}
