import 'package:dio/dio.dart';
import 'dart:convert';

Future<Response> performRiskPrediction(Map<String, dynamic> map) async {
  final dio = Dio();
  Response? responses;
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'ngrok-skip-browser-warning': '69'
  };
  Map<String, int> genderKey = {'Female': 0, 'Male': 1};

  Map<String, int> marritalKey = {
    'Civil marriage': 0,
    'Married': 1,
    'Separated': 2,
    'Single / not married': 3,
    'Unknown': 4,
    'Widow': 5
  };
  Map<String, int> occupationKey = {
    'Businessman': 0,
    'Commercial associate': 1,
    'Maternity leave': 2,
    'Pensioner': 3,
    'State servant': 4,
    'Student': 5,
    'Unemployed': 6,
    'Working': 7
  };
  Map<String, int> loanTypeKey = {'Cash loans': 0, 'Resolving loans': 1};

  Map<String, int> educationKey = {
    'Academic degree': 0,
    'Higher education': 1,
    'Incomplete higher': 2,
    'Lower secondary': 3,
    'Secondary / secondary special': 4
  };

  final data = {
    "Cluster": 0,
    "Unnamed": 0,
    "LOAN_TYPE": loanTypeKey[map['loanType']],
    "GENDER": genderKey[map['gender']],
    "OWN_CAR": map['ownCar'] == true ? 1 : 0,
    "OWN_HOUSE": map['ownHouse'] == true ? 1 : 0,
    "CNT_CHILDREN": map['kidsCount'],
    "ANNUAL_INCOME": int.parse(map['annualIncome']),
    "LOAN_AMOUNT": int.parse(map['loanAmount']),
    "LOAN_ANNUITY": int.parse(map['loanAnnuity']),
    "NAME_INCOME_TYPE": occupationKey[map['incomeType']],
    "NAME_EDUCATION_TYPE": educationKey[map['education']],
    "MARITAL_STATUS": marritalKey[map['isMarried']],
    "OCCUPATION": occupationKey[map['occupation']],
    "Age": map['age'],
  };

  try {
    final response = await dio.post(
      'https://7d3c-117-203-246-41.ngrok-free.app/predict/',
      data: jsonEncode(data),
      options: Options(headers: headers),
    );
    print('ancd');
    if (response.statusCode == 200) {
      responses = response;
      print(response.data);
    } else {
      print(response.statusMessage);
    }
  } catch (e) {
    print('Error: $e');
  }
  return responses!;
}

Future<String> fetchConsentUrl() async {
  String consentUrl = '';
  final dio = Dio();
  try {
    final response = await dio.post(
      'https://fiu-uat.setu.co/consents',
      options: Options(
        headers: {
          'x-client-id': 'a4f812b8-1c90-4222-bd84-995eb7a8f84f',
          'x-client-secret': 'c88b1e2d-54f5-4589-b27e-becf54fbee59',
        },
      ),
      data: {
        "Detail": {
          "consentStart": "2024-02-14T11:28:06.983Z",
          "consentExpiry": "2025-04-23T05:44:53.822Z",
          "Customer": {"id": "9084034365@onemoney"},
          "FIDataRange": {
            "from": "2020-04-01T00:00:00Z",
            "to": "2023-01-01T00:00:00Z"
          },
          "consentMode": "STORE",
          "consentTypes": ["TRANSACTIONS", "PROFILE", "SUMMARY"],
          "fetchType": "PERIODIC",
          "Frequency": {"value": 30, "unit": "MONTH"},
          "DataFilter": [
            {"type": "TRANSACTIONAMOUNT", "value": "5000", "operator": ">="}
          ],
          "DataLife": {"value": 1, "unit": "MONTH"},
          "DataConsumer": {"id": "setu-fiu-id"},
          "Purpose": {
            "Category": {"type": "string"},
            "code": "101",
            "text": "Loan underwriting",
            "refUri": "https://api.rebit.org.in/aa/purpose/101.xml"
          },
          "fiTypes": ["DEPOSIT", "EQUITIES"]
        },
        "redirectUrl": "https://setu.co",
        "context": [
          {"key": "accounttype", "value": "SAVINGS"}
        ]
      },
    );

    if (response.statusCode == 201) {
      consentUrl = response.data['url'];
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return consentUrl;
}

Future<Map> fetchFinanceData() async {
  final dio = Dio();
  var data;
  final String apiKey = '4d16c1d826mshdae427337211a39p181c3djsn253015b2d479';

  dio.options.headers['X-RapidAPI-Key'] = apiKey;
  dio.options.headers['X-RapidAPI-Host'] =
      'apidojo-yahoo-finance-v1.p.rapidapi.com';

  try {
    final response = await dio.get(
      'https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-recommendations',
      queryParameters: {
        'symbol': 'INTC',
      },
    );
    data = response.data;
    print(response.data);
  } catch (error) {
    print(error);
  }
  return data;
}
