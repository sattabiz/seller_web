

import 'dart:convert';

class CurrentUserInfoModel {
    int? status;
    String? responseMessage;
    String? requestId;
    CurrentUser? currentUser;
    Company? company;

    CurrentUserInfoModel({
        this.status,
        this.responseMessage,
        this.requestId,
        this.currentUser,
        this.company,
    });

    factory CurrentUserInfoModel.fromJson(String str) => CurrentUserInfoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CurrentUserInfoModel.fromMap(Map<String, dynamic> json) => CurrentUserInfoModel(
        status: json["status"],
        responseMessage: json["response_message"],
        requestId: json["request_id"],
        currentUser: json["current_user"] == null ? null : CurrentUser.fromMap(json["current_user"]),
        company: json["company"] == null ? null : Company.fromMap(json["company"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "response_message": responseMessage,
        "request_id": requestId,
        "current_user": currentUser?.toMap(),
        "company": company?.toMap(),
    };
}

class Company {
    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? contactConfirmed;
    DateTime ?deletedAt;
    String? confirmed;
    String ?fullName;
    String? phone;
    String? address;
    String? city;
    String? taxOffice;
    String? taxId;
    String? registrationNumber;
    String ?companyIdY;
    bool? addSupplier;
    String? state;
    bool? dbs;
    String ?buyerRef;
    String ?sellerRef;
    int ?adderUserId;
    int ?adderCompanyId;
    String? website;
    int ?invitedCompanyId;
    String ?inviteToken;
    String ?defaultBuyerUser;
    int ?parentId;
    bool? visibleInSearch;
    bool? supplierFinancing;
    int ?supervisorId;
    int ?procurementId;
    int ?companyId;
    bool? sellerPoint;
    bool? webContentApproved;

    Company({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.contactConfirmed,
        this.deletedAt,
        this.confirmed,
        this.fullName,
        this.phone,
        this.address,
        this.city,
        this.taxOffice,
        this.taxId,
        this.registrationNumber,
        this.companyIdY,
        this.addSupplier,
        this.state,
        this.dbs,
        this.buyerRef,
        this.sellerRef,
        this.adderUserId,
        this.adderCompanyId,
        this.website,
        this.invitedCompanyId,
        this.inviteToken,
        this.defaultBuyerUser,
        this.parentId,
        this.visibleInSearch,
        this.supplierFinancing,
        this.supervisorId,
        this.procurementId,
        this.companyId,
        this.sellerPoint,
        this.webContentApproved,
    });

    factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Company.fromMap(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        contactConfirmed: json["contact_confirmed"],
        deletedAt: json["deleted_at"],
        confirmed: json["confirmed"],
        fullName: json["full_name"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        taxOffice: json["tax_office"],
        taxId: json["tax_id"],
        registrationNumber: json["registration_number"],
        companyIdY: json["company_id_y"],
        addSupplier: json["add_supplier"],
        state: json["state"],
        dbs: json["dbs"],
        buyerRef: json["buyer_ref"],
        sellerRef: json["seller_ref"],
        adderUserId: json["adder_user_id"],
        adderCompanyId: json["adder_company_id"],
        website: json["website"],
        invitedCompanyId: json["invited_company_id"],
        inviteToken: json["invite_token"],
        defaultBuyerUser: json["default_buyer_user"],
        parentId: json["parent_id"],
        visibleInSearch: json["visible_in_search"],
        supplierFinancing: json["supplier_financing"],
        supervisorId: json["supervisor_id"],
        procurementId: json["procurement_id"],
        companyId: json["company_id"],
        sellerPoint: json["seller_point"],
        webContentApproved: json["web_content_approved"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "contact_confirmed": contactConfirmed,
        "deleted_at": deletedAt,
        "confirmed": confirmed,
        "full_name": fullName,
        "phone": phone,
        "address": address,
        "city": city,
        "tax_office": taxOffice,
        "tax_id": taxId,
        "registration_number": registrationNumber,
        "company_id_y": companyIdY,
        "add_supplier": addSupplier,
        "state": state,
        "dbs": dbs,
        "buyer_ref": buyerRef,
        "seller_ref": sellerRef,
        "adder_user_id": adderUserId,
        "adder_company_id": adderCompanyId,
        "website": website,
        "invited_company_id": invitedCompanyId,
        "invite_token": inviteToken,
        "default_buyer_user": defaultBuyerUser,
        "parent_id": parentId,
        "visible_in_search": visibleInSearch,
        "supplier_financing": supplierFinancing,
        "supervisor_id": supervisorId,
        "procurement_id": procurementId,
        "company_id": companyId,
        "seller_point": sellerPoint,
        "web_content_approved": webContentApproved,
    };
}

class CurrentUser {
    int? id;
    String? email;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? userType;
    int? companyId;
    dynamic deletedAt;
    String? fullName;
    dynamic phone;
    dynamic state;
    String? jti;
    dynamic invitedCompanyId;
    dynamic costCenterId;
    String? sessionToken;

    CurrentUser({
        this.id,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.userType,
        this.companyId,
        this.deletedAt,
        this.fullName,
        this.phone,
        this.state,
        this.jti,
        this.invitedCompanyId,
        this.costCenterId,
        this.sessionToken,
    });

    factory CurrentUser.fromJson(String str) => CurrentUser.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CurrentUser.fromMap(Map<String, dynamic> json) => CurrentUser(
        id: json["id"],
        email: json["email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        userType: json["user_type"],
        companyId: json["company_id"],
        deletedAt: json["deleted_at"],
        fullName: json["full_name"],
        phone: json["phone"],
        state: json["state"],
        jti: json["jti"],
        invitedCompanyId: json["invited_company_id"],
        costCenterId: json["cost_center_id"],
        sessionToken: json["session_token"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_type": userType,
        "company_id": companyId,
        "deleted_at": deletedAt,
        "full_name": fullName,
        "phone": phone,
        "state": state,
        "jti": jti,
        "invited_company_id": invitedCompanyId,
        "cost_center_id": costCenterId,
        "session_token": sessionToken,
    };
}
