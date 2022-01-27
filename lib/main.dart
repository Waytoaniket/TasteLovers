import 'package:blue_witcher/Screens/booking/booking.dart';
import 'package:blue_witcher/Screens/forget_password/forget_password.dart';
import 'package:blue_witcher/Screens/home/home_page.dart';
import 'package:blue_witcher/Screens/offers/offer.dart';
import 'package:blue_witcher/Screens/order/order_detail.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/home/state/location_service.dart';
import 'package:blue_witcher/Screens/home/state/search_state.dart';
import 'package:blue_witcher/Screens/login/login.dart';
import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/otp/otp.dart';
import 'package:blue_witcher/Screens/profile/profile_page.dart';
import 'package:blue_witcher/Screens/registration/registration.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/counterstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/restaurant_page.dart';
import 'package:blue_witcher/Screens/reviews/state/review_state.dart';
import 'package:blue_witcher/Screens/setting/setting.dart';
import 'package:blue_witcher/Screens/signup/signup.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/Screens/table_booking/state/table_state.dart';
import 'package:blue_witcher/Screens/table_booking/table_booking.dart';
import 'package:blue_witcher/Screens/update_profile/update_profile.dart';
import 'package:blue_witcher/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Screens/order/order_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CounterState()),
            ChangeNotifierProvider(create: (_) => OrderState()),
            ChangeNotifierProvider(create: (_) => SearchState()),
            ChangeNotifierProvider(create: (_) => RestaurantState()),
            ChangeNotifierProvider(create: (_) => UserDataState()),
            ChangeNotifierProvider(create: (_) => LocationService()),
            ChangeNotifierProvider(create: (_) => TableState()),
            ChangeNotifierProvider(create: (_) => ReviewState()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sizer',
            theme: ThemeData.light(),
            home: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'BlueWitcher',
              builder: EasyLoading.init(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: Authenticate.id,
              routes: {
                SignUpPage.id: (context) => SignUpPage(),
                OtpPage.id: (context) => OtpPage(),
                RegistrationPage.id: (context) => RegistrationPage(),
                MainPage.id: (context) => MainPage(),
                HomePage.id: (context) => HomePage(),
                RestaurantPage.id: (context) => RestaurantPage(),
                OrderPage.id: (context) => OrderPage(),
                ProfilePage.id: (context) => ProfilePage(),
                Authenticate.id: (context) => Authenticate(),
                Login.id: (context) => Login(),
                ForgetPassword.id: (context) => ForgetPassword(),
                Setting.id: (context) => Setting(),
                UpdatePtofile.id: (context) => UpdatePtofile(),
                BookingPage.id: (context) => BookingPage(),
                TableBookingPage.id: (context) => TableBookingPage(),
                OffersPage.id: (context) => OffersPage(),
              },
            ),
          ),
        );
      },
    );
  }
}
