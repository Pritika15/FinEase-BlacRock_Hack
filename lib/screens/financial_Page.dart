import 'package:dio/dio.dart';
import 'package:fin_ease/screens/risk_page.dart';
import 'package:fin_ease/services/apis.dart';
import 'package:fin_ease/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  final _formKey = GlobalKey<FormState>();

  String _incomeType = 'Student';
  String _loanType = 'Cash loans';
  String _annualIncome = '0';
  String _loanAmount = '0';
  String _loanAnnuity = '0';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
                color: Colors.black54,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      Expanded(
                        child: ListView(
                          //    crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Some more info about your finances',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 228, 107, 249),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8, top: 8),
                              child: Text(
                                'Your Income type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 228, 107, 249),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.black,
                                decoration: InputDecoration(),
                                value: _incomeType,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'Businessman',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Businessman',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Commercial associate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Commercial associate',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Maternity leave',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Maternity leave',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Pensioner',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Pensioner',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'State servant',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'State servant',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Student',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Student',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Unemployed',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Unemployed',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Working',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Working',
                                  ),
                                ],
                                onChanged: (value) {
                                  _incomeType = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText: 'Annual income (in ₹)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your annual income';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _annualIncome = value!;
                                },
                                onChanged: (value) {
                                  _annualIncome = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Loan Details (if any)',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 228, 107, 249),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8, top: 8),
                              child: Text(
                                'Your Loan type',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 228, 107, 249),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.black,
                                decoration: InputDecoration(),
                                value: _loanType,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'Cash loans',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Cash loans',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Revolving loans',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: 'Revolving loans',
                                  ),
                                ],
                                onChanged: (value) {
                                  _loanType = value!;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText: 'Loan amount (in ₹)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your loan amount';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _loanAmount = value!;
                                },
                                onChanged: (value) {
                                  _loanAmount = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText: 'Loan annuity (in ₹)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your loan annuity';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _loanAnnuity = value!;
                                },
                                onChanged: (value) {
                                  _loanAnnuity = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async{
                            FirestoreService().updateUserFinProfile(
                                FirebaseAuth.instance.currentUser!.uid,
                                _incomeType,
                                _annualIncome,
                                _loanType,
                                _loanAmount,
                                _loanAnnuity);
                            FirestoreService().setFinancialInfoComplete(
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                         var  map=await FirestoreService().fetchUserData(
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                           Response response= await performRiskPrediction(map);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => RiskPage(riskLevel: response.data['predicted_risk_category'],))));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 5,
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Predict risk',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ))));
  }
}
