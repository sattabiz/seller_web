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
    int ?demandNo;
    DateTime ?deletedAt;
    int? createdBy;
    int? procurementId;
    int ?supervisorId;
    int? companyId;
    int ?costCenterId;

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
        deletedAt: json["deleted_at"]== null ? null : DateTime.parse(json["deleted_at"]),
        createdBy: json["created_by"],
        procurementId: json["procurement_id"],
        supervisorId: json["supervisor_id"],
        companyId: json["company_id"],
        costCenterId: json["cost_center_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "delivery_date": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "valid_date": validDate?.toIso8601String(),
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
    };
}

