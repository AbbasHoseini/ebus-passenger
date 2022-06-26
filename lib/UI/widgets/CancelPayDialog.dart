import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';

class CancelPayDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    {
      print("tapped");
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: colorTextWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'درصورت خروج از این صفحه، صندلی‌های رزرو شده به حالت تعلیق درآمده و تا ۱۵ دقیقه قابل رزرو نخواهند بود.',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: Text(
                      'انصراف',
                      style: TextStyle(
                          color: colorTextWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/MainView', (Route<dynamic> route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                        color: colorDanger,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ]),
                    child: Text(
                      'خروج',
                      style: TextStyle(
                          color: colorTextWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeTitle),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
