import 'package:flutter/material.dart';
import '../../domain/entities/transaction.dart'; // Importa el modelo de datos
import 'package:intl/intl.dart'; // Importa intl para formatear la fecha y hora

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList({required this.transactions});

  @override
  Widget build(BuildContext context) {

    transactions.sort((a, b) => b.date.compareTo(a.date));
    Map<String, List<Transaction>> groupedTransactions = {};

    for (var transaction in transactions) {
      String date = DateFormat.yMMMMd('en_EN').format(transaction.date);
      if (!groupedTransactions.containsKey(date)) {
        groupedTransactions[date] = [];
      }
      groupedTransactions[date]!.add(transaction);
    }

    List<Widget> transactionWidgets = [];

    // Crear los widgets para las transacciones agrupadas por fecha
    groupedTransactions.forEach((date, transactions) {
      transactionWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            date,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                fontStyle: FontStyle.italic,
                color: Color(0xFF762B2B))
          ),
        ),
      );

      for (int i = 0; i < transactions.length; i++) {
        var transaction = transactions[i];
        transactionWidgets.add(
          ListTile(
            leading: Text(
                transaction.personName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins',
                    color: Color(0xFF000000))),
            trailing: Text(
                "\s/${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins',
                    color: Color(0xFF000000))
            ),
          ),
        );

        // Añadir un Divider entre cada transacción
        if (i < transactions.length - 1) {
          transactionWidgets.add(
              Divider(
                  color: Color(0xFFDFE0EB)
              )
          );
        }
      }
    });

    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Historial",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xFF000000))
              ),
              SizedBox(height: 20),
              Expanded(
                  child: ListView(
                    children: transactionWidgets,
                  )
              ),
            ],
          ),
        )
      );
  }
}
