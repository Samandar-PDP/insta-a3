// story_item
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/fb_user.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.fbUser, required this.onClick});
  final FbUser fbUser;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff11347a),
              Color(0xffd52a92),
              Color(0xffd9b320),
            ]
          ),
          shape: BoxShape.circle
        ),
        child: CircleAvatar(
          foregroundImage: NetworkImage(fbUser.image ?? ""),
        ),
      ),
    );
  }
}
