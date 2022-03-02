class YenepayItem {
  final String? itemId;
  final String itemName;
  final double unitPrice;
  final int quantity;

  YenepayItem({
    this.itemId,
    required this.itemName,
    required this.unitPrice,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      if (itemId != null) "itemId": itemId,
      "itemName": itemName,
      "unitPrice": unitPrice,
      "quantity": quantity,
    };
  }

  factory YenepayItem.fromJson(Map<String, dynamic> json) {
    return YenepayItem(
      itemId: json["itemId"],
      itemName: json["itemName"],
      unitPrice: json["unitPrice"],
      quantity: json["quantity"],
    );
  }
//

}
