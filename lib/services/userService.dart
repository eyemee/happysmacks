import 'package:http/http.dart';
import 'dart:convert';
import '../setting/appConstants.dart';

class UserService {
  Future<String> postLogin(String username, String password) async {
    String url =  AppConstants.baseURL + '/user/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    var json = {"user" : username, "password" : password};

    Response response = await post(url, headers: headers, body: jsonEncode(json));

    if( response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to login from the REST API');
    }
  }

  Future<String> postEmail(String username) async {
    String url =  AppConstants.baseURL + '/user/passwordcode';
    Map<String, String> headers = {"Content-type": "application/json"};
    var json = {"user" : username};

    Response response = await post(url, headers: headers, body: jsonEncode(json));

    if( response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to post email from the REST API');
    }
  }

  Future<String> postRegister(String username, String password, String fname, String mname, String lname) async {
    String url =  AppConstants.baseURL + '/user/signup';
    Map<String, String> headers = {"Content-type": "application/json"};
    var json =
    {
      "user" : username,
      "password" : password,
      "fname" : fname,
      "mname" : mname,
      "lname" : lname
    };

    Response response = await post(url, headers: headers, body: jsonEncode(json));

    if( response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to register from the REST API');
    }
  }

  Future<String> postChangePassword(String username, String password, String otpcode) async {
    String url =  AppConstants.baseURL + '/user/changepassword';
    Map<String, String> headers = {"Content-type": "application/json"};
    var json =
    {
      "user" : username,
      "password" : password,
      "otpcode" : otpcode
    };

    Response response = await post(url, headers: headers, body: jsonEncode(json));

    if( response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unable to change password from the REST API');
    }
  }

}