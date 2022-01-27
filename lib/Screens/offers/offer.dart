import 'package:blue_witcher/Screens/offers/model/offer_model.dart';
import 'package:blue_witcher/Screens/offers/widget/offer_appbar.dart';
import 'package:blue_witcher/Screens/offers/widget/offercard.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OffersPage extends StatefulWidget {
  static const String id = "OffersPage";

  OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  List<OfferCard> offers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.show(status: 'Loading Offers...', dismissOnTap: false);
    ApiProvider.getAllOffer().then((response) {
      if (response.result != null && response.result!) {
        for (var item in response.data!) {
          offers.add(
            OfferCard(
              imageUrl: item.itemImg,
              itemId: item.itemId,
              coupon: item.coupon,
              restaurantId: item.restaurantId,
              restaurantName: item.restaurantName,
              itemName: item.itemName,
              offerId: item.offerId,
              offerPrice: item.offerPrice,
            ),
          );
        }
        setState(() {});
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          orfferAppBar(context),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(children: offers),
              ),
            ),
          )
        ],
      ),
    );
  }
}
