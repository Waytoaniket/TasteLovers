import 'dart:io';

import 'package:blue_witcher/Screens/rating/widget/add_image.dart';
import 'package:blue_witcher/Screens/rating/widget/description_feild.dart';
import 'package:blue_witcher/Screens/rating/widget/rating_header.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RatingPage extends StatefulWidget {
  RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rating = 0;
  String images = "";
  bool isLoading = false;
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Color.fromRGBO(115, 167, 19, 0.6),
        ),
        inAsyncCall: isLoading,
        child: Column(
          children: [
            RatingHeader(),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return false;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 10.h,
                        width: 70.w,
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
                        child: RatingBar(
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          glow: false,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            half: Icon(
                              Icons.star_half_rounded,
                              color: Colors.amber,
                            ),
                            empty: Icon(
                              Icons.star_border_rounded,
                              color: Colors.black,
                            ),
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (val) {
                            setState(() {
                              rating = val;
                            });
                          },
                        ),
                      ),
                      description(comment),
                      AddImages(
                        addImage: getImage,
                        removeImage: remove,
                      ),
                      InkWell(
                        onTap: () {
                          if (comment.text.isNotEmpty && rating != 0) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, String> data = {
                              "restaurent_id":
                                  Provider.of<RestaurantState>(context, listen: false).dataResto!.first.id.toString(),
                              "comment_text": comment.text,
                              "rating": rating.toString()
                            };
                            ApiProvider.addReview(data, File(images)).then(
                              (response) {
                                if (response["result"] != null && response["result"]) {
                                  Fluttertoast.showToast(
                                      msg: response['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: response['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "please give rating and comment",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1);
                          }
                        },
                        child: Container(
                          width: 70.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(97, 125, 45, 1), borderRadius: BorderRadius.circular(2.w)),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getImage(image) async {
    setState(() {
      images = image;
    });
  }

  void remove() {
    setState(() {
      images = "";
    });
  }
}
