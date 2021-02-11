import 'dart:convert';

import 'package:mysqlcrud/model/userModel.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const ADD_URL = "http://192.168.56.1/mysqlcrud/add.php";
  static const VIEW_URL = "http://192.168.56.1/mysqlcrud/read.php";
  static const UPDATE_URL = "http://192.168.56.1/mysqlcrud/edit.php";
  static const DELETE_URL = "http://192.168.56.1/mysqlcrud/delete.php";

  Future<String> addUser(UserModel userModel) async {
    final response = await http.post(ADD_URL, body: userModel.toJsonAdd());
    if (response.statusCode == 200) {
      print("Add Response" + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }

  List<UserModel> userFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<UserModel>.from(data.map((item) => UserModel.fromJson(item)));
  }

  Future<List<UserModel>> getUser() async {
    final response = await http.get(VIEW_URL);
    if (response.statusCode == 200) {
      List<UserModel> list = userFromJson(response.body);
      return list;
    } else {
      return List<UserModel>();
    }
  }

  Future<String> updateUser(UserModel userModel) async {
    final response =
        await http.post(UPDATE_URL, body: userModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print("Update Response" + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }

  Future<String> deleteUser(UserModel userModel) async {
    final response =
        await http.post(DELETE_URL, body: userModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print("Delete Response" + response.body);
      return response.body;
    } else {
      return "Error";
    }
  }
}
