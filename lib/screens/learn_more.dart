import 'package:dio/dio.dart';
import 'package:fin_ease/style/color.dart';
import 'package:flutter/material.dart';

class FinanceDataPage extends StatelessWidget {
  FinanceDataPage({required this.apiResponse});

  final Map apiResponse;

  List<Map<String, dynamic>> getRecommendedStocks() {
    List<Map<String, dynamic>> recommendedStocks = [];

    if (apiResponse.containsKey('finance') &&
        apiResponse['finance'].containsKey('result') &&
        apiResponse['finance']['result'].isNotEmpty) {
      List<dynamic> quotes = apiResponse['finance']['result'][0]['quotes'];
      for (var quote in quotes) {
        recommendedStocks.add({
          "symbol": quote['symbol'],
          "shortName": quote['shortName'],
          "regularMarketPrice": quote['regularMarketPrice'],
          "regularMarketChangePercent": quote['regularMarketChangePercent'],
        });
      }
    }

    return recommendedStocks;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> recommendedStocks = getRecommendedStocks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Recommended Stocks',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: recommendedStocks.length,
          itemBuilder: (context, index) {
            final stock = recommendedStocks[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: primaryColor,
                elevation: 5,
                //shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    stock['shortName'],
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Price: ₹${stock['regularMarketPrice'] * 82}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Change: ${stock['regularMarketChangePercent']}%',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
