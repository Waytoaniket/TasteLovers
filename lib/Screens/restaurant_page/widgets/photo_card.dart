import 'package:blue_witcher/Screens/profile/widgets/zoomed_like_card.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PhotoCard extends StatelessWidget {
  final String? imgUrl;

  const PhotoCard({
    Key? key,
    this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ZoomedLikeCard(
              imgUrl: imgUrl,
            ),
          ),
        );
      },
      child: FadeInImage(
        image: NetworkImage(Constants.imageBaseUrl + imgUrl!),
        placeholder: AssetImage('assets/home/loader3.gif'),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/home/1.jpg",
            fit: BoxFit.cover,
            width: 45.w,
            height: 20.h,
          );
        },
        fit: BoxFit.cover,
        width: 45.w,
        height: 20.h,
      ),
    );
  }
}
