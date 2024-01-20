import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatroomId;

  ChatRoom({Key? key, required this.chatroomId, required this.userMap})
      : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        Map<String, dynamic> message = {
          "sendby": currentUser.displayName ?? "Anonymous",
          "message": _message.text,
          "type": "text",
          "time": FieldValue.serverTimestamp(),
        };

        _message.clear();

        await _firestore
            .collection('chatroom')
            .doc(chatroomId)
            .collection('chats')
            .add(message);
      } else {
        print("User is not authenticated.");
      }
    } else {
      print("Enter some text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (chatroomId.isEmpty) {
      // Handle the case where chatroomId is empty
      return Scaffold(
        body: Center(
          child: Text("Invalid chatroomId"),
        ),
      );
    } else {
      print(chatroomId);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(userMap['Name']),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatroomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data!.docs[index]['message']);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            height: size.height / 10,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSendMessage,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
