import 'dart:convert';
import 'package:final_app_flutter/model/account_model.dart';
import 'package:final_app_flutter/model/shoes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Shared preferences login account
  //dùng để lấy danh sách tài khoản từ SharedPrefs

  Future<List<AccountModel>?> getAccount() async {
    SharedPreferences prefs = await _prefs;
    //Lấy dữ liệu chuỗi từ prefs với 1 khóa cụ thể
    String? data = prefs.getString('account');
    if (data == null) return null;
    // gán maps là kiểu dữ liệu danh sách với các phần tử map mà trong
    // đó khóa là String còn giá trị là dynamic dùng để thực hiện chuyển đổiu
    //chuỗi json từ biến 'data' thành các đối tượng map
    List<Map<String, dynamic>> maps = jsonDecode(data)
        //cast dùng để đảm bảo kết quả trả về là các đối tượng map còn as là dùng để ép kiểu maps
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<AccountModel> account =
        maps.map((e) => AccountModel.fromJson(e)).toList();
    return account;
  }

  //Lưu trữ danh sách tài khoản từ AccountModel từ SharedPrefs

  Future<void> addAccount(List<AccountModel> account) async {
    //thực hiện việc chuyển đổi từ một danh sách các đối tượng
    //AccountModel sang một danh sách các đối tượng Map<String, dynamic>
    List<Map<String, dynamic>> maps = account.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    // lưu trữ 1 chuỗi vào prefs vào 1 khóa cụ thể key và value
    //chuyển đổi danh sách maps thành 1 chuổi json
    prefs.setString('account', jsonEncode(maps));
  }

  //Shared preferences signup account
  Future<List<AccountModel>?> getSignup() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('signup');
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<AccountModel> signup =
        maps.map((e) => AccountModel.fromJson(e)).toList();
    return signup;
  }

  Future<void> addSignup(List<AccountModel> signup) async {
    List<Map<String, dynamic>> maps = signup.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('signup', jsonEncode(maps));
  }

//shared prefferences imagePick
//Truy xuất đường dẫn của hình ảnh đã được lưu trữ trước đó.
  Future<String?> getImagePath() async {
    SharedPreferences prefs = await _prefs;
    // trả về 1 đương dẫn ảnh với khóa là imagePath
    return prefs.getString('imagePath');
  }

//Lưu trữ đường dẫn của một hình ảnh vào SharedPreferences.
  Future<void> setImagePath(String imagePath) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('imagePath', imagePath);
  }

  //shared prefferences cartIterm
  Future<List<ShoesModel>?> getCart() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('cartLists');
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<ShoesModel> cartLists =
        maps.map((e) => ShoesModel.fromJson(e)).toList();
    return cartLists;
  }

  Future<void> saveCart(List<ShoesModel> cartItems) async {
    SharedPreferences prefs = await _prefs;
    List<Map<String, dynamic>> maps = cartItems.map((e) => e.toJson()).toList();
    prefs.setString('cartLists', jsonEncode(maps));
  }
}
