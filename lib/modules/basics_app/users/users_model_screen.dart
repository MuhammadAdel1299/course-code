import 'package:flutter/material.dart';
import 'package:flutter_app/models/user/user_model.dart';


class UserScreen extends StatelessWidget {
  List <UserModel> users = [
    UserModel(id: 1, name: "Muhammad adel", phone: "1354366357"),
    UserModel(id: 2, name: "Ahmed Abdo", phone: "79366357"),
    UserModel(id: 3, name: "Ahmed Samer", phone: "4366357"),
    UserModel(id: 4, name: "Muhammad Atef", phone: "6794366357"),
    UserModel(id: 5, name: "Deep Yasser", phone: "4366357"),
    UserModel(id: 6, name: "Abdullah", phone: "54654877"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                "${user.id}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white),
              ),
              backgroundColor: Colors.blue,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${user.phone}",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
}
