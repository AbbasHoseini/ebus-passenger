import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/UI/widgets/showForgetPass2.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/core/viewmodels/ForgetSelectedOptionViewModel.dart';
import 'package:ebus/helpers/constants.dart';
import 'package:ebus/core/viewmodels/ForgetListOptionViewModel.dart';



Future<Future> dialogForgetPass1(BuildContext context)  async {

  final FocusNode myFocusNodeUsernameInput = FocusNode();
  TextEditingController usernameController = TextEditingController();

  final forgetOptionsVM = Provider.of<ForgetListOptionViewModel>(context);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Future.value()
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
                  key: Key("username"),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: myFocusNodeUsernameInput,
                  controller: usernameController,
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
                    hintText: signInUserSTR,
                    hintStyle: TextStyle(
                        fontSize: 13.0, color: Colors.black),
                  ),
                ),
                actions: <Widget>[
                  MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (context) => ForgetSelectedOptionViewModel()),
                    ],
                    child: MaterialButton(
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
                        print(usernameController.text);
                        await forgetOptionsVM.getForgetListOptions(usernameController.text, "", "", "");
                        if(forgetOptionsVM.status!){
                          dialogForgetPass2(context, forgetOptionsVM.id!, forgetOptionsVM.optionsList);
                          //ShowInSnackBar(context, signInSuccessSTR ,_scaffoldKey);
                        }else{showInSnackBar(context, signInErrorSTR, _scaffoldKey);}
                      },
                    ),
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
