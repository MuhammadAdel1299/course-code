import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final bool isMale;
  final int result;
  final int age;

  const BmiResultScreen({
    @required this.isMale,
    @required this.result,
    @required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Result"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Gender : ${isMale ? "Male" : "Female"}",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              Text(
                "Age : $age",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              Text(
                "Result : $result",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
