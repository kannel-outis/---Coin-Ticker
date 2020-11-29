class States {
  final String currencyPrice;
  final String ecurrencyPrice;
  final String xcurrencyPrice;
  States({this.currencyPrice, this.ecurrencyPrice, this.xcurrencyPrice});

  States.fromMap(List<dynamic> map)
      : currencyPrice = map[0]['price'],
        ecurrencyPrice = map[1]['price'],
        xcurrencyPrice = map[2]['price'];

  @override
  String toString() {
    return "$currencyPrice , $ecurrencyPrice, $xcurrencyPrice";
  }
}
