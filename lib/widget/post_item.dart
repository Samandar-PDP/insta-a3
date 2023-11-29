import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/model/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage(post.ownerImage ?? ""),
          ),
          title: Text(post.ownerNickname ?? ""),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ),
        const Gap(20),
        Image.network(post.image ?? "",height: 300,width: double.infinity, fit: BoxFit.cover),
        const Gap(20),
        const Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Gap(10),
            Icon(CupertinoIcons.heart),
             Gap(10),
            Icon(CupertinoIcons.chat_bubble),
            Gap(10),
            Icon(CupertinoIcons.paperplane),
            Gap(10),
            Expanded(
              child: Align(child:  const Icon(CupertinoIcons.bookmark),alignment: AlignmentDirectional.centerEnd,),
            ),
            Gap(10),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          post.text ?? ""
        )
      ],
    );
  }
}
