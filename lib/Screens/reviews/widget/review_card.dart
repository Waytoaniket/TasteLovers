import 'package:blue_witcher/Screens/replies/reply.dart';
import 'package:blue_witcher/Screens/reviews/state/review_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReviewCard extends StatelessWidget {
  final int index;
  final Function? callback;
  const ReviewCard({Key? key, required this.index, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewState>(builder: (_, reviewState, child) {
      return Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(vertical: 1.h),
        child: Column(
          children: [
            Container(
              width: 96.w,
              color: Color.fromRGBO(115, 167, 19, 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6.h,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.h),
                    child: Row(
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
                              image: reviewState.totalReviews[index].image != null
                                  ? NetworkImage(Constants.imageBaseUrl + reviewState.totalReviews[index].image!)
                                  : AssetImage("assets/home/noprofile.png") as ImageProvider,
                              placeholder: AssetImage('assets/home/loader3.gif'),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              reviewState.totalReviews[index].name.toString(),
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.1.w),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(1, 180, 96, 1),
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_half_rounded,
                                    color: Colors.white,
                                    size: 4.5.w,
                                  ),
                                  Text(
                                    reviewState.totalReviews[index].rating != null
                                        ? reviewState.totalReviews[index].rating.toString()
                                        : "4.5",
                                    style: TextStyle(color: Colors.white, fontSize: 3.w),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  reviewState.totalReviews[index].commentText != null
                      ? Container(
                          margin: EdgeInsets.only(bottom: 2.w, left: 1.5.h),
                          width: 80.w,
                          child: Text(
                            reviewState.totalReviews[index].commentText.toString(),
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        )
                      : Container(),
                  if (reviewState.totalReviews[index].images != null &&
                      reviewState.totalReviews[index].images != "no_image.jpg")
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 1.h, left: 1.h, right: 1.h),
                      child: FadeInImage(
                        image: NetworkImage(Constants.imageBaseUrl + reviewState.totalReviews[index].images!),
                        placeholder: AssetImage('assets/home/loader3.gif'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                        },
                        fit: BoxFit.contain,
                        height: 30.h,
                        width: 100.h,
                      ),
                    )
                ],
              ),
            ),
            Container(
              height: 5.h,
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.thumb_up_alt_outlined),
                      SizedBox(width: 2.w),
                      Text(
                        "Like",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (callback != null) callback!();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.messenger_outline_outlined),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text("Comment", style: TextStyle(fontWeight: FontWeight.w500))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
