import 'package:blue_witcher/Screens/replies/reply.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/reviews/state/review_state.dart';
import 'package:blue_witcher/Screens/reviews/widget/review_card.dart';
import 'package:blue_witcher/Screens/reviews/widget/review_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    int? resId = Provider.of<RestaurantState>(context, listen: false).dataResto!.first.id;

    Provider.of<ReviewState>(context, listen: false).getReview(resId!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ReviewHeader(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: Consumer<ReviewState>(
                builder: (_, reviewState, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: reviewState.totalReviews.length,
                    itemBuilder: (_, index) {
                      return ReviewCard(
                        index: index,
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReplyPage(
                                index: index,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
