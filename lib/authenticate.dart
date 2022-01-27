import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/signup/signup.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  static const String id = 'Authenticate';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  UserDataState? userData;
  getUserData() async {
    await SharedPreferences.getInstance().then((value) => {
          if (mounted)
            {
              this.setState(() {
                var email = value.getString("email") != null ? value.getString("email")! : "";
                var token = value.getString("token") != null ? value.getString("token")! : "";
                var firstName = value.getString("firstName") != null ? value.getString("firstName")! : "";
                var lastName = value.getString("lastName") != null ? value.getString("lastName")! : "";
                var mobile = value.getString("mobile") != null ? value.getString("mobile")! : "";
                var city = value.getString("city") != null ? value.getString("city")! : "";
                var profile = value.getString("profileImage") != null ? value.getString("profileImage")! : "";

                userData!.updateEmail(email);
                userData!.updateFirstName(firstName);
                userData!.updateLastName(lastName);
                userData!.updateLocation(city);
                userData!.updateMobileNumber(mobile);
                userData!.updateToken(token);
                userData!.updateProfileImage(profile);
                Constants.token = userData!.getUserData.token;
              })
            }
        });
  }

  void isSignIn() async {
    await getUserData();
    if (userData!.getUserData.email != "") {
      Navigator.pushReplacementNamed(context, MainPage.id);
    } else {
      Navigator.pushReplacementNamed(context, SignUpPage.id);
    }
  }

  @override
  void initState() {
    super.initState();
    userData = Provider.of<UserDataState>(context, listen: false);
    isSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      )),
    );
  }
}
