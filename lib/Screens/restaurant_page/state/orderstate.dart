import 'package:blue_witcher/Screens/restaurant_page/models/food_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/food_card.dart';
import 'package:flutter/cupertino.dart';

class OrderState with ChangeNotifier {
  List<FoodModel> _foodModel = <FoodModel>[];
  TableModel? selectedTable;

  int? discount;

  // Cart data list
  List<FoodModel> get getOrder => _foodModel;

  get getItemsCount {
    int count = 0;
    for (FoodModel item in _foodModel) count += item.quantity;
    return count;
  }

  int getItemQuantity(int id) {
    for (FoodModel item in _foodModel) if (item.id == id) return item.quantity;
    return 0;
  }

  int get getTotalAmount {
    int totalPrice = 0;
    for (int i = 0; i < _foodModel.length; i++) totalPrice += _foodModel[i].price;

    return totalPrice;
  }

  List<List> get getOrderIds {
    List<List> _result = [];
    for (FoodModel item in _foodModel) {
      _result.add([item.id, item.quantity]);
    }

    return _result;
  }

  // Add item to order
  addToOrder(FoodModel value) {
    bool _isUpdated = false;
    if (value.quantity == 0) {
      List<FoodModel> _newFoodModelList = [];
      for (int i = 0; i < _foodModel.length; i++)
        if (_foodModel[i].id != value.id) {
          _newFoodModelList.add(_foodModel[i]);
          _isUpdated = true;
        }
      _foodModel = _newFoodModelList;
    } else {
      for (int i = 0; i < _foodModel.length; i++)
        if (_foodModel[i].id == value.id) {
          _foodModel[i] = value;
          _isUpdated = true;
        }
      if (!_isUpdated) _foodModel.add(value);
    }
    notifyListeners();
  }

  // Remove item to order
  removeToOrder(FoodModel value) {
    _foodModel.remove(value);
    notifyListeners();
  }

  void setTableNo(int id, int tno) {
    selectedTable = TableModel(id: id, tableNo: tno);
    notifyListeners();
  }

  TableModel? get getTableNo => selectedTable;

  clear() {
    _foodModel = [];
    selectedTable = null;
    discount = null;
  }
}
