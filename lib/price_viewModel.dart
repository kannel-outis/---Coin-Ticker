import 'package:bit_app/models/states.dart';
import 'package:flutter/foundation.dart';
import 'services/handlers/service_handler.dart';

class HomeViewModel extends ChangeNotifier {
  final _serviceHandler = ServiceHandler();
  String _selectedCurrency = "USD";
  String get selectedCurrency => _selectedCurrency;
  void onChanged(String value) {
    _selectedCurrency = value;
    notifyListeners();
  }

  Future<States> consumerFuture() async {
    return await _serviceHandler.handleResponse(
        selectedCurrency: _selectedCurrency);
  }
}
