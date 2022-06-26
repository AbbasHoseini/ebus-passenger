class TransactionArgs {
  int? id, userId, payType, reference, travelTicketId, acceptorBankId, amount;
  String? paymentStatus, saleReferenceId, title, description, date, time;
  String? type; // deposit or bardasht

  TransactionArgs(
      {this.id,
      this.title,
      this.description,
      this.type,
      this.amount,
      this.date,
      this.time});
}
