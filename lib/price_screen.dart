import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List btcData = ['?', '?', '?'];
  CoinData coinData = CoinData();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    // dropdown menu items creating with currency data from coin_data
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        getData();
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart
  void getData() async {
    var data = await coinData.getCoinData(selectedCurrency);
    //var rate = data['rate'].toInt();
    //rate = rate.toString();
    setState(() {
      for (int i = 0; i < 3; i++) {
        var temp = data[i]['rate'].toStringAsFixed(0);
        btcData[i] = temp;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //TODO: Call getData() when the screen loads up.
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          listofCoinCard(btcData, cryptoList, selectedCurrency),
/*           Column(
            children: [
              
              // CoinCard(
              //     btcData: btcData[0],
              //     coinData: cryptoList[0],
              //     selectedCurrency: selectedCurrency,
              //   ),
              // CoinCard(
              //   btcData: btcData[1],
              //   coinData: cryptoList[1],
              //   selectedCurrency: selectedCurrency,
              // ),
              // CoinCard(
              //   btcData: btcData[2],
              //   coinData: cryptoList[2],
              //   selectedCurrency: selectedCurrency,
              // ),
            ],
          ), */
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

Widget listofCoinCard(List btcData, List cryptoList, String selectedCurrency) {
  List<Widget> list = [];
  for (var i = 0; i < btcData.length; i++) {
    list.add(
      CoinCard(
          btcData: btcData[i],
          coinData: cryptoList[i],
          selectedCurrency: selectedCurrency),
    );
  }
  return Column(
      // gap between lines
      children: list);
}

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key? key,
    required this.btcData,
    required this.coinData,
    required this.selectedCurrency,
  }) : super(key: key);

  final String btcData;
  final String coinData;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $coinData = $btcData $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
