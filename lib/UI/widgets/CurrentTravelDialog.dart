import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';

class CurrentTravelDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
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
                'آیا می‌خواهید جزئیات بلیط خریداری شده را مشاهده کنید؟',
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'خیر',
                    style: TextStyle(color: colorTextPrimary),
                  ),
                  disabledColor: colorTextWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: colorDivider)),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed("/CurrentTravelView")
                        .then((onValue) {
                      Navigator.pop(context);
                    });
                  },
                  key: Key('exitBtn'),
                  child: Text(
                    'بله',
                    style: TextStyle(color: colorTextWhite),
                  ),
                  disabledColor: colorPrimary,
                  color: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
