import 'package:blue_witcher/Screens/profile/widgets/like_card.dart';
import 'package:blue_witcher/Screens/profile/widgets/profile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  static const String id = "ProfilePage";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<LikeCard> likeCardList = [
    LikeCard(
      imageUrl: "assets/profile/1.png",
      likes: 125,
      comments: 145,
    ),
    LikeCard(
      imageUrl: "assets/profile/2.png",
      likes: 125,
      comments: 145,
    ),
    LikeCard(
      imageUrl: "assets/profile/3.png",
      likes: 125,
      comments: 145,
    ),
    LikeCard(
      imageUrl: "assets/profile/4.png",
      likes: 125,
      comments: 145,
    ),
    LikeCard(
      imageUrl: "assets/profile/1.png",
      likes: 125,
      comments: 145,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileCard(
            imageUrl: "assets/profile/profile.png",
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
              shrinkWrap: true,
              itemCount: likeCardList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.w,
                mainAxisSpacing: 1.w,
                childAspectRatio: 50.w / 50.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return likeCardList[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
