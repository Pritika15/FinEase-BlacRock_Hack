import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_ease/screens/risk_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/financial_Page.dart';
import '../screens/form_page.dart';
import '../screens/home_page.dart';

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserProfile(
      String userId,
      String name,
      int age,
      String education,
      String gender,
      String maritalStatus,
      String occupation,
      int kidsCount,
      bool ownHouse,
      bool ownCar) async {
    try {
      await usersCollection.doc(userId).set({
        'name': name,
        'age': age,
        'education': education,
        'gender': gender,
        'isMarried': maritalStatus,
        'occupation': occupation,
        'kidsCount': kidsCount,
        'ownHouse': ownHouse,
        'ownCar': ownCar
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<void> updateUserFinProfile(
      String userId,
      String incomeType,
      String annualIncome,
      String loanTypes,
      String loanAmount,
      String loanAnnuity) async {
    try {
      await usersCollection.doc(userId).set({
        'incomeType': incomeType,
        'annualIncome': annualIncome,
        'loanType': loanTypes,
        'loanAmount': loanAmount,
        'loanAnnuity': loanAnnuity
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating user fin profile: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        
        print('User not found');return {};
      }
    } catch (e) { 
      print('Error fetching user data: $e');return {};
    }
  }

  Future<bool?> fetchIsPersonalInfo(String userId) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('isPersonalInfo')) {
          return userData['isPersonalInfo'] as bool?;
        }
      }
    } catch (e) {
      print('Error fetching isPersonalInfo: $e');
    }
    return null;
  }

  Future<bool?> fetchIsFinancialInfo(String userId) async {
    try {
      DocumentSnapshot snapshot = await usersCollection.doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('isFinancialInfo')) {
          return userData['isFinancialInfo'] as bool?;
        }
      }
    } catch (e) {
      print('Error fetching isFinancialInfo: $e');
    }
    return null;
  }

  Future<void> setPersonalInfoComplete(String userId) async {
    try {
      await usersCollection
          .doc(userId)
          .set({'isPersonalInfo': true}, SetOptions(merge: true));
    } catch (e) {
      print('Error setting isPersonalInfo: $e');
    }
  }

  Future<void> setFinancialInfoComplete(String userId) async {
    try {
      await usersCollection
          .doc(userId)
          .set({'isFinancialInfo': true}, SetOptions(merge: true));
    } catch (e) {
      print('Error setting isPersonalInfo: $e');
    }
  }

  Future<Widget> checkIsInfos() async {
    bool? isPersonalInfo = await FirestoreService()
        .fetchIsPersonalInfo(FirebaseAuth.instance.currentUser!.uid);
    bool? isFinancialInfo = await FirestoreService()
        .fetchIsFinancialInfo(FirebaseAuth.instance.currentUser!.uid);
    if (isPersonalInfo! && isFinancialInfo!) {
      // Navigator.of(context).popUntil((route) => route.isFirst);
      return RiskPage(riskLevel: 'High Risk',);
    } else if (!isPersonalInfo) {
      // Navigator.of(context).popUntil((route) => route.isFirst);
      return FormPage();
    } else if (!isFinancialInfo!) {
      //  Navigator.of(context).popUntil((route) => route.isFirst);
      return FinancialPage();
    }
    return HomePage();
  }
}
