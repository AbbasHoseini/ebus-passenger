import 'package:ebus/core/viewmodels/OldLoginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/helpers/Constants.dart';

class OldLoginView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final oldLoginViewModel = Provider.of<OldLoginViewModel>(context);
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
            //padding: EdgeInsets.all(10),
            width: myWidth,
            height: myHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: Container(
                    height: myHeight * 0.3,
                    width: myWidth,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Image(
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                      color: colorPrimary,
                      image: AssetImage('images/icon.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 5,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 30,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: SingleChildScrollView(
                    child: Container(
                      height: myHeight * 0.7,
                      width: myWidth,
                      padding: EdgeInsets.only(
                          left: 30, right: 30, bottom: 70, top: 40),
                      margin: EdgeInsets.only(top: myHeight * 0.3, bottom: 30),
                      decoration: BoxDecoration(
                          color: colorPrimaryGrey,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              key: Key("username"),
                              //textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              // focusNode: myFocusNodeEmailLogin,
                              controller: oldLoginViewModel.usernameController,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40)),
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: colorPrimary,
                                ),
                                labelText: signInUserSTR,
                                labelStyle: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              key: Key("pass"),
                              //textAlign: TextAlign.center,
                              // focusNode: myFocusNodePasswordLogin,
                              controller: oldLoginViewModel.passwordController,
                              obscureText: true,
                              style:
                                  TextStyle(fontSize: 20.0, color: colorAccent),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40)),
                                filled: true,
                                labelText: signInPassSTR,
                                labelStyle: TextStyle(
                                    fontSize: 13.0, color: Colors.black),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: colorPrimary,
                                  size: 22.0,
                                ),
                              ),
                              onSubmitted: (val) async {
                                bool go = false;
                                if (oldLoginViewModel
                                    .loginValidateFields(context)) {
                                  go = await oldLoginViewModel.signIn(context);
                                  if (go && oldLoginViewModel.token != null) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/MainView',
                                        (Route<dynamic> route) => false);
                                  }
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pushNamed(context, '/ForgetPassView');
                              //todo dialogforgetpass1
                              //dialogForgetPass1(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 8),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'رمز عبور خود را فراموش کرده‌اید؟',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                            ),
                          ),
                          MaterialButton(
                              elevation: 0.5,
                              minWidth: myWidth - 40,
                              color: colorPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'ورود',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              //
                              onPressed: () async {
                                bool go = false;
                                if (oldLoginViewModel
                                    .loginValidateFields(context)) {
                                  go = await oldLoginViewModel.signIn(context);
                                  if (go && oldLoginViewModel.token != null) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/MainView',
                                        (Route<dynamic> route) => false);
                                  }
                                }
                              }),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: myWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(
                          notUserSTR,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/SignUpView');
                          },
                          child: Text(
                            signUpSTR,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: colorPrimary,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
