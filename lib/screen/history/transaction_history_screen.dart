import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/student_by_history.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/studentByCode.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../domain/entities/transaction_history.dart'; // Importa el modelo de datos
import 'package:intl/intl.dart'; // Importa intl para formatear la fecha y hora

@RoutePage()
class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  late final authProvider;
  late final studentCode;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    final studentCode = authProvider.user?.studentCode ?? '';
    Provider.of<TransactionProvider>(context, listen: false)
        .getTransactionsHistoryProvider(studentCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        if (transactionProvider.transactionHistory == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          TransactionHistoryResponse transactions =
              transactionProvider.transactionHistory!;
          transactions.data.transactions.sort((a, b) =>
              DateTime.parse(b.updatedAt)
                  .compareTo(DateTime.parse(a.updatedAt)));
          Map<String, List<Transaction>> groupedTransactions = {};

          for (var transaction in transactions.data.transactions) {
            String locale = Localizations.localeOf(context).languageCode;
            String date = DateFormat.yMMMMd(locale)
                .format(DateTime.parse(transaction.updatedAt));
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  date,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            );

            for (int i = 0; i < transactions.length; i++) {
              var transaction = transactions[i];
              String currentUserCode = authProvider.user?.studentCode ?? '';
              String studentCodeToSend;
              String displayNamePrefix;
              if (currentUserCode == transaction.approverCode.toString()) {
                studentCodeToSend = transaction.initiatorCode.toString();
                displayNamePrefix = "Me -> ";
              } else {
                studentCodeToSend = transaction.approverCode.toString();
                displayNamePrefix = " -> Me";
              }

              transactionWidgets.add(
                FutureBuilder<StudentByCodeHistory>(
                  future:
                      authProvider.studentByCodeForHistory(studentCodeToSend),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            // Ajusta el ancho según tus necesidades
                            height: 20,
                            // Ajusta la altura según tus necesidades
                            color: Colors.white,
                          ),
                          trailing: Container(
                            width: 50,
                            // Ajusta el ancho según tus necesidades
                            height: 20,
                            // Ajusta la altura según tus necesidades
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String student = snapshot.data!.name;
                      List<String> nameParts = student.split(' ');
                      String displayName = nameParts.length >= 2
                          ? '${nameParts[0]} ${nameParts[1]}'
                          : student;
                      displayName = displayNamePrefix == "Me -> "
                          ? "Me -> $displayName"
                          : "$displayName -> Me";
                      return ListTile(
                        leading: Text(
                            displayName, // Muestra el nombre del estudiante
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                        trailing: Text(
                            "s/${transaction.amount.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                                color: transaction.operationType == 1
                                    ? Color(0xFF1CDD18)
                                    : Color(0xFF00B8FF))),
                      );
                    }
                  },
                ),
              );

              // Añadir un Divider entre cada transacción
              if (i < transactions.length - 1) {
                transactionWidgets.add(
                    Divider(color: Theme.of(context).colorScheme.onBackground));
              }
            }
          });

          return Scaffold(
              body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                studentCode = authProvider.user?.studentCode ?? '';
                await Provider.of<TransactionProvider>(context, listen: false)
                    .getTransactionsHistoryProvider(studentCode);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Historial",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).colorScheme.onBackground)),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView(
                    children: transactionWidgets,
                  )),
                ],
              ),
            ),
          ));
        }
      },
    );
  }
}
