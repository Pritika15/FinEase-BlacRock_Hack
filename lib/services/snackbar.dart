import 'package:flutter/material.dart';

showSnackBar(String status, BuildContext context) {
  final snackBar = SnackBar(
      duration: Duration(milliseconds: 1250),
      content: Text(
        status,
        style: kSnackbarStyle,
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
const kSnackbarStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontFamily: 'Jose',
);