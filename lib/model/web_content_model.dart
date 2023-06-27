// To parse this JSON data, do
//
//     final webContentModel = webContentModelFromMap(jsonString);

import 'dart:convert';

class WebContentModel {
    int? companyId;
    String? title;
    String? introduction;
    String? address;
    String? footer;
    String? bgImage;
    List<Product>? products;

    WebContentModel({
        this.companyId,
        this.title,
        this.introduction,
        this.address,
        this.footer,
        this.bgImage,
        this.products,
    });

    factory WebContentModel.fromJson(String str) => WebContentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WebContentModel.fromMap(Map<String, dynamic> json) => WebContentModel(
        companyId: json["company_id"],
        title: json["title"],
        introduction: json["introduction"],
        address: json["address"],
        footer: json["footer"],
        bgImage: json["bg_image"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "company_id": companyId,
        "title": title,
        "introduction": introduction,
        "address": address,
        "footer": footer,
        "bg_image": bgImage,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
    };
}

class Product {
    int? categoryId;
    String? productDetails;
    String? productImage;

    Product({
        this.categoryId,
        this.productDetails,
        this.productImage,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        categoryId: json["category_id"],
        productDetails: json["product_details"],
        productImage: json["product_image"],
    );

    Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "product_details": productDetails,
        "product_image": productImage,
    };
}
