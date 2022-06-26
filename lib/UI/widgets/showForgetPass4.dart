import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/core/viewmodels/ForgetNewPassViewModel.dart';
import 'package:ebus/helpers/constants.dart';



Future<Future> dialogForgetPass4(BuildContext context, int id)  async {

  final FocusNode focusNodePassInput = FocusNode();
  final FocusNode focusNodeConfirmPassInput = FocusNode();
  TextEditingController firstPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final forgetNewPassViewModel = Provider.of<ForgetNewPassViewModel>(context);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  return showDialog(context: context, builder: (context){
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
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                content: Column(
                  children: <Widget>[
                    TextField(
                      key: Key("passwordCode"),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: focusNodePassInput,
                      controller: firstPassController,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                        suffixIcon: Icon(
                          Icons.lock,
                          size: 22.0,
                          color: Colors.amber,
                        ),
                        hintText: forget4PassCodeTR,
                        hintStyle: TextStyle(
                            fontSize: 13.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      key: Key("confirmCode"),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: focusNodeConfirmPassInput,
                      controller: confirmPassController,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                        suffixIcon: Icon(
                          Icons.lock,
                          size: 22.0,
                          color: Colors.amber,
                        ),
                        hintText: forget4PassConfirmSTR,
                        hintStyle: TextStyle(
                            fontSize: 13.0, color: Colors.black),
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
                      dialogBtnNextSTR,
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    onPressed: ()async {
                      print(firstPassController.text);
                      if(firstPassController.text==confirmPassController.text){
                        bool status=await forgetNewPassViewModel.confirmNewPass(id, firstPassController.text,confirmPassController.text, "", "");
                        if(status){
                          //dialogForgetPass2(context, forgetOptionsVM.id, forgetOptionsVM.optionsList);
                          showInSnackBar(context, forget4PassSuccessSTR ,_scaffoldKey);
                          Future.delayed(const Duration(seconds: 2), () => {
                            Navigator.pop(context),
                              Navigator.pop(context),
                          Navigator.pop(context),
                          Navigator.pop(context),});
                        }else{showInSnackBar(context, forget4PassReqErrorSTR, _scaffoldKey);}
                      }else{showInSnackBar(context, forget4PassErrorSTR, _scaffoldKey);
                      }
                    },
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      dialogBtnPrevSTR,
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
