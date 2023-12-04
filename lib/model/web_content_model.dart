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
    String? contactInfo;
    List<Product>? products;

    WebContentModel({
        this.companyId,
        this.title,
        this.introduction,
        this.address,
        this.footer,
        this.bgImage,
        this.contactInfo,
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
        contactInfo: json["contact_info"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "company_id": companyId,
        "title": title,
        "introduction": introduction,
        "address": address,
        "footer": footer,
        "bg_image": bgImage,
        "contact_info": contactInfo,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
    };

  @override
  String toString() {
    return 'WebContentModel(companyId: $companyId, title: $title, introduction: $introduction, address: $address, footer: $footer, bgImage: $bgImage, contactInfo: $contactInfo , products: $products)';
  }

}

class Product {
    int categoryId;
    String? title;
    String? unit;
    String? productDetails;
    String? productImage;

    Product({
        required this.categoryId,
        this.title,
        this.unit,
        this.productDetails,
        this.productImage,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        categoryId: json["category_id"],
        title: json["title"],
        unit: json['unit'],
        productDetails: json["product_details"],
        productImage: json["product_image"],
    );

    Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "title": title,
        "unit": unit,
        "product_details": productDetails,
        "product_image": productImage,
    };
    @override
    String toString() {
        return 'Product(categoryId: $categoryId, title: $title,unit: $unit, productDetails: $productDetails, productImage: $productImage)';
    }
}
