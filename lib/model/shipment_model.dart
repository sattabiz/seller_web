// To parse this JSON data, do
//
//     final shipment = shipmentFromMap(jsonString);

import 'dart:convert';

class Shipment {
    int shipmentId;
    String ?waybillNo;
    DateTime ?shipmentDate;
    String ?carrier;
    String ?trackingNo;
    String ?state;
    String ?senderName;
    String ?senderErpId;
    List<Product> products;

    Shipment({
      required  this.shipmentId,
      required this.waybillNo,
      this.shipmentDate,
      this.carrier,
      this.trackingNo,
      required this.state,
      required  this.senderName,
      this.senderErpId,
      required  this.products,
    });

    factory Shipment.fromJson(String str) => Shipment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Shipment.fromMap(Map<String, dynamic> json) => Shipment(
        shipmentId: json["shipment_id"],
        waybillNo: json["waybill_no"],
        shipmentDate: DateTime.parse(json["shipment_date"]),
        carrier: json["carrier"],
        trackingNo: json["tracking_no"],
        state: json["state"],
        senderName: json["sender_name"],
        senderErpId: json["sender_erp_id"],
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "shipment_id": shipmentId,
        "waybill_no": waybillNo,
        "shipment_date": "${shipmentDate?.year.toString().padLeft(4, '0')}-${shipmentDate?.month.toString().padLeft(2, '0')}-${shipmentDate?.day.toString().padLeft(2, '0')}",
        "carrier": carrier,
        "tracking_no": trackingNo,
        "state": state,
        "sender_name": senderName,
        "sender_erp_id": senderErpId,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };

  @override
  String toString() {
    return 'Shipment{shipmentId: $shipmentId, waybillNo: $waybillNo, shipmentDate: $shipmentDate, carrier: $carrier, trackingNo: $trackingNo, state: $state, senderName: $senderName, senderErpId: $senderErpId, products: $products}';
  }
}

class Product {
    int orderId;
    String ?orderPoNo;
    int productsProposalId;
    String ?name;
    int ?categoryId;
    String ?categoryErpId;
    String ?description;
    double shippedAmount;
    String ?unit;
    double ?price;
    String ?currencyCode;
    String ?erpId;
    String ?productErpId;
    String ?proposalNote;

    Product({
      required  this.orderId,
      this.orderPoNo,
      required this.productsProposalId,
      required this.name,
      this.categoryId,
      required this.categoryErpId,
      this.description,
      required this.shippedAmount,
      required this.unit,
      required this.price,
      required this.currencyCode,
      this.erpId,
      this.productErpId,
      this.proposalNote,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        orderId: json["order_id"],
        orderPoNo: json["order_po_no"],
        productsProposalId: json["products_proposal_id"],
        name: json["name"],
        categoryId: json["category_id"],
        categoryErpId: json["category_erp_id"],
        description: json["description"],
        shippedAmount: json["shipped_amount"],
        unit: json["unit"],
        price: json["price"],
        currencyCode: json["currency_code"],
        erpId: json["erp_id"],
        productErpId: json["product_erp_id"],
        proposalNote: json["proposal_note"],
    );

    Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "order_po_no": orderPoNo,
        "products_proposal_id": productsProposalId,
        "name": name,
        "category_id": categoryId,
        "category_erp_id": categoryErpId,
        "description": description,
        "shipped_amount": shippedAmount,
        "unit": unit,
        "price": price,
        "currency_code": currencyCode,
        "erp_id": erpId,
        "product_erp_id": productErpId,
        "proposal_note": proposalNote,
    };

  @override
  String toString() {
    return 'Product{orderId: $orderId, orderPoNo: $orderPoNo, productsProposalId: $productsProposalId, name: $name, categoryId: $categoryId, categoryErpId: $categoryErpId, description: $description, shippedAmount: $shippedAmount, unit: $unit, price: $price, currencyCode: $currencyCode, erpId: $erpId, productErpId: $productErpId, proposalNote: $proposalNote}';
  }  
}
