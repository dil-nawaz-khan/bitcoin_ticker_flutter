import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  final String _baseUrl = 'https://api.coingecko.com/api/v3/simple/price';

  Future<double> fetchExchangeRate({
    required String crypto,
    required String currency,
  }) async {
    final String url = '$_baseUrl?ids=$crypto&vs_currencies=$currency';
    double exchangeRate = 0;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);

        // print(
        //   'Response: ${jsonResponse?[crypto.toLowerCase()]?[currency.toLowerCase()]}',
        // );

        exchangeRate =
            (jsonResponse?[crypto.toLowerCase()]?[currency.toLowerCase()]
                    as num?)
                ?.toDouble() ??
            0.0;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return exchangeRate;
  }
}
