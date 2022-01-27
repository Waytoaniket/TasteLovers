import 'package:blue_witcher/Screens/model/user_data_model.dart';
import 'package:flutter/cupertino.dart';

class UserDataState with ChangeNotifier {
  UserDataModel _userData = UserDataModel();
  UserDataModel get getUserData => _userData;
  void updateToken(String token) {
    _userData.token = token;
    notifyListeners();
  }

  void updateFirstName(String firstName) {
    _userData.firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName) {
    _userData.lastName = lastName;
    notifyListeners();
  }

  void updateEmail(String email) {
    _userData.email = email;
    notifyListeners();
  }

  void updateMobileNumber(String mobile) {
    _userData.mobile = mobile;
    notifyListeners();
  }

  void updateProfileImage(String profileImageUrl) {
    _userData.profileImageUrl = profileImageUrl;
    notifyListeners();
  }

  void updateLocation(String city) {
    _userData.city = city;
    notifyListeners();
  }

  void updateId(int id) {
    _userData.id = id;
    notifyListeners();
  }
}
