import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'otp_page.dart';

class LoginPage extends StatelessWidget {
  String? mobileNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your phone number',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'To login, you have to enter your phone number to get OTP',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Container(
              width: 230,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF2A2D32), // #2A2D32
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: 'Enter Indian mobile number',
                    border: InputBorder.none, // Remove default borders
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Provider.of<Auth>(context,listen: false).mobileNumber = mobileNumber!;
                Provider.of<Auth>(context,listen: false).submitPhoneNumber(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => OTPPage(
                              mobileNumber: mobileNumber!,
                            ))));
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
                'Send OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
