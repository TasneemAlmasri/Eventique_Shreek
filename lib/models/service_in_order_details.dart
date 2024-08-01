class ServiceInOrderDetails {
  final int orderServiceId;
  final int quantity;
  final double totalPrice;
  final String imgUrl;
  final String status;
  final String name,orederdBy;
  final int isCustomized;
  final DateTime dueDate;

  ServiceInOrderDetails(
      {required this.status,
      required this.name,
      required this.orederdBy,
      required this.orderServiceId,
      required this.quantity,
      required this.totalPrice,
      required this.imgUrl,
      required this.isCustomized,
      required this.dueDate,
      });
}
