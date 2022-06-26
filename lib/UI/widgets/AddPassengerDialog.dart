import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AddPassengerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PassengersViewModel passengersViewModel =
        Provider.of<PassengersViewModel>(context);

    return Dialog(
      key: Key('addPassengerDialog'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: colorTextWhite,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'اضافه کردن مسافر',
                  style: TextStyle(
                      color: colorTextPrimary,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              TextField(
                key: Key("name"),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.text,
                controller: passengersViewModel.nameController,
                maxLines: 1,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.person,
                      color: colorPrimary,
                    ),
                  ),
                  labelText: 'نام',
                  labelStyle: TextStyle(
                      color: colorTextSub2,
                      fontSize: fontSizeTitle,
                      height: 1.5),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                key: Key("lastName"),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.text,
                controller: passengersViewModel.lastNameController,
                maxLines: 1,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.person,
                      color: colorPrimary,
                    ),
                  ),
                  labelText: 'نام خانوادگی',
                  labelStyle: TextStyle(
                      color: colorTextSub2,
                      fontSize: fontSizeTitle,
                      height: 1.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: TextField(
                  key: Key("nationalCode"),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  controller: passengersViewModel.nationalCodeController,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    icon: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        MdiIcons.numeric,
                        color: colorPrimary,
                      ),
                    ),
                    labelText: 'کد ملی',
                    labelStyle: TextStyle(
                        color: colorTextSub2,
                        fontSize: fontSizeTitle,
                        height: 1.5),
                  ),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: MaterialButton(
                      key: Key('cancelAddPassenger'),
                      color: colorDanger,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        btnCancel,
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
                      key: Key('addPassenger'),
                      onPressed: () async {
                        await passengersViewModel.addPassenger(context);
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
      ),
    );
  }
}
