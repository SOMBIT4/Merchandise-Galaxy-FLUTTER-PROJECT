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
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Column(
          children: [
            Text(userMap['Name']),
            Text(
              userMap['status'],
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        //Text(userMap['Name']), //StreamBuilder<DocumentSnapshot>(
        //   stream: _firestore
        //       .collection("users")
        //       .doc(userMap[FirebaseAuth.instance.currentUser?.uid])
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData && snapshot.data!.exists) {
        //       Map<String, dynamic>? userData =
        //           snapshot.data!.data() as Map<String, dynamic>?;

        //       if (userData != null && userData.containsKey('status')) {
        //         return Container(
        //           child: Column(
        //             children: [
        //               Text(userMap['Name']),
        //               Text(
        //                 userData['status'],
        //                 style: TextStyle(fontSize: 14),
        //               ),
        //             ],
        //           ),
        //         );
        //       } else {
        //         // Handle the case where the 'status' field is not present in the document
        //         return Container(
        //           child: Column(
        //             children: [
        //               Text(userMap['Name']),
        //               Text(
        //                 "Status not available",
        //                 style: TextStyle(fontSize: 14),
        //               ),
        //             ],
        //           ),
        //         );
        //       }
        //     } else {
        //       return Container();
        //     }
        //   },
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatroomId)
                  .collection('chats')
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      return messages(size, map);
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
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        hintText: "Send message",
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

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}