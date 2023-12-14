import 'dart:convert';

class CustomerAddresses {
    int? id;
    String? name;
    String? address;
    String? city;
    String? phone;

    CustomerAddresses({
        this.id,
        this.name,
        this.address,
        this.city,
        this.phone,
    });

    factory CustomerAddresses.fromJson(String str) => CustomerAddresses.fromMap(json.decode(str));


    factory CustomerAddresses.fromMap(Map<String, dynamic> json) => CustomerAddresses(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        phone: json["phone"]
    );

    String toJson() => json.encode(toMap());


    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "phone": phone,
    };

}
