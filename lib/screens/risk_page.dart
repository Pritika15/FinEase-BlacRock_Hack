import 'package:fin_ease/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class RiskPage extends StatelessWidget {
  final String riskLevel;

  RiskPage({required this.riskLevel});

  @override
  Widget build(BuildContext context) {
    Color meterColor;
    IconData meterIcon;

    if (riskLevel == 'Low Risk') {
      meterColor = Colors.green;
      meterIcon = Icons.check_circle;
    } else if (riskLevel == 'Medium Risk') {
      meterColor = Colors.yellow;
      meterIcon = Icons.warning;
    } else {
      meterColor = Colors.red;
      meterIcon = Icons.cancel;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: GestureDetector(
            onTap: () =>
                Provider.of<Auth>(context, listen: false).logout(context),
            child: Text(
              'Risk Level',
              style: TextStyle(color: Colors.white),
            )),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              meterIcon,
              color: meterColor,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              riskLevel,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Dashboard())));
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
                  'Plan & invest',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
