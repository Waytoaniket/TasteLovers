import 'dart:convert';
import 'dart:io';

import 'package:blue_witcher/Screens/home/model/search_list_model.dart';
import 'package:blue_witcher/Screens/offers/model/offer_model.dart';
import 'package:blue_witcher/Screens/reviews/model/review_modal.dart';
import 'package:blue_witcher/constant.dart';
import 'package:http/http.dart';

class ApiProvider {
  // -------------------------------------------Webservice Url--------------------------------------------------------------

  static Uri registerUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/public/api/adduser");

  static Uri verifyMobileNoUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/public/api/verifyPhone");

  static Uri verifyOtpUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/public/api/verifysignup");

  static Uri searchRestaurantUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/serachrest");

  static Uri searchProductUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/productname");

  static String baseUrl = 'http://tasteslover.bluewitcherprojects.com/api';

  static Uri updateProfileUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/updateProfile");

  static Uri updateMobileUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/updateMobile");

  static Uri oderHistoryUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/getOrderHistory");

  static Uri verifyNewOtpUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/verifyNewMobile");

  static Uri updateBookingPaymentUrl =
      Uri.parse("http://tasteslover.bluewitcherprojects.com/api/update_booking_payment");

  static Uri getTablesBookingUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/getAllBookings");

  static Uri bookingHistoryUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/getBookingHistory");

  static Uri bookingDetailsUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/getBookingTables");

  static Uri offerUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/offers");

  static Uri getreviewUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/all_comments");

  static Uri addreviewUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/add_comment");

  static Uri updateRatingUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/item_rating");

  static Uri addCommentUrl = Uri.parse("http://tasteslover.bluewitcherprojects.com/api/add_comment_reply");

  static String imageBaseUrl = 'http://tasteslover.bluewitcherprojects.com/';

  // ------------------------------------------------------------------------------------------------------------------

  static Future registerUser(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    try {
      Response response =
          await post(registerUrl, headers: headers, body: jsonRequest).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw 'Timeout';
      });

      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"success":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future verifyMobile(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    String jsonRequest = json.encode(body);
    try {
      Response response = await post(verifyMobileNoUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw 'Timeout';
      });

      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"success":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future verifyOtp(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    String jsonRequest = json.encode(body);
    try {
      Response response =
          await post(verifyOtpUrl, headers: headers, body: jsonRequest).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "Timeout";
      });

      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"success":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future<SearchListModel> getRestaurantSearchList(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    print(jsonRequest + " res");
    try {
      Response response = await post(searchRestaurantUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      print(SearchListModel.fromJson(json.decode(response.body)).toJson());
      return SearchListModel.fromJson(json.decode(response.body));
    } catch (error) {
      Response response = Response('{"success":false,"message":"We have Some Internal Issuse!"}', 404);
      print(SearchListModel.fromJson(json.decode(response.body)).toJson());
      return SearchListModel.fromJson(json.decode(response.body));
    }
  }

  static Future<SearchListModel> getProductSearchList(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    // print(jsonRequest);
    try {
      Response response = await post(searchProductUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      print(SearchListModel.fromJson(json.decode(response.body)).toJson());
      return SearchListModel.fromJson(json.decode(response.body));
    } catch (error) {
      Response response = Response('{"success":false,"message":"We have Some Internal Issuse!"}', 404);
      print(SearchListModel.fromJson(json.decode(response.body)).toJson());
      return SearchListModel.fromJson(json.decode(response.body));
    }
  }

  static Future updateProfile(Map<String, String> body, File imageFile) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    var request = new MultipartRequest("POST", updateProfileUrl);
    request.headers.addAll(headers);
    request.fields.addAll(body);
    if (imageFile.path != "") {
      var stream = new ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var pic = new MultipartFile('image', stream, length, filename: imageFile.path);
      request.files.add(pic);
    }
    try {
      var response = await request.send().timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(request.fields);
      print(responseString);
      return json.decode(responseString);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future updateMobile(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    // print(jsonRequest);
    try {
      Response response = await post(updateMobileUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future verifyNewOtp(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    // print(jsonRequest);
    try {
      Response response = await post(verifyNewOtpUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future updateBookingPayment(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    try {
      Response response = await post(updateBookingPaymentUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future getTablesBooking() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    try {
      Response response =
          await post(getTablesBookingUrl, headers: headers).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future getBookingHistory() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    try {
      Response response = await post(
        bookingHistoryUrl,
        headers: headers,
      ).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future getBookingDetail(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);
    try {
      Response response = await post(bookingDetailsUrl, headers: headers, body: jsonRequest)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future<AllOffers> getAllOffer() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    try {
      Response response = await post(offerUrl, headers: headers).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return AllOffers.fromJson(json.decode(response.body));
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!", "data":[]}', 404);
      return AllOffers.fromJson(json.decode(response.body));
    }
  }

  static Future<ReviewModel> getAllReview(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);

    try {
      Response response =
          await post(getreviewUrl, body: jsonRequest, headers: headers).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return ReviewModel.fromJson(json.decode(response.body));
    } catch (error) {
      print(error);
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!", "data":[]}', 404);
      return ReviewModel.fromJson(json.decode(response.body));
    }
  }

  static Future addReview(Map<String, String> body, File imageFile) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    var request = new MultipartRequest("POST", addreviewUrl);
    request.headers.addAll(headers);
    request.fields.addAll(body);
    if (imageFile.path != "") {
      var stream = new ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var pic = new MultipartFile('images', stream, length, filename: imageFile.path);
      request.files.add(pic);
    }
    try {
      var response = await request.send().timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(request.fields);
      print(responseString);
      return json.decode(responseString);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future addComment(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);

    try {
      Response response =
          await post(addCommentUrl, body: jsonRequest, headers: headers).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  //login a user
  static Future loginUser(var mobile, var password) async {
    var url = baseUrl + "/login?mobile=$mobile&password=$password";
    print(url);
    var r = await post(
      Uri.parse(url),
    );
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
    // Constants.token = jsonData['token'];
    // return jsonData['result'];
  }

//forget Pasword
  static Future<bool> forgetPassword(var mobile) async {
    var url = baseUrl + "/forgetpwd?mobile=$mobile";
    print(url);
    var r = await post(
      Uri.parse(url),
    );
    print(r.body);

    var jsonData = json.decode(r.body);
    return jsonData['result'];
  }

  //verify forget Password
  static Future<bool> verifyForgetPassword(var mobile, var otp) async {
    var url = baseUrl + "/verifyforgetpwd?mobile=$mobile&otp=$otp";
    print(url);
    var r = await post(
      Uri.parse(url),
    );
    print(r.body);

    var jsonData = json.decode(r.body);
    return jsonData['result'];
  }

  //Save New Password
  static Future<bool> saveNewPassword(var mobile, var password) async {
    var url = baseUrl + "/savepwd?mobile=$mobile&password=$password";
    print(url);
    var r = await post(
      Uri.parse(url),
    );
    print(r.body);

    var jsonData = json.decode(r.body);
    return jsonData['result'];
  }

  //Search Restauranys by id
  static Future searchRestoById(var id) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/serachrestbyid?restid=$id";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  static Future getHomeData() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(Constants.token);
    var url = baseUrl + "/getHomeData";
    print(url);
    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);
    try {
      var jsonData = json.decode(r.body);
      return jsonData;
    } catch (error) {
      var response = {'result': false, 'message': 'some internal error'};
      return response;
    }
  }

  //Filter Menu Items by id
  static Future getMenuItemById(var id) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/menuitems?menu_id=$id";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  //Search Product by id
  static Future getProductData(var id) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/productbyid?id=$id";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  //Search Product by id
  static Future getTables(var id) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/getTables?id=$id";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  //gety all Restaurant image
  static Future getRestaurantImage(var id) async {
    var url = baseUrl + "/getRestraImages?restid=$id";
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  // Apply Coupon Code
  static Future applyCoupon(String coupon) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/applyCoupon?coupon=$coupon";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  static Future placeOrder(int totalPrice, int couponOffer, int table, int restId, List<List> itemIds) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    String body = json.encode({
      "total_price": totalPrice,
      "coupon_offer": couponOffer,
      "table": table,
      "restid": restId,
      "item_ids": itemIds
    });
    var url = baseUrl + "/createOrder";
    print(url);
    var r = await post(Uri.parse(url), headers: headers, body: body);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  static Future confirmPendingOrder({required String orderId}) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/update_order_payment?status=success&order_id=$orderId";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  static Future getOrders() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/getAllOrders";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  static Future getOrderHistory() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    try {
      Response response = await post(
        oderHistoryUrl,
        headers: headers,
      ).timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!"}', 404);
      return json.decode(response.body);
    }
  }

  static Future updateRating(Map<String, String> body) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    print(headers);
    String jsonRequest = json.encode(body);

    try {
      Response response = await post(updateRatingUrl, body: jsonRequest, headers: headers)
          .timeout(Duration(seconds: 15), onTimeout: () {
        // time has run out, do what you wanted to do
        print("timeout");
        throw "TimeOut";
      });
      print(response.body);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      print(error);
      Response response = Response('{"result":false,"message":"We have Some Internal Issuse!", "data":[]}', 404);
      return json.decode(response.body);
    }
  }

  static getOrderDetails({required String id}) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/getOrderItems?order_id=$id";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

//Apply Table booking coupon
  static Future aplyTableBooking(var coupon) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = baseUrl + "/applyCoupon?coupon=$coupon";
    print(url);
    var r = await post(Uri.parse(url), headers: headers);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }

  // Table booking
  static Future tableBooking(var data) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer ${Constants.token}',
    };
    var jData = json.encode(data);
    var url = baseUrl + "/createBooking";
    print(url);
    var r = await post(Uri.parse(url), headers: headers, body: jData);
    print(r.body);
    var jsonData = json.decode(r.body);
    return jsonData;
  }
}

// 0 to rejected
// 1 to pending
// 2 confirmed
