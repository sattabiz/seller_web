import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/create_proposal_model.dart';
import '../storage/jwt_storage.dart';
import '../view/create_proposal_view/create_proposal_view_content.dart';
import '../view/create_proposal_view/create_proposal_view_table.dart';


class createProposalService {
  static const String _url =
      "https://test.satta.biz/api/v1/demand_proposal.json";

  Future<CreateProposalModel> createProposlPost(List<FormItem> _formItems, OfferModel _contentItems    ) async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;  //this code can make more secure
    List<CreateProposalModel> _list = [];
    final _jwt = await jwtStorageService().getJwtData();

    // Creating the products_attributes map
    Map<String, dynamic> _productsAttributes = {};
    for (int i = 0; i < _formItems.length; i++) {
      _productsAttributes['$i'] = {
        "category_name": _formItems[i].category,
        "name": _formItems[i].product,
        "requester_amount": _formItems[i].amount,
        // You need to fill the remaining fields with your own values
        "description": "High Quality",
        "unit": "AD",
        "price": 100,
        "currency_code": "TRY",
        "erp_id": 500,
        "product_erp_id": 200
      };
    }

    var response = await dio.post(
      _url,
      options: Options(
        headers: {
          "Authorization": _jwt,
        },
      ),
      data: {
        "company_erp_ids": [["123","test7"]],
        "valid_days": _contentItems.validDays,
        "demand_list": {
          "delivery_date": _contentItems.deliveryDate,
          "name": _contentItems.name,
          "requester": "sattadestek10@satta.biz",
          "demand_no":"487",    //apiden gelmesi lazim  
          "products_attributes": _productsAttributes 
        }
      }
    );
    
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then parse the JSON.
      return CreateProposalModel.fromMap(response.data);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Proposal');
    }
    
  }
}
