
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
          const Column(
            
            children: [
              CircleAvatar(
                
                radius: 80,
                backgroundImage: AssetImage("assets/img/profile.png"),
                child: Icon(Icons.add_a_photo_outlined,color: Colors.black,),            
              ),
            
              
              
              SizedBox(height: 10),
              Text(
                "Ibrahim Emon",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                       "ibrahimemon942@gmail.com",
                    ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.edit,color: Colors.green,),
                ],
              )
             
            ],
          ),
          const SizedBox(height: 35),
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
          ),
         
        ],
      ),


    );
  }
}