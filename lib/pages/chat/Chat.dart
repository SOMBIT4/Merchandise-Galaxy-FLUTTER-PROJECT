import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merchendise_galaxy/pages/chat/chatroom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String chatroomId(String user1, String user2) {
    if (user1 != null && user2 != null) {
      print(user1);
      print(user2);
      String normalizedUser1 = user1.toLowerCase();
      String normalizedUser2 = user2.toLowerCase();

      if (normalizedUser1.isNotEmpty && normalizedUser2.isNotEmpty) {
        List<String> users = [normalizedUser1, normalizedUser2];
        users.sort();
        return "${users[0]}${users[1]}";
      }
    }
    return "";
  }

  String? _currentusername;
  void inputData() {
    final User? user = _auth.currentUser;
    final uname = user!.uid;
    print(uname);
    // here you write the codes to input the data into firestore
  }

  Future<void> _getcurrentname() async {
    FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.data == null) {
          return const Text("No data");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          _currentusername = '${data['name']}';
        }
        return const Text("loading");
      },
    );
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("Email", isEqualTo: _search.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = false;
        });
        print(userMap);
      } else {
        setState(() {
          userMap = null;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                if (userMap != null)
                  ListTile(
                    onTap: () {
                      inputData();
                      String roomId = chatroomId(
                          _auth.currentUser?.displayName ?? '',
                          userMap!['Name'] ?? '');
                      print("room id is ----");
                      print(roomId);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatroomId: roomId,
                            userMap: userMap!,
                          ),
                        ),
                      );
                    },
                    leading: Icon(Icons.account_box, color: Colors.black),
                    title: Text(
                      userMap!['Name'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(userMap!['Email'] ?? ''),
                    trailing: Icon(Icons.chat, color: Colors.black),
                  ),
              ],
            ),
    );
  }
}
