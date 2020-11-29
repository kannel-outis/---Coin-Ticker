import './coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'price_viewModel.dart';
import 'models/states.dart';

final homeProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel();
});
final futureProvider = FutureProvider.autoDispose<States>((ref) async {
  return await ref.watch(homeProvider).consumerFuture();
});

class PriceScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeViewModel = watch(homeProvider);
    final future = watch(futureProvider);
    Widget androidDropDown() {
      return DropdownButton(
        value: homeViewModel.selectedCurrency,
        items: CoinData.currenciesList
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: homeViewModel.onChanged,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          future.when(
              data: (data) {
                // print(item.where((element) => element.));
                if (data == null)
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Null",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                      child: Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 28.0),
                            child: Text(
                              '1 BTC = ${data.currencyPrice.substring(0, 8).toMoney()} ${homeViewModel.selectedCurrency}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                      child: Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 28.0),
                            child: Text(
                              '1 ETH = ${data.ecurrencyPrice.substring(0, 8).toMoney()} ${homeViewModel.selectedCurrency}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                      child: Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 28.0),
                            child: Text(
                              '1 XRP = ${data.xcurrencyPrice.substring(0, 8).toMoney()} ${homeViewModel.selectedCurrency}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              error: (o, s) => Expanded(
                    child: Center(
                      child: Text(
                        o.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropDown(),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String toMoney() {
    int number = 0;
    if (!this.contains(".")) {
      List<String> characters = this.toString().split("").reversed.toList();
      for (var i = 0; i < characters.length; i++) {
        if (i % 4 == 0) {
          characters.insert(i, ",");
          number++;
        }
      }
      return characters.reversed
          .join()
          .substring(0, this.toString().length + number - 1);
    } else {
      List<String> cha = this.split(".").toList();
      List<String> characters = cha[0].split("").reversed.toList();
      for (var i = 0; i < characters.length; i++) {
        if (i % 4 == 0) {
          characters.insert(i, ",");
          number++;
        }
      }
      return characters.reversed
              .join()
              .substring(0, this.length + number - cha[1].length - 2) +
          (".${cha[1]}");
    }
  }
}
