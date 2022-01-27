import 'package:blue_witcher/Screens/reviews/model/review_modal.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ReviewState with ChangeNotifier {
  List<ReviewData> _totalReviews = [];
  List<ReviewData> get totalReviews => _totalReviews;

  void getReview(int resId) async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);

    await ApiProvider.getAllReview({"restaurent_id": resId.toString()}).then((response) {
      _totalReviews = response.data!;
      notifyListeners();
      EasyLoading.dismiss();
    });
  }

  void addComment(int index, Replies comment) {
    _totalReviews[index].replies.add(comment);
    notifyListeners();
  }
}
