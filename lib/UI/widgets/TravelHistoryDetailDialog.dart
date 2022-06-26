import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class TravelHistoryDetailDialog extends StatelessWidget {
  TravelHistoryArgs? travelHistoryArgs;

  TravelHistoryDetailDialog({this.travelHistoryArgs});

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
                'جزئیات سفر انجام شدم',
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                //Flexible(),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      btnCancel,
                      style: TextStyle(color: colorPrimary),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: RaisedButton(
                    onPressed: () {
                      //todo
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      myProfileSuccess,
                      style: TextStyle(color: colorTextWhite),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledColor: colorPrimary,
                    color: colorPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
