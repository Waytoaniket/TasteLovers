import 'package:blue_witcher/Screens/profile/widgets/zoomed_like_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LikeCard extends StatelessWidget {
  final String? imageUrl;
  final int? likes;
  final int? comments;
  const LikeCard({Key? key, this.imageUrl, this.comments, this.likes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ZoomedLikeCard(
              imgUrl: imageUrl,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imageUrl!), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Likes",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.w,
                      ),
                      Text(
                        likes.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Comments",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.w,
                      ),
                      Text(
                        comments.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
