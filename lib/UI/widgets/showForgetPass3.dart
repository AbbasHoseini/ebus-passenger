import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/UI/widgets/showForgetPass4.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/core/viewmodels/ForgetVerifyCodeViewModel.dart';
import 'package:ebus/helpers/constants.dart';



Future<Future> dialogForgetPass3(BuildContext context, int id)  async {

  final FocusNode myFocusNodeUsernameInput = FocusNode();
  TextEditingController verifyCodeController = TextEditingController();

  final forgetVerifyCodeVM = Provider.of<ForgetVerifyCodeViewModel>(context);
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
                content: TextField(
                  key: Key("verifyCode"),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: myFocusNodeUsernameInput,
                  controller: verifyCodeController,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                    suffixIcon: Icon(
                      Icons.mail,
                      size: 22.0,
                      color: Colors.amber,
                    ),
                    hintText: forget3TextFieldSTR,
                    hintStyle: TextStyle(
                        fontSize: 13.0, color: Colors.black),
                  ),
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
                      print(verifyCodeController.text);
                      bool status=await forgetVerifyCodeVM.verifyForgetSentForgetCode(id, verifyCodeController.text,"", "", "");
                      if(status){
                        dialogForgetPass4(context, id);
                      }else{showInSnackBar(context, signInErrorSTR, _scaffoldKey);}
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
