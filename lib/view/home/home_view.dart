import 'dart:convert';

import 'package:reliby/common/api.dart';
import 'package:reliby/common/color_extenstion.dart';
import 'package:reliby/component/drawer.dart';
import 'package:reliby/view/details/details.dart';
import 'package:reliby/view/search/search_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/recently_cell.dart';
import '../../common_widget/top_picks_cell.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

  List topPicksArr = [
    {
      "name": "The Dissapearance of Emila Zola",
      "author": "Michael Rosen",
      "img": "assets/img/1.jpg"
    },
    {
      "name": "Fatherhood",
      "author": "Marcus Berkmann",
      "img": "assets/img/2.jpg"
    },
    {
      "name": "The Time Travellers Handbook",
      "author": "Stride Lottie",
      "img": "assets/img/3.jpg"
    }
  ];

  List bestArr = [
    {
      "name": "Fatherhood",
      "author": "by Christopher Wilson",
      "img": "assets/img/4.jpg",
      "rating": 5.0
    },
    {
      "name": "In A Land Of Paper Gods",
      "author": "by Rebecca Mackenzie",
      "img": "assets/img/5.jpg",
      "rating": 4.0
    },
    {
      "name": "Tattletale",
      "author": "by Sarah J. Noughton",
      "img": "assets/img/6.jpg",
      "rating": 3.0
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

  // List recentArr = [
  //   {
  //     "name": "The Fatal Tree",
  //     "author": "by Jake Arnott",
  //     "img": "assets/img/bookcover2.png",
  //     "desc": "by Jake Arnott",
  //     "price": 30
  //   },
  // ];

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
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScaffoldKey,
      endDrawer: MyDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: TColor.primary,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.5)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Row(children: const [
                        Text(
                          "Our Top Picks",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                      leading: Container(),
                      leadingWidth: 1,
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchView()));
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              sideMenuScaffoldKey.currentState?.openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.9,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return TopPicksCell(
                            iObj: iObj,
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          viewportFraction: 0.45,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "New Books",
                          style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: media.width * 0.9,
                      child: FutureBuilder(
                        future: getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
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
                                              builder: (context) => Details1(
                                                    name:
                                                        "${snapshot.data[i]["book_title"]}",
                                                    desc:
                                                        "${snapshot.data[i]["bookContent"]}",
                                                    img:
                                                        "assets/img/bookcover2.png",
                                                    price:
                                                        "${snapshot.data[i]["price"]}",
                                                    author:
                                                        "${snapshot.data[i]["author_id"]}",
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
