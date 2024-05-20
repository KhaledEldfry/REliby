import 'package:reliby/common/color_extenstion.dart';
import 'package:reliby/component/drawer.dart';
import 'package:flutter/material.dart';

import '../account/account_view.dart';
import '../home/home_view.dart';
import '../our_book/out_books_view.dart';
import '../search/search_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

class _MainTabViewState extends State<MainTabView>
    with TickerProviderStateMixin {
  TabController? controller;

  // int selectMenu = 0;

  // List menuArr = [
  //   {"name": "Home", "icon": Icons.home},
  //   {"name": "Our Books", "icon": Icons.book},
  //   {"name": "Our Stores", "icon": Icons.storefront},
  //   {"name": "Careers", "icon": Icons.business_center},
  //   {"name": "Sell With Us", "icon": Icons.attach_money},
  //   {"name": "Newsletter", "icon": Icons.newspaper},
  //   {"name": "Pop-up Leasing", "icon": Icons.open_in_new},
  //   {"name": "Account", "icon": Icons.account_circle}
  // ];

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScaffoldKey,
      endDrawer: MyDrawer(),
      body: TabBarView(controller: controller, children: [
        const HomeView(),
        const SearchView(),
        Container(),
        Container(),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: TColor.primary,
        child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.menu),
                text: "Wishlist",
              ),
              Tab(
                icon: Icon(Icons.shopping_bag),
                text: "Cart",
              ),
            ]),
      ),
    );
  }
}
