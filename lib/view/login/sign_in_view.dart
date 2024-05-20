// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:reliby/common/api.dart';
import 'package:reliby/common/color_extenstion.dart';
import 'package:reliby/component/keyboard.dart';
import 'package:reliby/view/home/home_view.dart';
import 'package:reliby/view/login/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'package:http/http.dart' as http;

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtCode = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;

  final formkey = GlobalKey<FormState>();

  savePref(
    String firstName,
    String lastName,
    String email,
    String phone_number,
    String bookPurchases,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("firstName", firstName);
    preferences.setString("lastName", lastName);
    preferences.setString("email", email);
    preferences.setString("phone_number", phone_number);
    preferences.setString("bookPurchases", bookPurchases);
    print(preferences.getString("firstName"));
    print(preferences.getString("email"));
    print(preferences.getString("id"));
  }

  signin() async {
    var formdata = formkey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      var data = {
        "email": txtEmail.text,
        "password": txtPassword.text,
      };
      var url = Uri.parse("${Api.local}Login.php");
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      print(responsebody);
      KeyboardUtil.hideKeyboard(context);
      if (responsebody['status'] == "success") {
        KeyboardUtil.hideKeyboard(context);
        savePref(
          responsebody['first_name'],
          responsebody['last_name'],
          responsebody['email'],
          responsebody['phone_number'],
          responsebody['bookPurchases'],
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        // Handle login failure
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.primary,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: TColor.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundTextField(
                  controller: txtEmail,
                  hintText: "Email Address",
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundTextField(
                  controller: txtPassword,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    IconButton(
                      // padding: EdgeInsets.only(right: 5),
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          isStay = !isStay;
                        });
                      },
                      icon: Icon(
                        isStay
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isStay
                            ? TColor.primary
                            : TColor.subTitle.withOpacity(0.3),
                      ),
                    ),
                    Text(
                      "Stay Logged In",
                      style: TextStyle(
                        color: TColor.subTitle.withOpacity(0.3),
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordView()));
                      },
                      child: Text(
                        "Forgot Your Password?",
                        style: TextStyle(
                          color: TColor.subTitle.withOpacity(0.3),
                          fontSize: 8,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                RoundLineButton(
                  title: "Sign In",
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                    signin();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
