import 'package:blue_witcher/Screens/home/model/search_list_model.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';

class SearchState with ChangeNotifier {
  List<SearchItem> _searchItemList = [];
  bool _showList = false;
  bool _filterByRestaurant = true;

  List<SearchItem> get searchList => _searchItemList;
  bool get showList => _showList;
  bool get filterByRestaurant => _filterByRestaurant;

  void changeVisibility(bool value) {
    _showList = value;
    notifyListeners();
  }

  void getDispose() {
    _showList = false;
  }

  void changeFiltter(bool value) {
    if (_filterByRestaurant != value) {
      _filterByRestaurant = value;
      _searchItemList.clear();
      notifyListeners();
    }
  }

  void updateRestaurantList(String search) async {
    _searchItemList =
        await ApiProvider.getRestaurantSearchList({"searchresult": search}).then((value) => value.searchList!);
    notifyListeners();
  }

  void updateProductList(String search) async {
    _searchItemList =
        await ApiProvider.getProductSearchList({"productname": search}).then((value) => value.searchList!);
    notifyListeners();
  }
}
