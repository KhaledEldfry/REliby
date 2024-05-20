import 'dart:convert';
import 'package:reliby/common/api.dart';
import 'package:reliby/component/keyboard.dart';
import 'package:reliby/view/home/home_view.dart';
import 'package:reliby/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/color_extenstion.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'package:http/http.dart' as http;

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtUser_id = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtlastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;
  final formkey = GlobalKey<FormState>();

  savePref(
      String firstName, String lastName, String email, String user_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", user_id);
    preferences.setString("firstName", firstName);
    preferences.setString("lastName", lastName);
    preferences.setString("email", email);
    print(preferences.getString("firstName"));
    print(preferences.getString("email"));
    print(preferences.getString("id"));
  }

  signUp() async {
    var formdata = formkey.currentState;
    if (formdata!.validate()) {
      formdata.save();

      var url = Uri.parse("${Api.local}Registration.php");

      var data = {
        // "user_id ": txtUser_id.text,
        "first_name": txtFirstName.text,
        "last_name": txtlastName.text,
        "email": txtEmail.text,
        "phone_number": txtMobile.text,
        "password": txtPassword.text,
      };

      var response = await http.post(url, body: data);

      var responsebody = jsonDecode(response.body);
      print(responsebody);
      if (responsebody['status'] == "success") {
        savePref(
            txtFirstName.text, txtlastName.text, txtEmail.text, txtMobile.text);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeView())); // Rest of your code
      } else {
        print("login faild");
      }
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  "Sign up",
                  style: TextStyle(
                      color: TColor.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundTextField(
                  controller: txtFirstName,
                  hintText: "First Name",
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundTextField(
                  controller: txtlastName,
                  hintText: "Last Name",
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundTextField(
                  controller: txtEmail,
                  hintText: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  // validator: (val) {
                  //   const pattern =
                  //       r"(?:[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'"
                  //       r'+/=?^_`{|}~-]+)|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                  //       r'\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])")@(?:(?:[a-z0-9](?:[a-z0-9-]'
                  //       r'[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-][a-z0-9])?|[(?:(?:(2(5[0-5]|[0-4]'
                  //       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9])).){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                  //       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f'
                  //       r'x21-\x5a\x53-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])+)])';
                  //   final regex = RegExp(pattern);
                  //   return val!.isNotEmpty && !regex.hasMatch(val)
                  //       ? 'Enter a valid email'
                  //       : null;
                  // }
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundTextField(
                  controller: txtMobile,
                  hintText: "Mobile Phone",
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 15,
                ),
                // RoundTextField(
                //   controller: txtCode,
                //   hintText: "Group Special Code (optional)",
                // ),
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
                    Expanded(
                      child: Text(
                        "confirm terms and conditions",
                        style: TextStyle(
                          color: TColor.subTitle.withOpacity(0.3),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                RoundLineButton(
                  title: "Sign Up",
                  onPressed: () {
                    signUp();
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
