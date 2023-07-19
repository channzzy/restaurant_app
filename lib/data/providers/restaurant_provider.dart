import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/list_resaturant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider with ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _retriveData();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  RestaurantsResult get result => _restaurantsResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _retriveData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.retriveData();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
