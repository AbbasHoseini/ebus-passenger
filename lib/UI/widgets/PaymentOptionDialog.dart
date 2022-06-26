import 'dart:convert';

import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOptionDialog extends StatelessWidget {
  InvoiceArgs? invoiceArgs;
  PaymentOptionDialog({this.invoiceArgs});

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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "پیش فاکتور",
                style: TextStyle(fontSize: fontSizeTitle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "مبلغ قابل پرداخت" +
                    " " +
                    "${invoiceArgs!.discountAmount}" +
                    " " +
                    "تومان",
                style: TextStyle(fontSize: fontSizeMedTitle),
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "مبلغ کل بدون تخفیف" +
                    " " +
                    "${invoiceArgs!.invoiceTotal}" +
                    " " +
                    "تومان",
                style: TextStyle(fontSize: fontSizeMedTitle),
                textDirection: TextDirection.rtl,
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                myInvoicePayment,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: MaterialButton(
                    onPressed: () {
                      payByBank();
                    },
                    child: Text(
                      myInvoiceBankPayment,
                      style: TextStyle(color: colorTextWhite),
                    ),
                    disabledColor: colorPrimary,
                    color: colorPrimary,
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
                    onPressed: () async {
                      //TODO
                      if (invoiceArgs!.discountAmount == null ||
                          invoiceArgs!.discountAmount! <= 0) {
                        showInfoFlushbar(context, "مبلغ پرداختی معتبر نیست",
                            "مبلغ پرداختی معتبر نیست", false,
                            durationSec: 2);
                      } else {
                        String token = await getToken();
                        Webservice()
                            .getPayByCreditResult(token, invoiceArgs!)
                            .then((response) {
                          if (response != null) {
                            final bodyResponse = json.decode(response.body);
                            int statusCode = response.statusCode;

                            if (statusCode == 200 || statusCode == 201) {
                              Navigator.pushNamed(
                                context,
                                '/AssignPassengersView',
                              );
                            } else {
                              String message;
                              message = bodyResponse["message"];
                              showInfoFlushbar(context, 'خطا', message, false,
                                  durationSec: 3);
                            }
                          }
                        });
                      }
                    },
                    child: Text(
                      myInvoiceWalletPayment,
                      style: TextStyle(color: colorTextWhite),
                    ),
                    disabledColor: colorPrimary,
                    color: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                )
              ],
            ),
            Divider(),
            Flexible(
              child: RaisedButton(
                color: colorTextWhite,
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
          ],
        ),
      ),
    );
  }

  void payByBank() {
    Webservice()
        .getPayByBank(invoiceArgs!.discountAmount!, invoiceArgs!.ticketId!)
        .then((value) {});
  }
}
