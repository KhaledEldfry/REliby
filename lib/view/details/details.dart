import 'package:reliby/common_widget/round_button.dart';
import 'package:flutter/material.dart';

class Details1 extends StatefulWidget {
  // final title;
  // final desc;
  // final image;
  var price;
  var name;
  var author;
  var desc;
  var img;

  Details1({
    super.key,
    required this.name,
    required this.desc,
    required this.author,
    required this.img,
    required this.price,
  });

  @override
  State<Details1> createState() => _Details1State();
}

class _Details1State extends State<Details1> {
  //////   دي  رقم 1  \\\
  int item = 0;
  void addProduct() {
    setState(() {
      item++;
    });
  }

  //////   دي  رقم 1  \\\
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ////////////   دي  رقم 2  \\\\\\
        actions: [
          Container(
            child: Column(children: [
              if (item != 0)
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "$item",
                      style: TextStyle(color: Colors.red),
                    )),
              Icon(Icons.shopping_cart_outlined)
            ]),
          )
        ],
        ////////////   دي  رقم 2  \\\\\\
        title: const Text('Details'),
      ),
      body: Container(
        child: ListView(children: [
          Container(
              margin: EdgeInsets.all(15),
              child: Image.asset(
                "${widget.img}",
                width: 200,
                height: 500,
              )),
          Container(
            margin: EdgeInsets.all(8),
            child: Text(widget.name),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Text(widget.author),
          ),
          // Container(
          //   margin: EdgeInsets.all(8),
          //   child: Text(widget.desc),
          // ),
          Container(
            margin: EdgeInsets.all(8),
            child: Text("${widget.price}"),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: RoundLineButton(
              title: "ADD",
              onPressed: () {
                addProduct();
                // Navigator.of(context).push(
                // MaterialPageRoute<void>(
                //   builder: (BuildContext context) => const ()));
              },
            ),
          )
        ]),
      ),
    );
  }
}
