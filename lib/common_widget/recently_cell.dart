import 'package:flutter/material.dart';

import '../common/color_extenstion.dart';

class RecentlyCell extends StatelessWidget {
  var img;
  var name;
  var author;
  Function()? onTap;
  RecentlyCell(
      {super.key,
      required this.name,
      required this.author,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        // color: Colors.red,
        width: media.width * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 5)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/img/bookcover2.png",
                    width: media.width * 0.32,
                    height: media.width * 0.50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "$name",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: TColor.text,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "$author",
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: TColor.subTitle,
                fontSize: 11,
              ),
            )
          ],
        ));
  }
}
