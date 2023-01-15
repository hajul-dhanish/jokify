import 'dart:convert';

class ProductModel {
  String? statusCode;
  String? statusDescription;
  List<dynamic>? result;

  ProductModel({this.statusCode, this.statusDescription, this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['Status_Code'];
    statusDescription = json['Status_Description'];
    var body = jsonDecode(json["Result"].toString());
    List<dynamic> topCalegoryProdList = [];
    topCalegoryProdList = body;
    result = topCalegoryProdList;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_Code'] = this.statusCode;
    data['Status_Description'] = this.statusDescription;
    data['Result'] = this.result;
    return data;
  }
}
