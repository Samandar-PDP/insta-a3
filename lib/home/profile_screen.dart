import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../manager/firebase_manager.dart';
import '../model/fb_user.dart';
import '../model/post.dart';
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
        if (snapshot.hasData) {
          final user = snapshot.data;
          return _buildProfile(user);
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(child: Loading(color: Colors.red));
        }
      },
    );
  }

  void _logOut() {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Do you want to log out?"),
              content: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoButton(
                          child: const Text(
                            "No!",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoButton(
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            _manager.logOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      displacement: MediaQuery.of(context).size.height / 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Text(user?.username ?? "", style: GoogleFonts.roboto(fontSize: 22)),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.add_circled)),
            Badge.count(
              count: 4,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.list_bullet),
              ),
            ),
            IconButton(
                onPressed: _logOut,
                icon: const Icon(CupertinoIcons.power, color: Colors.red))
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
                        borderRadius: BorderRadius.circular(40),

                        /// TODO mashiniyam yoz!
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FullScreen(image: user?.image ?? "")));
                        },
                        child: Hero(
                          tag: 'profile_image',
                          child: CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(user?.image ?? ""),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(user?.nickname ?? "")
                    ],
                  ),
                  _buildTwoText("${user?.postCount}", 'posts'),
                  _buildTwoText("${user?.followersCount}", 'followers'),
                  _buildTwoText("${user?.followingCount}", 'following'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildMyPosts(),

                /// ozgardi
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyPosts() {
    return FutureBuilder(
      future: _manager.getMyPosts(),
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.data?.isNotEmpty == true) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 2),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final image = snapshot.data?[index].image;
              return InkWell(
                  onTap: () {
                    _showDetailSheet(snapshot.data?[index]);
                  },
                  child: Image.network(image ?? "", fit: BoxFit.cover));
            },
          );
        } else if (snapshot.data != null && snapshot.data?.isEmpty == true) {
          return const Center(child: Icon(CupertinoIcons.nosign));
        } else {
          return const Loading();
        }
      },
    );
  }

  _showDetailSheet(Post? post) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(post?.image ?? "",width: double.infinity,height: 200),
                    const SizedBox(height: 20),
                    Text(post?.text ?? "",style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 30),
                    CupertinoButton(child: const Text("Delete Post"), onPressed: () {
                      _deletePost(post);
                    })
                  ],
                ),
              ),
            ));
  }

  Widget _buildTwoText(String title, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: GoogleFonts.roboto(fontSize: 18, color: Colors.white)),
        const SizedBox(height: 3),
        Text(label)
      ],
    );
  }

  _deletePost(Post? post) {
    _manager.deletePost(post).then((value) {
      Navigator.of(context).pop();
    });
  }
}
