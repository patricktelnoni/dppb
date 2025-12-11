import 'package:http/http.dart' as http;
import 'package:dppb/data/Product.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


Future<List<Product>> getProductList() async {
  final token = await storage.read(key: 'access_token');
  final List<Product> daftarProduct = [];
  final url  = "https://palugada.me/api/products";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token', // Include the token in the header
    },
  );
  print(response.body);
  if(response.statusCode == 200 || response.statusCode == 201){
    final list = jsonDecode(response.body);
    for(var data in list['data']){
      daftarProduct.add(Product.fromJson(data));
    }
  }
  print(daftarProduct.length);
  return daftarProduct;
}