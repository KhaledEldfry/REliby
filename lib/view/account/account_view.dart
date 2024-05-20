import 'dart:convert';

import 'package:reliby/common/api.dart';
import 'package:reliby/common_widget/recently_cell.dart';
import 'package:reliby/view/book_reading/book_reading_view.dart';
import 'package:reliby/view/book_reading/webreadingview.dart';
import 'package:flutter/material.dart';
import 'package:reliby/view/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extenstion.dart';
import 'package:http/http.dart' as http;

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  List purArr = ["assets/img/p1.jpg", "assets/img/p2.jpg", "assets/img/p3.jpg"];

  List sResultArr = [
    {
      "img": "assets/img/p1.jpg",
      "description":
          "A must read for everybody. This book taught me so many things about...",
      "rate": 5.0
    },
    {
      "img": "assets/img/p2.jpg",
      "description":
          "#1 international bestseller and award winning history book.",
      "rate": 4.0
    }
  ];

  List genresArr = [
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    },
    {
      "name": "Graphic Novels",
      "img": "assets/img/g1.png",
    }
  ];

  var email;
  var firstName;
  var lastName;
  var bookPurchases;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString("email");
      firstName = preferences.getString("firstName");
      lastName = preferences.getString("lastName");
      bookPurchases = preferences.getString("bookPurchases");
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }
  // var bObj = genresArr[index] as Map? ?? {};

  Future getData() async {
    var url = Uri.parse("${Api.local}getBooks.php");
    var response = await http.post(
      url,
    );
    var responsebody = jsonDecode(response.body);
    print(">>>>>>>>>>>>>>>>>>" + responsebody.toString());

    // print(">>>>>>>>>>>>>>>>>>" + responsebody);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: TColor.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$firstName",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        "assets/img/u1.png",
                        width: 70,
                        height: 70,
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.near_me_sharp,
                  //   color: TColor.subTitle,
                  //   size: 15,
                  // ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  // Expanded(
                  //     child: Text(
                  //   "Newcastle - Australia",
                  //   style: TextStyle(color: TColor.subTitle, fontSize: 13),
                  // )),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  // Container(
                  //   height: 30.0,
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(colors: TColor.button),
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: TColor.primary,
                  //           blurRadius: 2,
                  //           offset: const Offset(0, 2),
                  //         )
                  //       ]),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.transparent,
                  //         shadowColor: Colors.transparent),
                  //     child: const Text(
                  //       'Edit Profile',
                  //       style: TextStyle(fontSize: 12),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${bookPurchases.toString()}",
                        style: TextStyle(
                            color: TColor.subTitle,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Books",
                        style: TextStyle(color: TColor.subTitle, fontSize: 11),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "5",
                  //       style: TextStyle(
                  //           color: TColor.subTitle,
                  //           fontSize: 30,
                  //           fontWeight: FontWeight.w700),
                  //     ),
                  //     const SizedBox(
                  //       height: 8,
                  //     ),
                  //     Text(
                  //       "Reviews",
                  //       style: TextStyle(color: TColor.subTitle, fontSize: 11),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Text(
                "Your purchases (${bookPurchases.toString()})",
                style: TextStyle(
                    color: TColor.subTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Color(0xffFF5957),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 300,
                        width: 390,
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 12),
                        padding: EdgeInsets.only(left: 25),
                        child: FutureBuilder(
                          future: getData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  padding: EdgeInsets.only(right: 30),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return RecentlyCell(
                                      author: snapshot.data[i]['author_id']
                                          .toString(),
                                      name: snapshot.data[i]['book_title']
                                          .toString(),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsScreen(
                                                      bookName: snapshot.data[i]
                                                          ['book_title'],
                                                      bookContent:
                                                          snapshot.data[i]
                                                              ['bookContent'],
                                                    )));
                                      },
                                    );
                                  });
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
