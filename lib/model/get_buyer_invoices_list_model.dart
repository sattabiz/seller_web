
import 'dart:convert';

class GetInvoicesModel {
    int? invoiceId;
    String? invoiceNo;
    int ?orderId;
    DateTime? invoiceDate;
    DateTime ?paymentDate;
    String ?paymentType;
    String? state;
    String ?note;
    bool? dbs;
    String? priceWithoutVat;
    String? totalTlPrice;
    String? sellerName;
    String ?sellerErpId;
    List<Product>? products;
    GetInvoicesModel({
        this.invoiceId,
        this.invoiceNo,
        this.orderId,
        this.invoiceDate,
        this.paymentDate,
        this.paymentType,
        this.state,
        this.note,
        this.dbs,
        this.priceWithoutVat,
        this.totalTlPrice,
        this.sellerName,
        this.sellerErpId,
        this.products,
    });

    factory GetInvoicesModel.fromJson(String str) => GetInvoicesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetInvoicesModel.fromMap(Map<String, dynamic> json) => GetInvoicesModel(
        invoiceId: json["invoice_id"],
        invoiceNo: json["invoice_no"],
        orderId: json["order_id"],
        invoiceDate: json["invoice_date"] == null ? null : DateTime.parse(json["invoice_date"]),
        paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
        paymentType: json["payment_type"],
        state: json["state"],
        note: json["note"],
        dbs: json["dbs"],
        priceWithoutVat: json["price_without_vat"],
        totalTlPrice: json["total_tl_price"],
        sellerName: json["seller_name"],
        sellerErpId: json["seller_erp_id"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "invoice_id": invoiceId,
        "invoice_no": invoiceNo,
        "order_id": orderId,
        "invoice_date": invoiceDate?.toIso8601String(),
        "payment_date": paymentDate,
        "payment_type": paymentType,
        "state": state,
        "note": note,
        "dbs": dbs,
        "price_without_vat": priceWithoutVat,
        "total_tl_price": totalTlPrice,
        "seller_name": sellerName,
        "seller_erp_id": sellerErpId,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
    };
  @override
  String toString() {
    return 'Invoice(invoiceId: $invoiceId, invoiceNo: $invoiceNo, orderId: $orderId, invoiceDate: $invoiceDate, paymentDate: $paymentDate, paymentType: $paymentType, state: $state, note: $note, dbs: $dbs, priceWithoutVat: $priceWithoutVat, totalTlPrice: $totalTlPrice, sellerName: $sellerName, sellerErpId: $sellerErpId, products: $products)';  
   }
}

class Product {
    int? orderId;
    String ?orderPoNo;
    int? productsProposalId;
    String? name;
    int? categoryId;
    String ?categoryErpId;
    String? description;
    double? amount;
    String? unit;
    double? price;
    String? currencyCode;
    String ?erpId;
    String ?productErpId;
    String ?proposalNote;
    Map? productFiles;
    Map? productsProposalFiles;

    Product({
        this.orderId,
        this.orderPoNo,
        this.productsProposalId,
        this.name,
        this.categoryId,
        this.categoryErpId,
        this.description,
        this.amount,
        this.unit,
        this.price,
        this.currencyCode,
        this.erpId,
        this.productErpId,
        this.proposalNote,
        this.productFiles,
        this.productsProposalFiles
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
        amount: json["shipped_amount"],
        unit: json["unit"],
        price: json["price"],
        currencyCode: json["currency_code"],
        erpId: json["erp_id"],
        productErpId: json["product_erp_id"],
        proposalNote: json["proposal_note"],
        productFiles: json["product_files"],
        productsProposalFiles: json['products_proposal_files'] 
    );

    Map<String, dynamic> toMap() => {
        "order_id": orderId,
        "order_po_no": orderPoNo,
        "products_proposal_id": productsProposalId,
        "name": name,
        "category_id": categoryId,
        "category_erp_id": categoryErpId,
        "description": description,
        "shipped_amount": amount,
        "unit": unit,
        "price": price,
        "currency_code": currencyCode,
        "erp_id": erpId,
        "product_erp_id": productErpId,
        "proposal_note": proposalNote,
    };
}
