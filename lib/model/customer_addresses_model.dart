import 'dart:convert';

class CustomerAddresses {
    int? id;
    String? name;
    String? address;
    String? phone;

    CustomerAddresses({
        this.id,
        this.name,
        this.address,
        this.phone,
    });

    factory CustomerAddresses.fromJson(String str) => CustomerAddresses.fromMap(json.decode(str));


    factory CustomerAddresses.fromMap(Map<String, dynamic> json) => CustomerAddresses(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"]
    );
}
