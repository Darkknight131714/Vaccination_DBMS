import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> login(String email, String password) async {
  var url = Uri.parse('https://gautam131714.000webhostapp.com/getlogin.php');
  var response = await http.get(url);
  if (response.body == "") {
    return "No User with that email";
  }
  var details = jsonDecode(response.body);
  int flag = 0;
  for (int i = 0; i < details.length; i++) {
    if (details[i]['email'] == email) {
      if (details[i]['password'] == password) {
        flag = 2;
        break;
      } else {
        flag = 1;
        break;
      }
    }
  }
  if (flag == 2) {
    return "True";
  } else if (flag == 1) {
    return "Incorrect Password";
  } else {
    return "No User with that email";
  }
}

Future<String> register(String email, String password, String username) async {
  if (email == "" || password == "" || username == "") {
    return "Please Fill All The Fields";
  }
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!emailValid) {
    return "Enter Valid Email";
  }
  if (password.length < 6) {
    return "Password Should be atleast 6 Characters";
  }
  Map<String, String> m = {
    "email": email,
    "password": password,
    "username": username
  };
  var url = Uri.parse('https://gautam131714.000webhostapp.com/adduser.php');
  await http.post(url, body: m);
  return "True";
}
