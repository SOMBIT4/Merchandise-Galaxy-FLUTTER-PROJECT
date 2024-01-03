
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black ,
        title: Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
             icon: const Icon(Icons.settings_rounded),
             )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: const [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/img/profile.png"),
              ),
              SizedBox(height: 10),
              Text(
                "Ibrahim Emon",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("ibrahimemon942@gmail.com")

            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  "Complete your profile",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                  ),
              ),
              Text(
                "(1/2)",
                style: TextStyle(
                  color: Colors.blue,

                ),
                )
              
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: List.generate(2,(index) {
              return Expanded(
                child: Container(
                  height: 7,
                  margin: EdgeInsets.only(right: index == 1 ? 0:3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index ==0 ?Colors.green : Colors.black12,
                  ),
              
                ),
              );

            }),
          )
        ],
      ),


    );
  }
}