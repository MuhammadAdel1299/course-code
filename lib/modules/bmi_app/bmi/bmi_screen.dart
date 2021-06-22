import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/bmi_app/bmi_result/bmi_result_screen.dart';


class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  bool isMale = true;
  double height = 120.0;
  int age = 20;
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/male-xxl.png'),
                                height: 50.0,
                                width: 50.0,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "MALE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: isMale
                                ? Colors.red
                                : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/images/female-xxl.png'),
                                height: 50.0,
                                width: 50.0,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "FEMALE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: !isMale
                                ? Colors.red
                                : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HEIGHT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "${height.round()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            " CM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                        value: height,
                        max: 220.0,
                        min: 80.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "AGE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "${age}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(
                                      heroTag: 'age-',
                                      child: Icon(Icons.remove),
                                      mini: true,
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          age--;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10.0),
                                    FloatingActionButton(
                                      heroTag: 'age+',
                                      child: Icon(Icons.add),
                                      mini: true,
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          age++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "WEIGHT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "${weight}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FloatingActionButton(
                                      heroTag: 'weight-',
                                      child: Icon(Icons.remove),
                                      mini: true,
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          weight--;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10.0),
                                    FloatingActionButton(
                                      heroTag: 'weight+',
                                      child: Icon(Icons.add),
                                      mini: true,
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          weight++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                color: Colors.red,
                onPressed: () {
                  var result = weight / pow(height / 100, 2);
                  print(result.round());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BmiResultScreen(age: age,isMale: isMale, result: result.round(),),
                    ),
                  );
                },
                child: Text(
                  "Calculate",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 2, fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
