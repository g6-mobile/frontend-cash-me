import '../entities/transaction.dart';

class TransactionService{
  final TransactionRepository transactionRepository;

  TransactionService(this.transactionRepository);

  Future<Transaction> createTransaction(Transaction transaction) async {
    return await transactionRepository.createTransaction(transaction);
  }

  Future<List<Transaction>> getTransactions() async {
    return await transactionRepository.getTransactions();
  }

  Future<Transaction> getTransaction(String id) async {
    return await transactionRepository.getTransaction(id);
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    return await transactionRepository.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(String id) async {
    return await transactionRepository.deleteTransaction(id);
  }
}