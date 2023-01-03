class PaymentItemModel {
  String date;
  int purchaseConfirmation;
  int returnAmount;
  int fees;
  int sum;

  PaymentItemModel(
      {required this.date,
      required this.purchaseConfirmation,
      required this.returnAmount,
      required this.fees,
      required this.sum});
}
