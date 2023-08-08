// To parse this JSON data, do
//
//     final shipment = shipmentFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Shipment shipmentFromMap(String str) => Shipment.fromMap(json.decode(str));

String shipmentToMap(Shipment data) => json.encode(data.toMap());

class Shipment {
    final int? shipmentId;
    final String? waybillNo;
    final DateTime? shipmentDate;
    final String? carrier;
    final String? trackingNo;
    final String? state;
    final String? senderName;
    final String? senderErpId;
    final int? proposalId;
    final String? address;
    final String? paymentType;
    final int? paymentDueDate;
    final bool? includeShipmentCost;
    final String? demandListName;
    final List<Product> products;

    Shipment({
        this.shipmentId,
        this.waybillNo,
        this.shipmentDate,
        this.carrier,
        this.trackingNo,
        this.state,
        this.senderName,
        this.senderErpId,
        this.proposalId,
        this.address,
        this.paymentType,
        this.paymentDueDate,
        this.includeShipmentCost,
        this.demandListName,
        required this.products,
    });

    factory Shipment.fromMap(Map<String, dynamic> json) => Shipment(
        shipmentId: json["shipment_id"],
        waybillNo: json["waybill_no"],
        shipmentDate: json["shipment_date"],
        carrier: json["carrier"],
        trackingNo: json["tracking_no"],
        state: json["state"],
        senderName: json["sender_name"],
        senderErpId: json["sender_erp_id"],
        proposalId: json["proposal_id"],
        address: json["address"],
        paymentType: json["payment_type"],
        paymentDueDate: json["payment_due_date"],
        includeShipmentCost: json["include_shipment_cost"],
        demandListName: json["demand_list_name"],
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "shipment_id": shipmentId,
        "waybill_no": waybillNo,
        "shipment_date": shipmentDate,
        "carrier": carrier,
        "tracking_no": trackingNo,
        "state": state,
        "sender_name": senderName,
        "sender_erp_id": senderErpId,
        "proposal_id": proposalId,
        "address": address,
        "payment_type": paymentType,
        "payment_due_date": paymentDueDate,
        "include_shipment_cost": includeShipmentCost,
        "demand_list_name": demandListName,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };
}

class Product {
    final int? orderId;
    final String? orderPoNo;
    final int? productsProposalId;
    final String? name;
    final int? categoryId;
    final String? categoryErpId;
    final String? description;
    final double? shippedAmount;
    final String? unit;
    final double? price;
    final int? taxRate;
    final String? currencyCode;
    final String? erpId;
    final String? productErpId;
    final String? proposalNote;

    Product({
        required this.orderId,
        required this.orderPoNo,
        required this.productsProposalId,
        required this.name,
        required this.categoryId,
        required this.categoryErpId,
        required this.description,
        required this.shippedAmount,
        required this.unit,
        required this.price,
        required this.taxRate,
        required this.currencyCode,
        required this.erpId,
        required this.productErpId,
        required this.proposalNote,
    });

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
        taxRate: json["tax_rate"],
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
        "tax_rate": taxRate,
        "currency_code": currencyCode,
        "erp_id": erpId,
        "product_erp_id": productErpId,
        "proposal_note": proposalNote,
    };
}
