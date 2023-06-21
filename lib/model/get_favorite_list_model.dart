// To parse this JSON data, do
//
//     final getFavoriteListModel = getFavoriteListModelFromMap(jsonString);

import 'dart:convert';

class GetFavoriteListModel {
    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? deliveryDate;
    DateTime? validDate;
    bool? urgent;
    bool? includeShipmentCost;
    int? paymentDueDate;
    bool? favorite;
    String? state;
    int? demandNo;
    dynamic deletedAt;
    int? createdBy;
    int? procurementId;
    dynamic supervisorId;
    int? companyId;
    dynamic costCenterId;
    List<Product>? products;

    GetFavoriteListModel({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deliveryDate,
        this.validDate,
        this.urgent,
        this.includeShipmentCost,
        this.paymentDueDate,
        this.favorite,
        this.state,
        this.demandNo,
        this.deletedAt,
        this.createdBy,
        this.procurementId,
        this.supervisorId,
        this.companyId,
        this.costCenterId,
        this.products,
    });

    factory GetFavoriteListModel.fromJson(String str) => GetFavoriteListModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetFavoriteListModel.fromMap(Map<String, dynamic> json) => GetFavoriteListModel(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
        validDate: json["valid_date"] == null ? null : DateTime.parse(json["valid_date"]),
        urgent: json["urgent"],
        includeShipmentCost: json["include_shipment_cost"],
        paymentDueDate: json["payment_due_date"],
        favorite: json["favorite"],
        state: json["state"],
        demandNo: json["demand_no"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        procurementId: json["procurement_id"],
        supervisorId: json["supervisor_id"],
        companyId: json["company_id"],
        costCenterId: json["cost_center_id"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "delivery_date": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "valid_date": "${validDate!.year.toString().padLeft(4, '0')}-${validDate!.month.toString().padLeft(2, '0')}-${validDate!.day.toString().padLeft(2, '0')}",
        "urgent": urgent,
        "include_shipment_cost": includeShipmentCost,
        "payment_due_date": paymentDueDate,
        "favorite": favorite,
        "state": state,
        "demand_no": demandNo,
        "deleted_at": deletedAt,
        "created_by": createdBy,
        "procurement_id": procurementId,
        "supervisor_id": supervisorId,
        "company_id": companyId,
        "cost_center_id": costCenterId,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
    };
}

class Product {
    int? productId;
    String? name;
    dynamic acceptedAmount;
    int? categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic price;
    bool? checked;
    String? productState;
    dynamic unit;
    dynamic url;
    int? currency;
    dynamic requesterAmount;
    dynamic goodsAccept;
    String? description;
    dynamic companyProductId;
    String? erpId;
    String? productErpId;
    dynamic requesterAmountInitial;

    Product({
        this.productId,
        this.name,
        this.acceptedAmount,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.price,
        this.checked,
        this.productState,
        this.unit,
        this.url,
        this.currency,
        this.requesterAmount,
        this.goodsAccept,
        this.description,
        this.companyProductId,
        this.erpId,
        this.productErpId,
        this.requesterAmountInitial,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        name: json["name"],
        acceptedAmount: json["accepted_amount"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        price: json["price"],
        checked: json["checked"],
        productState: json["product_state"],
        unit: json["unit"],
        url: json["url"],
        currency: json["currency"],
        requesterAmount: json["requester_amount"],
        goodsAccept: json["goods_accept"],
        description: json["description"],
        companyProductId: json["company_product_id"],
        erpId: json["erp_id"],
        productErpId: json["product_erp_id"],
        requesterAmountInitial: json["requester_amount_initial"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "name": name,
        "accepted_amount": acceptedAmount,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "price": price,
        "checked": checked,
        "product_state": productState,
        "unit": unit,
        "url": url,
        "currency": currency,
        "requester_amount": requesterAmount,
        "goods_accept": goodsAccept,
        "description": description,
        "company_product_id": companyProductId,
        "erp_id": erpId,
        "product_erp_id": productErpId,
        "requester_amount_initial": requesterAmountInitial,
    };
}
