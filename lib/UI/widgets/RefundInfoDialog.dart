import 'package:ebus/core/models/Refund.dart';
import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';

class RefundInfoDialog extends Dialog {
  final Refund refund;

  RefundInfoDialog(this.refund);
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'موضوع',
              style: TextStyle(
                  color: colorTextSub,
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              refund.subject ?? ' ',
              style: TextStyle(
                  color: colorTextPrimary,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.normal),
            ),
            Divider(
              indent: 32,
              endIndent: 32,
            ),
            Text(
              'توضیحات',
              style: TextStyle(
                  color: colorTextSub,
                  fontSize: fontSizeSubTitle,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              refund.description ?? ' ',
              style: TextStyle(
                  color: colorTextPrimary,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
