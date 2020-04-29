class TransactionModel {
  final double amount;
  final String description;

  TransactionModel(
    {
      this.amount, this.description
    }
  );

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'description': description};
  }
}
