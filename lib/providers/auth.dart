import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_ease/screens/financial_Page.dart';
import 'package:fin_ease/screens/form_page.dart';
import 'package:fin_ease/screens/setu_web.dart';
import 'package:fin_ease/services/apis.dart';
import 'package:fin_ease/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_page.dart';
import '../services/snackbar.dart';

class Auth extends ChangeNotifier {
  AuthCredential? _phoneAuthCredential;
  User? _firebaseUser;
  String? _verificationId;
  int? _code;
  String mobileNumber = 'Unknown';
  String otp = '';
  bool isLoading = false;
  addUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    bool exist = false;

    try {
      int flag = 0;
      await users.doc(user!.uid).get().then((doc) {
        exist = doc.exists;
        if (exist == true) {
          print('exist');
          users
              .doc(user.uid)
              .set({
                'name': user.displayName,
                'email': user.email,
                'phoneNo': user.phoneNumber,
              }, SetOptions(merge: true))
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        }
      });
    } catch (e) {
      // If any error
      exist = false;
      print(e);
    }
    if (exist == false) {
      users
          .doc(user!.uid)
          .set({
            'name': user.displayName,
            'email': user.email,
            'phoneNo': user.phoneNumber,
            'isPersonalInfo': false,
            'isFinancialInfo': false
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future<void> submitPhoneNumber(BuildContext context) async {
    String phoneNumber = '+91$mobileNumber';
    print(phoneNumber);
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      print('verificationCompleted');
      // setState(() {
      //   _status += 'verificationCompleted\n';
      // });
      this._phoneAuthCredential = phoneAuthCredential;
      print(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException error) {
      print('verificationFailed');
      print(error);
      showSnackBar(
          'Verification failed! Either the entered number is wrong or there is some technical error. Please try again',
          context);
      Navigator.pop(context);
    }

    void codeSent(String verificationId, [int? code]) {
      print('codeSent');
      this._verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());

      showSnackBar('OTP SENT!', context);
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      print('codeAutoRetrievalTimeout');
      // setState(() {
      //   _status += 'codeAutoRetrievalTimeout\n';
      // });
      print(verificationId);
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  Future<void> submitOTP(BuildContext context) async {
    String smsCode = otp;

    this._phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this._verificationId!, smsCode: smsCode);

    await _login(context);
  }

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential!)
          .then((UserCredential authRes) async {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
        if (_firebaseUser != null) {
          bool? isPersonalInfo = await FirestoreService()
              .fetchIsPersonalInfo(FirebaseAuth.instance.currentUser!.uid);
          bool? isFinancialInfo = await FirestoreService()
              .fetchIsFinancialInfo(FirebaseAuth.instance.currentUser!.uid);
          print(isPersonalInfo);
          print(isFinancialInfo);
          if (!isPersonalInfo! && !isFinancialInfo!) {
            String url = await fetchConsentUrl();

            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SetuWEB(
                          url: url,
                        )));
          } 
          // else if (isPersonalInfo! && isFinancialInfo!) {
          //   Navigator.of(context).popUntil((route) => route.isFirst);
          //   Navigator.pushReplacement(
          //       context, MaterialPageRoute(builder: (context) => HomePage()));
          // } else if (!isPersonalInfo) {
          //   Navigator.of(context).popUntil((route) => route.isFirst);
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => FinancialPage()));
          // } else if (!isFinancialInfo!) {
          //   Navigator.of(context).popUntil((route) => route.isFirst);
          //   Navigator.pushReplacement(
          //       context, MaterialPageRoute(builder: (context) => FormPage()));
          // }
          showSnackBar('Logged In!', context);
        }
      }).catchError((e) => showSnackBar(
              'The OTP entered is invalid. Kindly enter again.', context));
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    addUser();
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    //   final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      //   await googleSignIn.signOut();
      _firebaseUser = null;
      final snackBar = SnackBar(content: Text('Logged Out!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // setName('Unknown');
    // setEmail('Unknown');
    // mobileNumber = 'Unknown';
    //  Provider.of<Account>(context, listen: false).logout();
    notifyListeners();
  }
}
