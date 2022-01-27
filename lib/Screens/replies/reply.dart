import 'package:blue_witcher/Screens/replies/widget/reply_card.dart';
import 'package:blue_witcher/Screens/reviews/model/review_modal.dart';
import 'package:blue_witcher/Screens/reviews/state/review_state.dart';
import 'package:blue_witcher/Screens/reviews/widget/review_card.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReplyPage extends StatefulWidget {
  final int index;
  ReplyPage({Key? key, required this.index}) : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  TextEditingController _comment = TextEditingController();
  bool enablePost = false;
  FocusNode node = FocusNode();

  @override
  void initState() {
    _comment.addListener(() {
      if (_comment.text.isNotEmpty) {
        setState(() {
          enablePost = true;
        });
      } else {
        setState(() {
          enablePost = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5.w, top: 4.h),
              height: 12.h,
              width: 100.w,
              child: Icon(
                Icons.arrow_back_ios,
                size: 4.h,
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ReviewCard(index: widget.index),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Consumer<UserDataState>(
                            builder: (_, userstate, child) {
                              return Container(
                                height: 6.h,
                                width: 6.h,
                                margin: EdgeInsets.only(right: 1.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3.h),
                                  child: FadeInImage(
                                    image: NetworkImage(Constants.imageBaseUrl + userstate.getUserData.profileImageUrl),
                                    placeholder: AssetImage('assets/home/loader3.gif'),
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 60.w,
                                  child: TextFormField(
                                    focusNode: node,
                                    controller: _comment,
                                    cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
                                    maxLines: 5,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (enablePost) {
                                      EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                                      Map<String, String> data = {
                                        "comment_id": Provider.of<ReviewState>(context, listen: false)
                                            .totalReviews[widget.index]
                                            .id
                                            .toString(),
                                        "comment_text": _comment.text
                                      };
                                      ApiProvider.addComment(data).then((response) {
                                        if (response['result'] != null && response["result"]) {
                                          Replies reply = Replies.fromJson(response['data']);
                                          Provider.of<ReviewState>(context, listen: false)
                                              .addComment(widget.index, reply);
                                          EasyLoading.dismiss();
                                          _comment.clear();
                                          node.unfocus();
                                        } else {
                                          EasyLoading.showError("We have some internal issue");
                                          _comment.clear();
                                          node.unfocus();
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Post",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: enablePost
                                            ? Color.fromRGBO(115, 167, 19, 0.8)
                                            : Color.fromRGBO(115, 167, 19, 0.6),
                                        fontWeight: enablePost ? FontWeight.bold : FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Consumer<ReviewState>(
                      builder: (_, reviewState, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: reviewState.totalReviews[widget.index].replies.length,
                          itemBuilder: (_, index) {
                            return ReplyCard(
                              comment: reviewState.totalReviews[widget.index].replies[index].commentText,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
