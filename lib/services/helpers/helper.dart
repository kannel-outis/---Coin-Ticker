import 'package:bit_app/models/states.dart';
import 'package:dio/dio.dart';

abstract class Helper {
  Future<States> getResponse({String url});
}

class ServiceHelper extends Helper {
  @override
  Future<States> getResponse({String url}) async {
    States states;
    try {
      var response = await Dio().get<List<dynamic>>(url);

      if (response.statusCode == 200) {
        states = States.fromMap(response.data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw Error("An Error Occured ! 🚫");
    }
    return states;
  }

  void makesense() {}
}

class Error {
  final String message;

  Error(this.message);

  @override
  String toString() {
    return '$message';
  }
}
