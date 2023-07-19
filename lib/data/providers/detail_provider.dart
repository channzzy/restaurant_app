import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';

enum DetailState { loading, hasData, error }

class DetailProvider with ChangeNotifier {
  final ApiService apiService;

  DetailProvider({required this.apiService});

  late Restaurant _detail;
  late DetailState _state;
  late String _message = '';
  DetailState get state => _state;
  Restaurant get detail => _detail;
  String get message => _message;

  Future<void> getDetail(String id) async {
    _state = DetailState.loading;
    notifyListeners();
    try {
      final result = await apiService.getDetail(id);
      _detail = result;
      _state = DetailState.hasData;
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      _state = DetailState.error;
      notifyListeners();
    }
  }
}
