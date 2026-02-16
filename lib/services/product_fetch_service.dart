import 'dart:convert';
import 'package:http/http.dart' as dart;
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:price_scrapper/model/product_model.dart';

class ProductFetchService {
  static const String baseUrl =
      "https://price-scraper-backend.onrender.com/api/products";

  Future<List<Product>> fetchProduct(String userEmail) async {
    final url = Uri.parse("$baseUrl?userEmail=$userEmail");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final List productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("failed ");
      }
    } else {
      throw Exception("server failed ");
    }
  }
}
