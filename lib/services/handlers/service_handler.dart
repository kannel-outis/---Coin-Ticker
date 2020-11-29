import 'package:bit_app/models/states.dart';
import 'package:bit_app/services/helpers/helper.dart';

class ServiceHandler {
  final serviceHelper = ServiceHelper();
  Future<States> handleResponse({String selectedCurrency}) async {
    String url =
        "https://api.nomics.com/v1/currencies/ticker?key=b4404340260dd18a038a00e1779886ba&ids=BTC,ETH,XRP&interval=1d,30d&convert=$selectedCurrency";
    var helper = await serviceHelper.getResponse(url: url);
    return helper;
  }
}
