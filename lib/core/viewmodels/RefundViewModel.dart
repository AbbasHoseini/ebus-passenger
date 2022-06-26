import 'package:ebus/core/models/Refund.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RefundViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  RefundViewModel({this.authServiceType});
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _isSubmiting = false;
  bool get isSubmiting => _isSubmiting;
  Refund? _refund;

  Future submitRefund(BuildContext context, int travelTicketId) async {
    _isSubmiting = true;
    notifyListeners();
    String phone = (await getUserInfo())[6];
    _refund = Refund(
        id: 1,
        subject: subjectController.text,
        description: descriptionController.text,
        travelTicketId: travelTicketId,
        phone: phone,
        status: 0);
    http.Response? result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        // result = await MockWebservice().getPostRefund();
      } else {
        result = await Webservice().postRefund(_refund!);
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    int statusCode = result!.statusCode;
    switch (statusCode) {
      case 200:
        _successRefund(context);
        notifyListeners();
        break;
      case 201:
        _successRefund(context);
        notifyListeners();
        break;
      default:
        showInfoFlushbar(
            context, 'خطا در ارتباط با سرور', 'لطفا دوباره تلاش کنید', false);
        _isSubmiting = false;
        notifyListeners();
    }
  }

  void _successRefund(BuildContext context) {
    showInfoFlushbar(
        context, 'استرداد بلیط با موفقیت انجام شد', 'در انتظار تأیید', false);
    _clear();
  }

  void _clear() {
    subjectController.clear();
    descriptionController.clear();
    _isSubmiting = false;
  }
}
