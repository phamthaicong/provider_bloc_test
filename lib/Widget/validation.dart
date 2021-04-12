import 'package:regexpattern/regexpattern.dart';

class Validation {
  String checkUsername(String value) {
    // print('ussername-->$value');
    if (value == "") {
      return "Không được để chống email";
    }
    if (value.isEmail() == false) {
      return "Email không đúng định dạng";
    }
    return null;
  }

  String checkPassword(String value) {
    if (value == "") {
      return "Vui lòng điền mật khẩu";
    }
    if (value.length < 8) {
      return "Mật khẩu lớn hơn 8 ký tự";
    }
    return null;
  }

  String checkEmty(String value) {
    if (value == "") {
      return "Không được để chống";
    }
    if (value != null) {
      return "";
    }
    // return " ";
  }

  String checkPhoneNumber(String value) {
    if (value == null) {
      return "Không được để chống";
    }
    if (value.isNumeric() == false) {
      return "Không phải số điện thoại";
    }
    return "";
  }
}