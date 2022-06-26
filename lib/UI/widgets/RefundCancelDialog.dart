import 'package:ebus/core/models/Refund.dart';
import 'package:ebus/core/viewmodels/RefundsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:provider/provider.dart';

class RefundCancelDialog extends Dialog {
  final Refund refund;

  RefundCancelDialog(this.refund);
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
                'آیا از لغو استرداد مطمئن هستید؟',
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
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
                MaterialButton(
                  onPressed: () {
                    RefundsViewModel refundsViewModel =
                        Provider.of<RefundsViewModel>(context, listen: false);
                    refundsViewModel.cancelRefund(refund, context);
                    Navigator.of(context).pop();
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
