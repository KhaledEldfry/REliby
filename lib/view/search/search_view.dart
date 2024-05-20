import 'dart:convert';

import 'package:reliby/common_widget/recently_cell.dart';
import 'package:reliby/view/details/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../common/api.dart';
import '../../common/color_extenstion.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController txtSearch = TextEditingController();
  int selectTag = 0;
  List tagsArr = ["New Release", "education", "Art", "novel"];

  Future getData() async {
    var url = Uri.parse("${Api.local}getBooks.php");
    var response = await http.post(
      url,
    );
    var responsebody = jsonDecode(response.body);
    print(">>>>>>>>>>>>>>>>>>" + responsebody.toString());

    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: TColor.textbox,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: TColor.text),
                      hintText: "Search Books. Authors. or ISBN",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              if (txtSearch.text.isNotEmpty)
                const SizedBox(
                  width: 8,
                ),
              if (txtSearch.text.isNotEmpty)
                TextButton(
                    onPressed: () {
                      txtSearch.text = "";
                      setState(() {});
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: TColor.text,
                        fontSize: 17,
                      ),
                    ))
            ],
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: tagsArr.map((tagName) {
                    var index = tagsArr.indexOf(tagName);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectTag = index;
                          });
                        },
                        child: Text(
                          tagName,
                          style: TextStyle(
                              color: selectTag == index
                                  ? TColor.text
                                  : TColor.subTitle,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (txtSearch.text.isEmpty)
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return RecentlyCell(
                              author: snapshot.data[i]['author_id'].toString(),
                              name: snapshot.data[i]['book_title'].toString(),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Details1(
                                              name:
                                                  "${snapshot.data[i]["book_title"]}",
                                              desc:
                                                  "${snapshot.data[i]["bookContent"]}",
                                              img: "assets/img/bookcover2.png",
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
              )
          ],
        ));
  }
}
