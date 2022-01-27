import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/restaurant_image_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';

class RestaurantState with ChangeNotifier {
  SearchByIdModel? data;
  List<Item>? items;
  List<Datum>? dataResto;
  List<Menu>? listMenu;
  List<Item>? menuData;
  SearchByIdModel? dataProduct;
  List<TableModel>? tableData;
  List<RestaurantImageModel>? imageData;

  List<Item> get itemList => items ?? [];

  List<Datum> get dataList => dataResto ?? [];

  List<Menu> get menuList => listMenu ?? [];

  List<Item> get itemFilterData => menuData ?? [];

  List<TableModel> get getTableList => tableData ?? [];

  List<RestaurantImageModel> get getRestoImageList => imageData ?? [];

  Future<bool> getData(var id) async {
    var r = await ApiProvider.searchRestoById(id);
    if (r['result']) {
      print("GOT PRODUCTS");
      print(r['items'][0]);
      data = SearchByIdModel.fromJson(r);
      items = data!.items ?? [];
      dataResto = data!.data ?? [];
      listMenu = data!.menu ?? [];
      menuList.insert(
        0,
        Menu(
          id: 0,
          mName: 'All',
        ),
      );
      print(data!.message);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getProductData(var id) async {
    var r = await ApiProvider.getProductData(id);
    if (r['result']) {
      dataProduct = SearchByIdModel.fromJson(r);
      items = dataProduct!.items ?? [];
      dataResto = dataProduct!.data ?? [];
      listMenu = dataProduct!.menu ?? [];
      menuList.insert(
        0,
        Menu(
          id: 0,
          mName: 'All',
        ),
      );

      print(dataProduct!.message);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getfilteritems(var id) async {
    var r = await ApiProvider.getMenuItemById(id);
    if (r['result']) {
      menuData = List<Item>.from(r["data"].map((x) => Item.fromJson(x)));

      return true;
    } else {
      return false;
    }
  }

  getTables(var id) async {
    var r = await ApiProvider.getTables(id);
    if (r['result']) {
      tableData = List<TableModel>.from(r["data"].map((x) => TableModel.fromJson(x)));
    } else {
      tableData = [];
    }
  }

  getRestaurantImage(var id) async {
    var r = await ApiProvider.getRestaurantImage(id);
    if (r['result']) {
      imageData = List<RestaurantImageModel>.from(r["data"].map((x) => RestaurantImageModel.fromJson(x)));
    } else {
      tableData = [];
    }
  }

  void getAllItems() {
    items = data!.items;
    notifyListeners();
  }

  void getFilterMenuItem() {
    items = [];
    items = menuData;
    notifyListeners();
  }

  void getAllMenuItem() {
    items = [];
    items = data!.items;
    notifyListeners();
  }
}
