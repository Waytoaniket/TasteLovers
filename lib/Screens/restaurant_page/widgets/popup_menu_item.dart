import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PopUpMenuItems extends StatelessWidget {
  final List<Menu>? menuList;
  const PopUpMenuItems({Key? key, this.menuList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantState myState = Provider.of<RestaurantState>(context);

    return Container(
      margin: EdgeInsets.only(top: 1.h),
      child: PopupMenuButton(
        color: Colors.white,
        elevation: 10,
        enabled: true,
        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
        onSelected: (Menu value) async {
          if (value.id == 0) {
            EasyLoading.show(status: 'Loading...', dismissOnTap: false);
            myState.getAllItems();
            EasyLoading.dismiss();
          } else {
            EasyLoading.show(status: 'Loading...', dismissOnTap: false);
            await myState.getfilteritems(value.id);
            EasyLoading.dismiss();
            myState.getFilterMenuItem();
          }
        },
        itemBuilder: (context) {
          return menuList!
              .map((Menu e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e.mName ?? '',
                    ),
                  ))
              .toList();
        },
        child: Icon(
          Icons.more_vert,
          color: Color(0xFF01b460),
          size: 4.h,
        ),
      ),
    );
  }
}
