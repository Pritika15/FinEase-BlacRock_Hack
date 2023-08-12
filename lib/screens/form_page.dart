import 'package:fin_ease/screens/financial_Page.dart';
import 'package:fin_ease/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _age = 0;
  String _education = 'Higher education';
  String _gender = 'Male';
  bool _isMarried = false;
  bool _isCar = false;
  bool _isHouse = false;
  String _occupation = 'Student';
  String _email = '';
  String _maritalStatus = 'Married';
  List<String> _genders = ['Male', 'Female', "Others"];
  int _kidsCount = 0;
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
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                                //    crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Tell us about yourself',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 107, 249),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        labelText: 'Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _name = value!;
                                      },
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        labelText: 'Age',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your age';
                                        }
                                        if (int.parse(value!) < 18) {
                                          return 'You must be at least 18 years old';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _age = int.parse(value!);
                                      },
                                      onChanged: (value) {
                                        _age = int.parse(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                        labelText: 'No of Kids',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your kids count';
                                        }

                                        return null;
                                      },
                                      onSaved: (value) {
                                        _kidsCount = int.parse(value!);
                                      },
                                      onChanged: (value) {
                                        _kidsCount = int.parse(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8, top: 8),
                                    child: Text(
                                      'Your education',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 107, 249),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.black,
                                      decoration: InputDecoration(),
                                      value: _education,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            'Secondary / secondary special',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value:
                                              'Secondary / secondary special',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Higher education',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Higher education',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Lower secondary',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Lower secondary',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Incomplete higher',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Incomplete higher',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Academic degree',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Academic degree',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        _education = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8, top: 8),
                                    child: Text(
                                      'Your marital status',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 107, 249),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.black,
                                      decoration: InputDecoration(),
                                      value: _maritalStatus,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            'Civil marriage',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Civil marriage',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Married',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Married',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Seperated',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Seperated',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Single / not married',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Single / not married',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Unknown',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Unknown',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Widow',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Widow',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        _maritalStatus = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8, top: 8),
                                    child: Text(
                                      'Your occupation',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 107, 249),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.black,
                                      decoration: InputDecoration(),
                                      value: _occupation,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            'Businessman',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Businessman',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Commercial associate',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Commercial associate',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Maternity leave',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Maternity leave',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Pensioner',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Pensioner',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'State servant',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'State servant',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Student',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Student',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Unemployed',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Unemployed',
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            'Working',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: 'Working',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        _occupation = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 228, 107, 249),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RadioGroup<String>.builder(
                                      textStyle: TextStyle(color: Colors.white),
                                      groupValue: _gender,
                                      onChanged: (value) => setState(() {
                                        _gender = value!;
                                      }),
                                      items: _genders,
                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Do you own a car?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        Checkbox(
                                          value: _isCar,
                                          onChanged: (value) {
                                            setState(() {
                                              _isCar = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Do you own a house?',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        Checkbox(
                                          value: _isHouse,
                                          onChanged: (value) {
                                            setState(() {
                                              _isHouse = value!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                         
                                FirestoreService().updateUserProfile(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    _name,
                                    _age,
                                    _education,
                                    _gender,
                                    _maritalStatus,
                                    _occupation,
                                    _kidsCount,
                                    _isHouse,
                                    _isCar);
                                FirestoreService().setPersonalInfoComplete(
                                  FirebaseAuth.instance.currentUser!.uid,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            FinancialPage())));
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
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ))))),
    );
  }
}
