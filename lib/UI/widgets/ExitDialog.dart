import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';

class ExitDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    {
      print("tapped");
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      backgroundColor: colorTextWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'آیا از خروج برنامه مطمئن هستید؟',
                    style: TextStyle(
                        color: colorTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => setLogout(context),
                  key: Key('exitBtn'),
                  child: Text(
                    'خروج',
                    style: TextStyle(
                        color: colorTextWhite, fontWeight: FontWeight.bold),
                  ),
                  disabledColor: colorPrimary,
                  color: colorDanger,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: 4),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'انصراف',
                    style: TextStyle(color: colorTextPrimary),
                  ),
                  disabledColor: colorTextWhite,
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
