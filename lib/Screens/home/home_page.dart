import 'package:blue_witcher/Screens/home/model/home_data_model.dart';
import 'package:blue_witcher/Screens/home/state/search_state.dart';
import 'package:blue_witcher/Screens/home/widgets/category.dart';
import 'package:blue_witcher/Screens/home/widgets/header.dart';
import 'package:blue_witcher/Screens/home/widgets/search_list.dart';
import 'package:blue_witcher/Screens/home/widgets/searchbar.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _search = TextEditingController();
  SearchState? myState;
  HomeDataModel? dataModel;
  List<Restaurant>? restaurantList;
  List<Papular>? trendingList;
  List<Papular>? papularList;

  final FocusNode _nodeText1 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        )
      ],
    );
  }

  @override
  void initState() {
    myState = Provider.of<SearchState>(context, listen: false);
    _search.addListener(updateSearchList);
    super.initState();
    getData();
  }

  void updateSearchList() {
    if (_search.text != "") {
      myState!.changeVisibility(true);
      if (myState!.filterByRestaurant)
        myState!.updateRestaurantList(_search.text);
      else
        myState!.updateProductList(_search.text);
    } else {
      myState!.changeVisibility(false);
    }
  }

  getData() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    var r = await ApiProvider.getHomeData();
    print(r);
    if (r['result']) {
      dataModel = HomeDataModel.fromJson(r);

      restaurantList = dataModel!.restaurants ?? [];
      trendingList = dataModel!.trending ?? [];
      papularList = dataModel!.papular ?? [];
    } else {
      EasyLoading.showToast('Something went wrong');
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  void dispose() {
    myState!.getDispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: Column(
          children: [
            getHeader(context),
            KeyboardActions(
              config: _buildConfig(context),
              autoScroll: false,
              child: SearchBar(cont: _search, node: _nodeText1),
            ),
            Consumer<SearchState>(builder: (context, searchState, child) {
              return Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: searchState.showList
                        ? searchList(searchState.searchList, context)
                        : categorySection(context, restaurantList ?? [], trendingList ?? [], papularList ?? []),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
