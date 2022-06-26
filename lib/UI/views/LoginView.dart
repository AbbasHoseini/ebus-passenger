import 'package:ebus/core/viewmodels/LoginViewModel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:ebus/helpers/Constants.dart';

import '../../helpers/Constants.dart';
import '../../helpers/Constants.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DateTime? currentBackPressTime;
  LoginViewModel? loginViewModel;
  @override
  void initState() {
    loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        print("stepp ${loginViewModel!.step}");
        if (loginViewModel!.step == 1) {
          loginViewModel!.clear();
        } else if (loginViewModel!.step == 0) {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
            currentBackPressTime = now;
            //Fluttertoast.showToast(msg: exit_warning);
            return false;
          }
          return false;
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                width: myWidth,
                height: myHeight,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: myHeight * 0.3,
                      width: myWidth,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: const Hero(
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
                    Consumer<LoginViewModel>(
                      builder: (_, loginConsumer, __) => Container(
                        padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            bottom: 70,
                            top: loginConsumer.step == 1 ? 10 : 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Visibility(
                              visible: loginViewModel!.step == 1 ? false : true,
                              child:
                                  //  AnimationHandler().translateFromRight(
                                  Column(
                                children: <Widget>[
                                  TextField(
                                    key: const Key("phone"),
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.phone,
                                    // focusNode: myFocusNodeEmailLogin,
                                    controller: loginViewModel!.phoneController,
                                    style: const TextStyle(
                                        fontSize: 20.0, color: Colors.black),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: colorPrimary.withOpacity(0.2),
                                        ),
                                        child: const Icon(
                                          Icons.phone,
                                          size: 22.0,
                                          color: colorPrimary,
                                        ),
                                      ),
                                      labelText:
                                          'شماره موبایل خود را وارد کنید',
                                      labelStyle: const TextStyle(
                                        fontSize: fontSizeTitle,
                                        color: colorTextSub2,
                                      ),
                                    ),
                                    onSubmitted: (val) async {
                                      if (loginViewModel!
                                              .loginValidateFields(context) &&
                                          loginConsumer.step == 0) {
                                        loginViewModel!.setStep(1);
                                        await loginViewModel!.sendCode(context);
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          // if (loginViewModel.pr.isShowing())
                                          //   loginViewModel.pr.hide();
                                          Navigator.pushNamed(
                                            context,
                                            '/OldLoginView',
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: const Text(
                                            'ورود با نام کاربری و رمز عبور',
                                            style: TextStyle(
                                                color: colorFlatButton,
                                                fontSize: fontSizeMedTitle),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Curves.easeOutCubic,
                              // 0,
                              // duration: 300),
                            ),
                            Visibility(
                              visible: loginConsumer.step == 1 ? true : false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    loginConsumer.smsRecieved
                                        ? 'کد دریافت شد'
                                        : 'کد 6 رقمی ارسال شده را وارد کنید',
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: fontSizeTitle,
                                        fontWeight: FontWeight.bold,
                                        color: loginConsumer.smsRecieved
                                            ? colorCorrect
                                            : colorTextSub2),
                                  ),
                                  const SizedBox(height: 8),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      key: const Key('verifyCodeInput'),
                                      length: 6,
                                      focusNode: loginViewModel!.codeFocusNode,
                                      onCompleted: (String pin) {
                                        if (loginViewModel!
                                                .loginValidateFields(context) &&
                                            loginConsumer.step == 1) {
                                          loginConsumer.signIn(context);
                                          // if (loginViewModel.pr.isShowing())
                                          //   loginViewModel.pr.hide();
                                        }
                                      },

                                      showCursor: true,
                                      controller:
                                          loginViewModel!.verifyCodeController,
                                      submittedPinTheme: loginViewModel!
                                      .submittedPinTheme(myWidth),
                                          // .pinPutDecorationSubmitted,
                                      // fieldsAlignment: MainAxisAlignment.center,
                                      defaultPinTheme: loginViewModel!.defaultPinTheme(myWidth),
                                      // eachFieldWidth: 30.0,
                                      // eachFieldConstraints: BoxConstraints(
                                      //     maxWidth: (myWidth - 22 - 64) / 7),
                                      // eachFieldHeight: (myWidth - 22 - 64) / 7,
                                      focusedPinTheme: loginViewModel!
                                      .focusedPinTheme(myWidth),
                                          // .pinPutDecorationSelected,
                                          followingPinTheme:
                                       loginViewModel!
                                          .followingPinTheme(myWidth),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    child: MaterialButton(
                                        minWidth: myWidth - 50,
                                        color: loginConsumer.loading
                                            ? colorSeatDisabled
                                            : colorPrimary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 10),
                                        child: loginConsumer.loading
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.all(8.0),
                                                child: SpinKitThreeBounce(
                                                  size: 25,
                                                  color: colorPrimary,
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'ورود',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            fontSizeTitle + 2,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                        elevation: 1,
                                        onPressed: () async {
                                          if (loginViewModel!
                                                  .loginValidateFields(
                                                      context) &&
                                              loginConsumer.step == 1) {
                                            loginConsumer.signIn(context);
                                            // if (loginViewModel.pr.isShowing())
                                            //   loginViewModel.pr.hide();
                                          }
                                          // if (loginViewModel.pr.isShowing())
                                          //   loginViewModel.pr.hide();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: loginConsumer.step == 0 ? true : false,
                              child: const SizedBox(
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // AnimationHandler().translateFromRight(
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      MaterialButton(
                                          key: const Key('loginButton'),
                                          minWidth: myWidth - 50,
                                          color:
                                              (loginConsumer.isCountingDown ||
                                                      loginConsumer.loading)
                                                  ? colorSeatDisabled
                                                  : colorPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: loginConsumer.loading
                                              ? const Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: SpinKitThreeBounce(
                                                    color: colorPrimary,
                                                    size: 20,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      loginConsumer.step == 1
                                                          ? loginConsumer
                                                                  .isCountingDown
                                                              ? ' '
                                                              : 'ارسال مجدد کد'
                                                          : 'ارسال کد تأیید',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              fontSizeTitle + 2,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    loginConsumer.step == 1
                                                        ? Container()
                                                        : const SizedBox(width: 8),
                                                    loginConsumer.step == 1
                                                        ? Container()
                                                        : const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                  ],
                                                ),
                                          elevation: 1,
                                          onPressed: () async {
                                            if (!loginConsumer.isCountingDown) {
                                              if (loginViewModel!
                                                      .loginValidateFields(
                                                          context) ||
                                                  loginConsumer.step == 1) {
                                                await loginViewModel!
                                                    .sendCode(context);
                                              }
                                            }
                                            // if (loginViewModel.pr.isShowing())
                                            //   loginViewModel.pr.hide();
                                          }),
                                      loginConsumer.isCountingDown
                                          ? Positioned.fill(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: CountdownTimer(
                                                  endWidget: const Center(
                                                    child: Text(
                                                      'ارسال مجدد کد',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              fontSizeTitle + 2,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  endTime:
                                                      loginConsumer.endTime,
                                                  onEnd: loginConsumer
                                                      .onCountdownEnd,
                                                  widgetBuilder: (_,
                                                      CurrentRemainingTime?
                                                          time) {
                                                    if (time == null) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          if (!loginConsumer
                                                              .isCountingDown) {
                                                            if (loginViewModel!
                                                                    .loginValidateFields(
                                                                        context) ||
                                                                loginConsumer
                                                                        .step ==
                                                                    1) {
                                                              await loginViewModel!
                                                                  .sendCode(
                                                                      context);
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const[
                                                            Text(
                                                              'ارسال مجدد کد',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      fontSizeTitle +
                                                                          2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ],
                                                        )),
                                                      );
                                                    }
                                                    return Text(
                                                        '${time.sec} ثانیه تا ارسال مجدد کد',
                                                        style: const TextStyle(
                                                            color:
                                                                colorTextSub2,
                                                            fontSize:
                                                                fontSizeTitle +
                                                                    2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal));
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                // Curves.easeOutCubic,
                                // 0.5,
                                // duration: 300),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          const Text(
                            'عضو نیستید؟',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorTextSub2,
                                fontSize: fontSizeMedTitle,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            key: const Key('signUpClick'),
                            onTap: () {
                              Navigator.pushNamed(context, '/SignUpView');
                            },
                            child: const Text(
                              signUpSTR,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: colorPrimary,
                                  fontSize: fontSizeTitle,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
