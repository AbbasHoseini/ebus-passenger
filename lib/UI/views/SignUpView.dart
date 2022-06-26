import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/core/viewmodels/SignUpViewmodel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:pinput/pinput.dart';


class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignUpViewmodel signUpViewmodel =
        Provider.of<SignUpViewmodel>(context, listen: false);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

  
    return WillPopScope(
      onWillPop: () {
        return signUpViewmodel.onWillPop(context);
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: myHeight * 0.3,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Hero(
                    tag: 'ebusLogo',
                    child: Image(
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.contain,
                      color: colorPrimary,
                      image: AssetImage('images/icon.png'),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, bottom: 0, top: 40),
                  // margin: EdgeInsets.only(top: myHeight * 0.2),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Consumer<SignUpViewmodel>(
                        builder: (context, email, child) {
                          return email.getStep == 1
                              ? TextField(
                                  key: Key('phoneResend'),
                                  controller: signUpViewmodel.phoneController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: fontSizeTitle - 1,
                                      color: colorTextPrimary),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      filled: true,
                                      icon: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: colorPrimary.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.phone,
                                          color: colorPrimary,
                                          size: 22.0,
                                        ),
                                      ),
                                      labelText: "شماره تلفن",
                                      // hintText: "شماره تلفن",
                                      labelStyle: TextStyle(
                                          fontSize: fontSizeTitle,
                                          color: colorTextSub2,
                                          fontWeight: FontWeight.bold),
                                      errorText: email.emailErrorText),
                                )
                              : Container();
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Consumer<SignUpViewmodel>(
                        builder: (_, code, __) => code.getStep == 2
                            ? Column(
                                children: [
                                  Text(
                                    code.smsRecieved
                                        ? 'کد دریافت شد'
                                        : 'کد 6 رقمی ارسال شده را وارد کنید',
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: fontSizeTitle,
                                        fontWeight: FontWeight.bold,
                                        color: code.smsRecieved
                                            ? colorCorrect
                                            : colorTextSub2),
                                  ),
                                  const SizedBox(height: 8),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      key: Key('verifyCodeInputSignUp'),
                                      length: 6,
                                      focusNode: code.codeFocusNode,
                                      onCompleted: (String pin) async {
                                        switch (code.getStep) {
                                          case 1:
                                            signUpViewmodel.signUpResendVerify(
                                                code.phoneController.text,
                                                context,
                                                key!);
                                            break;
                                          case 2:
                                            bool go = await signUpViewmodel
                                                .signUpVerify(
                                                    code.phoneController.text,
                                                    code.codeController.text,
                                                    context,
                                                    key!);
                                            if (go) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/MainView',
                                                  (Route<dynamic> route) =>
                                                      false);
                                            } else {
                                              print("verify code fail");
                                            }
                                            break;
                                          case 3:
                                            bool isValidClick =
                                                signUpViewmodel.signupOnClick(
                                                    code.passwordController
                                                        .text,
                                                    code.confirmPasswordController
                                                        .text,
                                                    code.nationalCodeController
                                                        .text);
                                            print(
                                                "$isValidClick + isValidClick");
                                            if (!isValidClick) {
                                              showInfoFlushbar(
                                                  context,
                                                  "",
                                                  "اطلاعات وارد شده کامل نیست!",
                                                  false,
                                                  durationSec: 3);
                                            } else {
                                              bool response =
                                                  await signUpViewmodel.signup(
                                                      code.passwordController
                                                          .text,
                                                      code.confirmPasswordController
                                                          .text,
                                                      code.phoneController.text,
                                                      code.nationalCodeController
                                                          .text,
                                                      context,
                                                      _scaffoldKey);
                                              print(
                                                  "$response ${signUpViewmodel.getStep}");
                                            }
                                            break;

                                          default:
                                        }
                                      },
                                      showCursor: true,
                                      controller: code.codeController,
                                      // submittedPinTheme: submittedPinTheme,
                                      submittedPinTheme: code.defaultPinTheme(myWidth),
                                      // code.pinPutDecorationSubmitted,
                                      //pintheme
                                      focusedPinTheme: code.focusedPinTheme(myWidth),

                                      // fieldsAlignment: MainAxisAlignment.center,
                                      // eachFieldMargin: EdgeInsets.all(2),

                                      // eachFieldWidth: 30.0,

                                      followingPinTheme: code.followingPinTheme(myWidth),
                                          // code.pinPutDecorationFollowing,
                                    ),

                                    // child: Pinut(
                                    //   key: const Key('verifyCodeInputSignUp'),
                                    //   fieldsCount: 6,
                                    //   focusNode: code.codeFocusNode,
                                    //   onSubmit: (String pin) async {
                                    //     switch (code.getStep) {
                                    //       case 1:
                                    //         signUpViewmodel.signUpResendVerify(
                                    //             code.phoneController.text,
                                    //             context,
                                    //             key!);
                                    //         break;
                                    //       case 2:
                                    //         bool go = await signUpViewmodel
                                    //             .signUpVerify(
                                    //                 code.phoneController.text,
                                    //                 code.codeController.text,
                                    //                 context,
                                    //                 key!);
                                    //         if (go) {
                                    //           Navigator.pushNamedAndRemoveUntil(
                                    //               context,
                                    //               '/MainView',
                                    //               (Route<dynamic> route) =>
                                    //                   false);
                                    //         } else {
                                    //           print("verify code fail");
                                    //         }
                                    //         break;
                                    //       case 3:
                                    //         bool isValidClick =
                                    //             signUpViewmodel.signupOnClick(
                                    //                 code.passwordController
                                    //                     .text,
                                    //                 code.confirmPasswordController
                                    //                     .text,
                                    //                 code.nationalCodeController
                                    //                     .text);
                                    //         print(
                                    //             "$isValidClick + isValidClick");
                                    //         if (!isValidClick) {
                                    //           showInfoFlushbar(
                                    //               context,
                                    //               "",
                                    //               "اطلاعات وارد شده کامل نیست!",
                                    //               false,
                                    //               durationSec: 3);
                                    //         } else {
                                    //           bool response =
                                    //               await signUpViewmodel.signup(
                                    //                   code.passwordController
                                    //                       .text,
                                    //                   code.confirmPasswordController
                                    //                       .text,
                                    //                   code.phoneController.text,
                                    //                   code.nationalCodeController
                                    //                       .text,
                                    //                   context,
                                    //                   _scaffoldKey);
                                    //           print(
                                    //               "$response ${signUpViewmodel.getStep}");
                                    //         }
                                    //         break;

                                    //       default:
                                    //     }
                                    //   },
                                    //   withCursor: true,
                                    //   controller: code.codeController,
                                    //   submittedFieldDecoration:
                                    //       code.pinPutDecorationSubmitted,
                                    //   fieldsAlignment: MainAxisAlignment.center,
                                    //   eachFieldMargin: EdgeInsets.all(2),
                                    //   // eachFieldWidth: 30.0,
                                    //   eachFieldConstraints: BoxConstraints(
                                    //       maxWidth: (myWidth - 22 - 64) / 7),
                                    //   eachFieldHeight: (myWidth - 22 - 64) / 7,
                                    //   selectedFieldDecoration:
                                    //       code.pinPutDecorationSelected,
                                    //   followingFieldDecoration:
                                    //       code.pinPutDecorationFollowing,
                                    // ),
                                  
                                  ),                                
                                  
                                  // TextField(
                                  //     key: Key('code'),
                                  //     controller: signUpViewmodel.codeController,
                                  //     keyboardType: TextInputType.number,
                                  //     style: TextStyle(
                                  //         fontSize: fontSizeTitle - 1,
                                  //         color: colorTextPrimary),
                                  //     decoration: InputDecoration(
                                  //         fillColor: Colors.white,
                                  //         focusColor: Colors.white,
                                  //         contentPadding: EdgeInsets.symmetric(
                                  //             horizontal: 8, vertical: 4),
                                  //         border: OutlineInputBorder(
                                  //             borderSide: BorderSide.none,
                                  //             borderRadius:
                                  //                 BorderRadius.circular(40)),
                                  //         filled: true,
                                  //         icon: Container(
                                  //           padding: EdgeInsets.all(8),
                                  //           decoration: BoxDecoration(
                                  //             color: colorPrimary.withOpacity(0.2),
                                  //             borderRadius: BorderRadius.circular(10),
                                  //           ),
                                  //           child: Icon(
                                  //             Icons.phone,
                                  //             color: colorPrimary,
                                  //             size: 22.0,
                                  //           ),
                                  //         ),
                                  //         labelText: "کد تأیید",
                                  //         // hintText: "شماره تلفن",
                                  //         labelStyle: TextStyle(
                                  //             fontSize: fontSizeTitle,
                                  //             color: colorTextSub2,
                                  //             fontWeight: FontWeight.bold),
                                  //         errorText: code.codeErrorText),
                                  //   ),
                                ],
                              )
                            : Container(),
                      ),
                      Consumer<SignUpViewmodel>(
                        builder: (_, signup, __) => signup.getStep == 3
                            ? TextField(
                                key: const Key('phoneSignUp'),
                                controller: signUpViewmodel.phoneController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontSize: fontSizeTitle - 1,
                                    color: colorTextPrimary),
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    filled: true,
                                    icon: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: colorPrimary.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.phone,
                                        color: colorPrimary,
                                        size: 22.0,
                                      ),
                                    ),
                                    labelText: "شماره تلفن",
                                    // hintText: "شماره تلفن",
                                    labelStyle: const TextStyle(
                                        fontSize: fontSizeTitle,
                                        color: colorTextSub2,
                                        fontWeight: FontWeight.bold),
                                    errorText: signup.mailErrorText == ''? null: signup.mailErrorText),
                              )
                            : Container(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Consumer<SignUpViewmodel>(
                        builder: (_, signup, __) => InkWell(
                          key: Key('signup'),
                          onTap: () async {
                            print("step ${signup.getStep}");
                            switch (signup.getStep) {
                              case 1:
                                signUpViewmodel.signUpResendVerify(
                                    signup.phoneController.text, context, key!);
                                break;
                              case 2:
                                bool go = await signUpViewmodel.signUpVerify(
                                    signup.phoneController.text,
                                    signup.codeController.text,
                                    context,
                                    key!);
                                if (go) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/MainView',
                                      (Route<dynamic> route) => false);
                                } else {
                                  print("verify code fail");
                                }
                                break;
                              case 3:
                                bool isValidClick =
                                    signUpViewmodel.signupOnClick(
                                        signup.passwordController.text,
                                        signup.confirmPasswordController.text,
                                        signup.nationalCodeController.text);
                                print("$isValidClick + isValidClick");
                                if (!isValidClick) {
                                  showInfoFlushbar(context, "",
                                      "اطلاعات وارد شده کامل نیست!", false,
                                      durationSec: 3);
                                } else {
                                  bool response = await signUpViewmodel.signup(
                                      signup.passwordController.text,
                                      signup.confirmPasswordController.text,
                                      signup.phoneController.text,
                                      signup.nationalCodeController.text,
                                      context,
                                      _scaffoldKey);
                                  print("$response ${signUpViewmodel.getStep}");
                                }
                                break;

                              default:
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    signup.getStep == 1
                                        ? 'دریافت کد'
                                        : 'ثبت نام',
                                    style: TextStyle(
                                        color: colorTextWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeTitle)),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            margin: EdgeInsets.only(top: 0, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colorPrimary,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  width: myWidth,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Consumer<SignUpViewmodel>(
                    builder: (_, btn, __) => InkWell(
                      onTap: () {
                        switch (btn.getStep) {
                          case 2:
                            btn.setStep(3);
                            print(btn.getStep);
                            break;
                          default:
                            Navigator.pushNamedAndRemoveUntil(context,
                                '/LoginView', (Route<dynamic> route) => false);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            btn.getStep == 2
                                ? 'بررسی شماره تلفن'
                                : 'قبلا ثبت‌نام کرده‌اید؟',
                            style: TextStyle(
                              color: colorTextSub2,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeSubTitle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            btn.getStep == 2 ? '' : 'وارد شوید.',
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
