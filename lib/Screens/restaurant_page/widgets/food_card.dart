import 'package:blue_witcher/Screens/restaurant_page/models/food_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FoodCard extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final int? like;
  final int? price;
  OrderState? myOrderState;
  int? id;

  int quantity;

  FoodCard({
    Key? key,
    this.imageUrl,
    this.name,
    this.rating,
    this.like,
    this.price,
    this.id,
    this.quantity = 0,
  }) : super(key: key);

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late int counter;

  @override
  void initState() {
    counter = widget.quantity;
    widget.myOrderState = Provider.of<OrderState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.5.h,
      width: 100.w,
      padding: EdgeInsets.all(4.w),
      margin: EdgeInsets.all(0.5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.w),
            bottomRight: Radius.circular(2.w),
          ),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
      child: Row(
        children: [
          Container(
            width: 10.h,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: FadeInImage(
                image: NetworkImage(widget.imageUrl!),
                placeholder: AssetImage('assets/home/loader3.gif'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/home/1.jpg", fit: BoxFit.cover);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 4.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.name!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        size: 3.5.h,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        widget.rating.toString(),
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.groups, size: 6.w, color: Colors.grey),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        widget.like.toString(),
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.w),
                  child: Text(
                    "₹ ${widget.price}",
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: 10.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (counter > 0) {
                            setState(() {
                              counter--;
                              updateOrder();
                            });
                          }
                        },
                        child: Container(
                          height: 3.h,
                          width: 3.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFff4c40),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(counter.toString()),
                      InkWell(
                        onTap: () {
                          setState(() {
                            counter++;
                            updateOrder();
                          });
                        },
                        child: Container(
                          height: 3.h,
                          width: 3.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF01b460)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void updateOrder() {
    widget.myOrderState!.addToOrder(FoodModel(
      id: widget.id!,
      name: widget.name ?? "",
      price: widget.price ?? 0,
      quantity: counter,
      imageUrl: widget.imageUrl ?? "",
    ));
  }
}
