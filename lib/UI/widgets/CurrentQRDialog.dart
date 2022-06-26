import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CurrentQRDialog extends Dialog {
  final String qrCode;

  CurrentQRDialog(this.qrCode);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: colorTextWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Hero(
          tag: "qrcode",
          child: Container(
            width: 300,
            height: 300,
            // child: Image.memory(
            //   base64Decode(image),
            //   fit: BoxFit.cover,
            // ),
            child: QrImage(
              data: qrCode,
              version: 2,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
