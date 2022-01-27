import 'package:blue_witcher/Screens/home/state/search_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? cont;
  final FocusNode? node;
  const SearchBar({Key? key, this.cont, this.node}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchState>(builder: (context, searchState, child) {
      return Container(
        margin: EdgeInsets.only(top: 2.h),
        child: TextFormField(
          focusNode: node,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: (value) {},
          keyboardType: TextInputType.name,
          controller: cont,
          style: TextStyle(fontSize: 14.sp),
          cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(32, 24, 12, 16),
            helperText: "",
            helperStyle: TextStyle(height: 0.5),
            errorStyle: TextStyle(height: 0.5),
            hintText: searchState.filterByRestaurant ? "Restaurant name" : "Product Name",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.w),
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 3)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(115, 167, 19, 0.6), width: 3),
              borderRadius: BorderRadius.circular(3.w),
            ),
            prefixIcon: prefixIcon(),
            suffixIcon: suffixIcon(context),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      );
    });
  }

  Widget prefixIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
      child: Image.asset(
        "assets/home/Search.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget suffixIcon(context) {
    return PopupMenuButton(
      onSelected: (index) {
        if (index == 1)
          Provider.of<SearchState>(context, listen: false).changeFiltter(true);
        else
          Provider.of<SearchState>(context, listen: false).changeFiltter(false);
      },
      icon: Container(
        child: Image.asset(
          "assets/home/Slider.png",
          fit: BoxFit.cover,
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Restaurant"),
          value: 1,
        ),
        PopupMenuItem(
          child: Text("Product"),
          value: 2,
        )
      ],
    );
  }
}
