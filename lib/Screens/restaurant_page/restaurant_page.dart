import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/food_card.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/restaurant_header.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/place_order.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RestaurantPage extends StatefulWidget {
  static const String id = "RestaurantPage";

  RestaurantPage({Key? key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  RestaurantState? restaurantState;

  List<Item>? restoItem;
  List<TableModel>? tableData;
  OrderState? myOrderState;

  @override
  void initState() {
    myOrderState = Provider.of<OrderState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    restaurantState = Provider.of<RestaurantState>(context);
    restoItem = restaurantState!.itemList;
    tableData = restaurantState!.getTableList;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              RestaurantHeader(),
              Expanded(
                child: SizedBox(
                  child: restoItem!.isEmpty
                      ? Center(child: Text('No Item Found'))
                      : ListView.builder(
                          itemCount: restoItem!.length,
                          itemBuilder: (context, index) {
                            print("ID: ${restoItem![index].toJson()}");
                            print(restoItem);
                            print(restoItem!.length);
                            return FoodCard(
                              key: UniqueKey(),
                              id: restoItem![index].id,
                              imageUrl: ApiProvider.imageBaseUrl + restoItem![index].itemImg!,
                              name: "${restoItem![index].itemName}",
                              rating:
                                  restoItem![index].avgRating == null ? 4.5 : restoItem![index].avgRating!.toDouble(),
                              like: restoItem![index].noOfRating == null ? 1277 : restoItem![index].noOfRating,
                              price: restoItem![index].price,
                              quantity: myOrderState!.getItemQuantity(restoItem![index].id!),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 10.w,
            right: 10.w,
            child: PlaceOrderWidget(
              tableData: tableData,
              intializeData: () {
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
