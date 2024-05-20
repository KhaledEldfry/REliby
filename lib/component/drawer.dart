import 'package:reliby/common/color_extenstion.dart';
import 'package:reliby/view/account/account_view.dart';
import 'package:reliby/view/login/sign_in_view.dart';
import 'package:reliby/view/main_tab/main_tab_view.dart';
import 'package:reliby/view/onboarding/welcome_view.dart';
import 'package:reliby/view/our_book/out_books_view.dart';
import 'package:reliby/view/search/search_view.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  TabController? controller;
  List menuArr = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Our Books", "icon": Icons.book},
    {"name": "Account", "icon": Icons.account_circle},
    {"name": "LogOut", "icon": Icons.logout_outlined},
  ];

  int selectMenu = 0;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: media.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
            color: TColor.dColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(media.width * 0.7),
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 15)
            ]),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: menuArr.map((mObj) {
                    var index = menuArr.indexOf(mObj);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: selectMenu == index
                          ? BoxDecoration(color: TColor.primary, boxShadow: [
                              BoxShadow(
                                  color: TColor.primary,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3))
                            ])
                          : null,
                      child: GestureDetector(
                        onTap: () {
                          if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchView()));
                            sideMenuScaffoldKey.currentState?.closeEndDrawer();
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountView()));
                            sideMenuScaffoldKey.currentState?.closeEndDrawer();
                          } else if (index == 3) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomeView()));
                            sideMenuScaffoldKey.currentState?.closeEndDrawer();
                          }

                          //

                          setState(() {
                            selectMenu = index;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              mObj["name"].toString(),
                              style: TextStyle(
                                  color: selectMenu == index
                                      ? Colors.white
                                      : TColor.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Icon(
                              mObj["icon"] as IconData? ?? Icons.home,
                              color: selectMenu == index
                                  ? Colors.white
                                  : mObj["name"] == "LogOut"
                                      ? Colors.red
                                      : TColor.primary,
                              size: 33,
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
