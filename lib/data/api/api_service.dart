import 'dart:convert';
import 'dart:io';

import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/list_resaturant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _list = 'list';
  static const String _detail = 'detail';
  // static final String _search = 'search?q=query';

  Future<RestaurantsResult> retriveData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + _list));
      if (response.statusCode == 200) {
        return RestaurantsResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurants list');
      }
    } on SocketException catch (_) {
      throw 'No Internet connection';
    }
  }

  Future<Restaurant> getDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl$_detail/$id'));
      if (response.statusCode == 200) {
        return Restaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurants');
      }
    } on SocketException catch (_) {
      throw 'No Internet connection';
    }
  }
}
