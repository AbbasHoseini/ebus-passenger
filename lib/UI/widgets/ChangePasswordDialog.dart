import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/core/viewmodels/ChangePassViewModel.dart';
import 'package:ebus/helpers/Constants.dart';

Future<Future> changePasswordDialog(BuildContext context, int id) async {
  final FocusNode focusNodeNewPassInput = FocusNode();
  final FocusNode focusNodeNewPassConfirmInput = FocusNode();
  final FocusNode focusNodeOldPassInput = FocusNode();
  TextEditingController newPassController = TextEditingController();
  TextEditingController newPassConfirmController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();

  final changePassVM = Provider.of<ChangePassViewModel>(context);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  return showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
            body: Center(
              child: Wrap(
                children: <Widget>[
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          key: Key("oldPass"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: focusNodeOldPassInput,
                          controller: oldPassController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            hintText: oldPassword,
                            hintStyle:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          key: Key("newPass"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: focusNodeNewPassInput,
                          controller: newPassController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            hintText: newPassword,
                            hintStyle:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          key: Key("newPassConfirm"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: focusNodeNewPassConfirmInput,
                          controller: newPassConfirmController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            hintText: newPasswordConfirm,
                            hintStyle:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          myProfileEditSubmit,
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                              ),
                        ),
                        onPressed: () async {
                          print(newPassController.text);
                          if (newPassController.text ==
                              newPassConfirmController.text) {
                            // TODO
                            // get token from sharedPreference
                            bool status = await changePassVM.confirmNewPass(
                                "token",
                                oldPassController.text,
                                newPassController.text,
                                newPassConfirmController.text);
                            if (status) {
                              //dialogForgetPass2(context, forgetOptionsVM.id, forgetOptionsVM.optionsList);
                              showInSnackBar(
                                  context, operationDone, _scaffoldKey);
                              Future.delayed(
                                  const Duration(seconds: 2),
                                  () => {
                                        Navigator.pop(context),
                                      });
                            } else {
                              showInSnackBar(
                                  context, operationFail, _scaffoldKey);
                            }
                          } else {
                            showInSnackBar(
                                context, operationFail, _scaffoldKey);
                          }
                        },
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          btnCancel,
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
