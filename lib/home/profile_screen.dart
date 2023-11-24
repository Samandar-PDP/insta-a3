import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../manager/firebase_manager.dart';
import '../model/fb_user.dart';
import '../screen/full_screen.dart';
import '../screen/login_screen.dart';
import '../widget/loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _manager = FirebaseManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _manager.getCurrentUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final user = snapshot.data;
          return _buildProfile(user);
        } else if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: Loading(color: Colors.red));
        }
      },
    );
  }

  void _logOut() {
    showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
      title: const Text("Do you want to log out?"),
      content: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(child: const Text("No!",
                style: TextStyle(color: Colors.blue),), onPressed: () {
                Navigator.of(context).pop();
              }),
              CupertinoButton(child: const Text("Yes",style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    _manager.logOut().then((value) {
                      Navigator.of(context)
                          .pushAndRemoveUntil(
                          CupertinoPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false);
                    });
                  }),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildProfile(FbUser? user) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(user?.username ?? "",style: GoogleFonts.roboto(
          fontSize: 22
        )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add_circled)),
          Badge.count(
            count: 4,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.list_bullet),
            ),
          ),
          IconButton(onPressed: _logOut, icon:
          const Icon(CupertinoIcons.power,color: Colors.red))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(40), /// TODO mashiniyam yoz!
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) =>
                            FullScreen(image: user?.image ?? "")));
                      },
                      child: Hero(
                        tag: 'profile_image',
                        child: CircleAvatar(
                          radius: 40,
                          foregroundImage: NetworkImage(
                              user?.image ?? ""
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(user?.nickname ?? "")
                  ],
                ),
                _buildTwoText('1','posts'),
                _buildTwoText('343','followers'),
                _buildTwoText('23','following'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTwoText(String title, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,style: GoogleFonts.roboto(fontSize: 18,color: Colors.white)),
        const SizedBox(height: 3),
        Text(label)
      ],
    );
  }
}
