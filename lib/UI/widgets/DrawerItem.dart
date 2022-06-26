import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';

Widget drawerItem({String? title, IconData? icon}) {
  return Container(
    margin: EdgeInsets.only(right: 4),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: colorPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: Icon(
            icon ?? Icons.add,
            color: colorPrimary,
            size: 20,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          child: Text(
            title ?? " ",
            style: TextStyle(
                color: colorTextSub,
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}
