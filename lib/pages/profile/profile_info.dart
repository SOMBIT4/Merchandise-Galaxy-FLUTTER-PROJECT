import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchendise_galaxy/res/app_assets/app_assets.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text('Profile Information',
              style: TextStyle(fontSize: 25, color: Colors.black)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(60),
          child: Container(
            height: 400,
            width: 550,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- IMAGE with ICON
                Stack(
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(AppAssets.profileImg),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text('Name', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 60),
                Text('Email', style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 40),

                // -- Form Fields
                /* Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Edit Email'),
                            prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
