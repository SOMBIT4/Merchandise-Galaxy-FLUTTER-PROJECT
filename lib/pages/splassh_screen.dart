import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchendise_galaxy/pages/login_pages.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';
import 'package:merchendise_galaxy/res/colors/app_color.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with SingleTickerProviderStateMixin {
  //diseapear upper and bottom bars
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  //apear bars again
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 20, 20),
        child: Column(
          children: [
            Image.asset(
              'lib/images/logo1.png',
              height: 350,
              width: 350,
            ),
            //text
            Container(
              padding: const EdgeInsets.only(left: 5, top: 40),
              child: Text(
                'Merchandise',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Fontmain',
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //text
            Container(
              padding: const EdgeInsets.only(left: 140, top: 10),
              child: Text(
                'Galaxy',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Fontmain',
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
