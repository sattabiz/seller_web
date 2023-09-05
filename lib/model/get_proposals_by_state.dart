import 'dart:convert';

class GetProposalModel {
  int? proposalId;
  int? demandlistId;
  DateTime? proposalCreatedAt;
  DateTime? proposalUpdatedAt;
  String? proposalState;
  int? proposalValidPeriod;
  int? proposalDeliveryTime;
  DateTime? proposalValidDate;
  bool? includeShipmentCost;
  int? paymentDueDate;
  DateTime? deliveryDate;
  String? supplierCompany;
  String? supplierErpId;
  int? supplierCompanyId;
  String? supervisor;
  String? paymentType;
  int updateCounter;
  String demandListName;
  List<ProductProposal>? productProposals;

  GetProposalModel({
    this.proposalId,
    this.demandlistId,
    this.proposalCreatedAt,
    this.proposalUpdatedAt,
    this.proposalState,
    this.proposalValidPeriod,
    this.proposalDeliveryTime,
    this.proposalValidDate,
    this.includeShipmentCost,
    this.paymentDueDate,
    this.deliveryDate,
    this.supplierCompany,
    this.supplierErpId,
    this.supplierCompanyId,
    this.supervisor,
    this.paymentType,
    this.productProposals,
    required this.updateCounter,
    required this.demandListName
  });

  @override
  String toString() {
    return 'GetProposalModel(proposalId: $proposalId, demandlistId: $demandlistId, proposalState: $proposalState, supplierCompany: $supplierCompany ,supplierCompany: $supplierCompany, productProposals: $productProposals, updateCounter: $updateCounter, demandListName: $demandListName )';
  }

  factory GetProposalModel.fromJson(String str) =>
      GetProposalModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProposalModel.fromMap(Map<String, dynamic> json) {
    return GetProposalModel(
      proposalId: json["proposal_id"],
      demandlistId: json["demandlist_id"],
      proposalCreatedAt: json["proposal_created_at"] == null
          ? null
          : DateTime.parse(json["proposal_created_at"]),
      proposalUpdatedAt: json["proposal_updated_at"] == null
          ? null
          : DateTime.parse(json["proposal_updated_at"]),
      proposalState: json["proposal_state"],
      proposalValidPeriod: json["proposal_valid_period"],
      proposalDeliveryTime: json["proposal_delivery_time"],
      proposalValidDate: json["proposal_valid_date"] == null
          ? null
          : DateTime.parse(json["proposal_valid_date"]),
      includeShipmentCost: json["include_shipment_cost"],
      paymentDueDate: json["payment_due_date"],
      deliveryDate: json["delivery_date"] == null
          ? null
          : DateTime.parse(json["delivery_date"]),
      supplierCompany: json["supplier_company"],
      supplierErpId: json["supplier_erp_id"],
      supplierCompanyId: json["supplier_company_id"],
      supervisor: json["supervisor"],
      paymentType: json["payment_type"],
      updateCounter: json["update_counter"],
      demandListName: json["demand_list_name"],
      productProposals: json["product_proposals"] == null
          ? null
          : List<ProductProposal>.from(json["product_proposals"]
              .map((x) => ProductProposal.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "proposal_id": proposalId,
      "demandlist_id": demandlistId,
      "proposal_created_at": proposalCreatedAt?.toIso8601String(),
      "proposal_updated_at": proposalUpdatedAt?.toIso8601String(),
      "proposal_state": proposalState,
      "proposal_valid_period": proposalValidPeriod,
      "proposal_delivery_time": proposalDeliveryTime,
      "proposal_valid_date": proposalValidDate?.toIso8601String(),
      "include_shipment_cost": includeShipmentCost,
      "payment_due_date": paymentDueDate,
      "delivery_date": deliveryDate?.toIso8601String(),
      "supplier_company": supplierCompany,
      "supplier_erp_id": supplierErpId,
      "supplier_company_id": supplierCompanyId,
      "supervisor": supervisor,
      "payment_type": paymentType,
      "update_counter": updateCounter,
      "demand_list_name": demandListName,
      "product_proposals": productProposals == null
          ? []
          : List<dynamic>.from(productProposals!.map((x) => x.toMap())),
    };
  }
}

class ProductProposal {
  int? productProposalId;
  String? productName;
  String? productCategory;
  String? productUnit;
  String? productErpId;
  String? erpId;
  int? companyProductId;
  DateTime? updatedAt;
  double? price;
  String? url;
  String? description;
  int? productId;
  String? status;
  int? updateCount;
  String? equivalentId;
  String? proposalNote;
  int? taxRate;
  String? currencyCode;
  double? amount;
  Map? productFiles;
  Map? productsProposalFiles;

  ProductProposal({
    this.productProposalId,
    this.productName,
    this.productCategory,
    this.productUnit,
    this.productErpId,
    this.erpId,
    this.companyProductId,
    this.updatedAt,
    this.price,
    this.url,
    this.description,
    this.productId,
    this.status,
    this.updateCount,
    this.equivalentId,
    this.proposalNote,
    this.taxRate,
    this.currencyCode,
    this.amount,
    this.productFiles,
    this.productsProposalFiles
  });

  @override
  String toString() {
    return 'ProductProposal(productProposalId: $productProposalId, productName: $productName, price: $price, url: $url, description: $description, productId: $productId, status: $status, updateCount: $updateCount, equivalentId: $equivalentId, proposalNote: $proposalNote, taxRate: $taxRate, currencyCode: $currencyCode, amount: $amount, productsProposalFiles: $productsProposalFiles)';
  }

  factory ProductProposal.fromJson(String str) =>
      ProductProposal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductProposal.fromMap(Map<String, dynamic> json) {
    return ProductProposal(
      productProposalId: json["product_proposal_id"],
      productName: json["product_name"],
      productCategory: json["product_category"],
      productUnit: json["product_unit"],
      productErpId: json["product_erp_id"],
      erpId: json["erp_id"],
      companyProductId: json["company_product_id"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      price: json["price"],
      url: json["url"],
      description: json["description"],
      productId: json["product_id"],
      status: json["status"],
      updateCount: json["update_count"],
      equivalentId: json["equivalent_id"],
      proposalNote: json["proposal_note"],
      taxRate: json["tax_rate"],
      currencyCode: json["currency_code"],
      amount: json["amount"],
      productFiles: json["product_files"],
      productsProposalFiles: json['products_proposal_files']      
      );
  }

  Map<String, dynamic> toMap() {
    return {
      "product_proposal_id": productProposalId,
      "product_name": productName,
      "product_category": productCategory,
      "product_unit": productUnit,
      "product_erp_id": productErpId,
      "erp_id": erpId,
      "company_product_id": companyProductId,
      "updated_at": updatedAt?.toIso8601String(),
      "price": price,
      "url": url,
      "description": description,
      "product_id": productId,
      "status": status,
      "update_count": updateCount,
      "equivalent_id": equivalentId,
      "proposal_note": proposalNote,
      "tax_rate": taxRate,
      "currency_code": currencyCode,
      "amount": amount,
    };
  }
}

