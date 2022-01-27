import 'package:blue_witcher/Screens/profile/widgets/zoomed_like_card.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/restaurant_image_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/photo_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddNewPhoto extends StatefulWidget {
  AddNewPhoto({Key? key}) : super(key: key);

  @override
  _AddNewPhotoState createState() => _AddNewPhotoState();
}

class _AddNewPhotoState extends State<AddNewPhoto> {
  List<RestaurantImageModel>? restoImageList;
  @override
  Widget build(BuildContext context) {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    RestaurantState state = Provider.of<RestaurantState>(context);

    restoImageList = state.getRestoImageList;
    EasyLoading.dismiss();
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 5.h),
        shrinkWrap: true,
        itemCount: restoImageList!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
          // childAspectRatio: 50.w / 70.w,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PhotoCard(
            imgUrl: restoImageList![index].images,
          );
        },
      ),
    );
  }
}
