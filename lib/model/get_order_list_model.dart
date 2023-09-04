import 'dart:convert';

class GetOrderlistModel {
    GetOrderlistModel({
        required this.id,
        required this.proposalId,
        required this.companyId,
        required this.supplier,
        required this.supplierErpId, 
        this.supplierTaxId,
        required this.state,
        this.includeShipmentCost,
        required this.deliveryDate,
        required this.paymentDueDate,
        required this.paymentType,
        required this.orderDate,
        required this.demandName,
        required this.demandNo,
        required this.demandCreatorName,
        required this.demandCreatorEmail,
        required this.procurementName,
        required this.procurementEmail,
        this.costCenterName,
        this.costCenterErpId,
        this.approvers,
        required this.products,
    });

    int ?id;
    int ?proposalId;
    int ?companyId;
    String ?supplier;
    String ?supplierErpId;
    String ?supplierTaxId;
    String ?state;
    DateTime ?deliveryDate;
    int ?paymentDueDate;
    dynamic paymentType;
    DateTime ?orderDate;
    String ?demandName;
    int ?demandNo;
    bool? includeShipmentCost;
    String ?demandCreatorName;
    String ?demandCreatorEmail;
    String ?procurementName;
    String ?procurementEmail;
    String ?costCenterName;
    String ?costCenterErpId;
    List<Approver> ?approvers;
    List<Product> products;

    factory GetOrderlistModel.fromJson(String str) => GetOrderlistModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetOrderlistModel.fromMap(Map<String, dynamic> json) => GetOrderlistModel(
        id: json["id"],
        proposalId: json["proposal_id"],
        companyId: json["company_id"],
        supplier: json["supplier"],
        supplierErpId: json["supplier_erp_id"],
        supplierTaxId: json["supplier_tax_id"],
        state: json["state"],
        deliveryDate: json["delivery_date"] != null ? DateTime.parse(json["delivery_date"]) : null,
        paymentDueDate: json["payment_due_date"],
        paymentType: json["payment_type"],
        orderDate: DateTime.parse(json["order_date"]),
        demandName: json["demand_name"],
        demandNo: json["demand_no"],
        includeShipmentCost: json["include_shipment_cost"],
        demandCreatorName: json["demand_creator_name"],
        demandCreatorEmail: json["demand_creator_email"],
        procurementName: json["procurement_name"],
        procurementEmail: json["procurement_email"],
        costCenterName: json["cost_center_name"],
        costCenterErpId: json["cost_center_erp_id"],
        approvers: List<Approver>.from(json["approvers"].map((x) => Approver.fromMap(x))),
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );
    
    

    Map<String, dynamic> toMap() => {
        "id": id,
        "proposal_id": proposalId,
        "company_id": companyId,
        "supplier": supplier,
        "supplier_erp_id": supplierErpId,
        "supplier_tax_id": supplierTaxId,
        "state": state,
        "delivery_date": deliveryDate!.toIso8601String(),
        "payment_due_date": paymentDueDate,
        "payment_type": paymentType,
        "order_date": orderDate!.toIso8601String(),
        "demand_name": demandName,
        "demand_no": demandNo,
        "demand_creator_name": demandCreatorName,
        "demand_creator_email": demandCreatorEmail,
        "include_shipment_cost": includeShipmentCost,
        "procurement_name": procurementName,
        "procurement_email": procurementEmail,
        "cost_center_name": costCenterName,
        "cost_center_erp_id": costCenterErpId,
        "approvers": List<dynamic>.from(approvers!.map((x) => x.toMap())),
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };


  @override
  String toString() {
    return 'GetOrderListModel{id: $id, proposalId: $proposalId, companyId: $companyId, supplier: $supplier, supplierErpId: $supplierErpId, supplierTaxId: $supplierTaxId, state: $state, deliveryDate: $deliveryDate, paymentDueDate: $paymentDueDate, paymentType: $paymentType, orderDate: $orderDate, demandName: $demandName, demandNo: $demandNo, demandCreatorName: $demandCreatorName, demandCreatorEmail: $demandCreatorEmail, procurementName: $procurementName, procurementEmail: $procurementEmail, costCenterName: $costCenterName, costCenterErpId: $costCenterErpId, includeShipmentCost:$includeShipmentCost approvers: $approvers, products: $products}';
  }  
}

class Approver {
    Approver({
        this.approverName,
        this.approverEmail,
        this.approvalDate,
    });

    String ?approverName;
    String ?approverEmail;
    DateTime ?approvalDate;

    factory Approver.fromJson(String str) => Approver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Approver.fromMap(Map<String, dynamic> json) => Approver(
        approverName: json["approver_name"],
        approverEmail: json["approver_email"],
        approvalDate: DateTime.parse(json["approval_date"]),
    );

    Map<String, dynamic> toMap() => {
        "approver_name": approverName,
        "approver_email": approverEmail,
        "approval_date": approvalDate!.toIso8601String(),
    };
}

class Product {
    Product({
        required this.productProposalId,
        required this.name,
        this.categoryId,
        this.categoryErpId,
        this.description,
        this.amount,
        this.sendedAmount,
        this.unit,
        this.price,
        this.taxRate,
        this.currencyCode,
        this.erpId,
        this.productErpId,
        this.proposalNote,
        this.productFiles
    });

    int productProposalId;
    String name;
    int ?categoryId;
    String ?categoryErpId;
    String ?description;
    double ?amount;
    double ?sendedAmount;
    String ?unit;
    double ?price;
    int ?taxRate;
    String ?currencyCode;
    String ?erpId;
    String ?productErpId;
    String ?proposalNote;
    Map? productFiles;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        productProposalId: json["product_proposal_id"],
        name: json["name"],
        categoryId: json["category_id"],
        categoryErpId: json["category_erp_id"],
        description: json["description"],
        amount: json["amount"].toDouble(),
        sendedAmount: json["sended_amount"],
        unit: json["unit"],
        price: json["price"].toDouble(),
        taxRate: json["tax_rate"],
        currencyCode: json["currency_code"],
        erpId: json["erp_id"],
        productErpId: json["product_erp_id"],
        proposalNote: json["proposal_note"],
        productFiles: json["product_files"]  
    );

    Map<String, dynamic> toMap() => {
        "product_proposal_id": productProposalId,
        "name": name,
        "category_id": categoryId,
        "category_erp_id": categoryErpId,
        "description": description,
        "amount": amount,
        'sended_amount': sendedAmount,
        "unit": unit,
        "price": price,
        "currency_code": currencyCode,
        "erp_id": erpId,
        "product_erp_id": productErpId,
        "proposal_note": proposalNote,
    };

  @override
  String toString() {
    return 'Product{productProposalId: $productProposalId, name: $name, categoryId: $categoryId, categoryErpId: $categoryErpId, description: $description, amount: $amount, taxRate: $taxRate, sendedAmount: $sendedAmount unit: $unit, price: $price, currencyCode: $currencyCode, erpId: $erpId, productErpId: $productErpId, proposalNote: $proposalNote}';
  }
}

