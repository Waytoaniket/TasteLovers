import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class ReplyCard extends StatelessWidget {
  final String? userImg;
  final String? comment;
  const ReplyCard({Key? key, this.userImg, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6.h,
            width: 6.h,
            margin: EdgeInsets.only(right: 2.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.h),
              child: FadeInImage(
                image: userImg != null
                    ? NetworkImage(Constants.imageBaseUrl + userImg!)
                    : AssetImage("assets/home/noprofile.png") as ImageProvider,
                placeholder: AssetImage('assets/home/loader3.gif'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 3.h),
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(203, 203, 203, 0.1),
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.w),
                      topRight: Radius.circular(4.w),
                      bottomRight: Radius.circular(4.w))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aniket",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(comment.toString())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
