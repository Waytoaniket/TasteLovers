import 'dart:io';

import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class ZoomedLikeCard extends StatelessWidget {
  final String? imgUrl;

  const ZoomedLikeCard({Key? key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              width: 80.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 4.h,
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage(
              image: NetworkImage(Constants.imageBaseUrl + imgUrl!),
              placeholder: AssetImage('assets/home/loader3.gif'),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/profile/1.png",
                  fit: BoxFit.fill,
                  width: 96.w,
                  height: 68.h,
                );
              },
              fit: BoxFit.fill,
              height: 68.h,
              width: 96.w,
            ),
            InkWell(
              onTap: () async {
                EasyLoading.show(status: 'Loading....', dismissOnTap: false);
                String image = Constants.imageBaseUrl + imgUrl!;
                final url = Uri.parse(image);
                final response = await http.get(url);
                final byte = response.bodyBytes;

                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(byte);

                EasyLoading.dismiss();

                await Share.shareFiles([path]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 5.w),
                width: 20.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
                child: Icon(Icons.share),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
