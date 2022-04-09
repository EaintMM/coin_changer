import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '2A339C09-FE35-49DF-BF37-D1370B3329CF';

class CoinData {
  //TODO: Create your getCoinData() method here.
  Future getCoinData(String selectedCurrency) async {
    List data = [];
    for (String crypto in cryptoList) {
      var url =
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');
      var response = await http.get(url);
      var coinData = jsonDecode(response.body);
      print('rate ${coinData['rate']}');
      data.add(coinData);
    }
    return data;
  }
}
