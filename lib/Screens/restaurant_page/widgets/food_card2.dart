import 'package:blue_witcher/Screens/restaurant_page/models/food_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class FoodCard2 extends StatefulWidget {
  final String imageUrl;
  final String name;
  final int quantity;
  final int price;
  final int id;

  const FoodCard2({
    Key? key,
    required this.quantity,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.id,
  }) : super(key: key);

  @override
  _FoodCard2State createState() => _FoodCard2State();
}

class _FoodCard2State extends State<FoodCard2> {
  late int counter;

  @override
  void initState() {
    counter = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return counter == 0
        ? Container()
        : Column(
            children: [
              Container(
                height: 13.5.h,
                width: 100.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2.w),
                    bottomRight: Radius.circular(2.w),
                  ),
                ),
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
                          image: NetworkImage(widget.imageUrl),
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
                              widget.name,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Text(
                              widget.price.toString(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 2.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                                        context.read<OrderState>().addToOrder(
                                              FoodModel(
                                                imageUrl: widget.imageUrl,
                                                id: widget.id,
                                                name: widget.name,
                                                price: widget.price,
                                                quantity: counter,
                                              ),
                                            );
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
                                      context.read<OrderState>().addToOrder(
                                            FoodModel(
                                              imageUrl: widget.imageUrl,
                                              id: widget.id,
                                              name: widget.name,
                                              price: widget.price,
                                              quantity: counter,
                                            ),
                                          );
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  thickness: 2,
                ),
              )
            ],
          );
  }
}
