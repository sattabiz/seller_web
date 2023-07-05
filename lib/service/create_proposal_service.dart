import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/apiUrls.dart';
import '../model/create_proposal_model.dart';
import '../model/web_content_model.dart';
import '../storage/jwt_storage.dart';
import '../view/create_proposal_view/create_proposal_view_content.dart';
import '../view/create_proposal_view/create_proposal_view_table.dart';


class createProposalService {

  Future<CreateProposalModel> createProposlPost(List<FormItem> _formItems, OfferModel _contentItems, WebContentModel _company_id) async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;  //this code can make more secure
    List<CreateProposalModel> _list = [];
    final _jwt = await jwtStorageService().getJwtData();






    // Creating the products_attributes map
    Map<String, dynamic> _productsAttributes = {};
    for (int i = 0; i < _formItems.length; i++) {
      _productsAttributes['$i'] = {
        "category_name": _formItems[i].category.toString(),
        "name": _formItems[i].product.toString(),
        "description": "High Quality",
        "requester_amount": _formItems[i].amount,
      };
    }

    var response = await dio.post(
      ApiUrls.createProposal,
      options: Options(
        headers: {
          "Authorization": _jwt,
        },
      ),
      data: {
        "supplier_id": _company_id.companyId,
        "valid_days": _contentItems.validDays,
        "demand_list": {
          "delivery_date": _contentItems.deliveryDate.toString(),
          "name": _contentItems.name.toString(),
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
