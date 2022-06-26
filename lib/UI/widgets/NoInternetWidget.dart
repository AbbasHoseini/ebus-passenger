import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatefulWidget {
  final Function? function;
  final BuildContext? context;
  const NoInternetWidget({Key? key, this.function, this.context})
      : super(key: key);

  @override
  _NoInternetWidgetState createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: colorTextSub2,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              'اتصال با اینترنت برقرار نیست',
              style: TextStyle(
                  color: colorTextSub2,
                  fontSize: fontSizeTitle + 5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                widget.function!(widget.context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12, spreadRadius: 1, blurRadius: 5)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'بارگزاری مجدد',
                      style: TextStyle(
                          color: colorTextWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.refresh,
                      color: colorTextWhite,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
