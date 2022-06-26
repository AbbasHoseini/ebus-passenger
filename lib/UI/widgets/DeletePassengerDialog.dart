import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:provider/provider.dart';

class DeletePassengerDialog extends Dialog {
  int? id;
  DeletePassengerDialog({this.id});

  @override
  Widget build(BuildContext context) {
    PassengersViewModel passengersViewModel =
        Provider.of<PassengersViewModel>(context);

    return Dialog(
      key: Key('deletePassengerDialog'),
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
                'حذف مسافر',
                style: TextStyle(
                    color: colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: MaterialButton(
                    color: colorPrimary,
                    onPressed: () async {
                      print("id part1 $id");
                      await passengersViewModel.deletePassenger(id!, context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'تایید',
                      style: TextStyle(color: colorTextWhite),
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
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      btnCancel,
                      style: TextStyle(color: colorTextWhite),
                    ),
                    disabledColor: colorPrimary,
                    color: colorDanger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
