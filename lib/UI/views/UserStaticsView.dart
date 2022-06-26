import 'package:ebus/core/viewmodels/UserStaticsViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserStaticsView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    UserStaticsViewModel userStaticViewModel =
        Provider.of<UserStaticsViewModel>(context, listen: false);
    userStaticViewModel.getUserStaticInfo(context);
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(userStaticsTitle),
          backgroundColor: colorPrimary,
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Consumer<UserStaticsViewModel>(
              builder: (_, userstaticVM, __) => Container(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  child: userstaticVM.loading == true
                      ? Center(
                    key: Key('loading'),
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: myHeight * 1.2,
                          width: myWidth * 0.8,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Container(
                                            width: myWidth / 3,
                                            height: myWidth / 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    colorGradient1,
                                                    colorGradient2
                                                        .withOpacity(0.8)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Consumer<UserStaticsViewModel>(
                                                  builder:
                                                      (_, userstaticVM, __) =>
                                                          Text(
                                                    userstaticVM.travelCount,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: colorTextWhite,
                                                        fontSize:
                                                            textFontSizeTitle,
                                                        fontFamily: 'Sans'),
                                                  ),
                                                ),
                                                Text(
                                                  "تعداد سفر ها",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colorTextWhite,
                                                      fontSize: textFontSizeSub,
                                                      fontFamily: 'Sans'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Container(
                                            width: myWidth / 3,
                                            height: myWidth / 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    colorGradient1,
                                                    colorGradient2
                                                        .withOpacity(0.8)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Consumer<UserStaticsViewModel>(
                                                  builder:
                                                      (_, userstaticVM, __) =>
                                                          Text(
                                                    userstaticVM.travelPrice,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: colorTextWhite,
                                                        fontSize:
                                                            textFontSizeTitle,
                                                        fontFamily: 'Sans'),
                                                  ),
                                                ),
                                                Text(
                                                  "مجموع پرداختی ها",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colorTextWhite,
                                                      fontSize: textFontSizeSub,
                                                      fontFamily: 'Sans'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Container(
                                            width: myWidth / 3,
                                            height: myWidth / 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    colorGradient1,
                                                    colorGradient2
                                                        .withOpacity(0.8)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Consumer<UserStaticsViewModel>(
                                                  builder:
                                                      (_, userstaticVM, __) =>
                                                          Text(
                                                    userstaticVM.travelTime,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: colorTextWhite,
                                                        fontSize:
                                                            textFontSizeTitle,
                                                        fontFamily: 'Sans'),
                                                  ),
                                                ),
                                                Text(
                                                  "مجموع مسافت طی شده",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colorTextWhite,
                                                      fontSize: textFontSizeSub,
                                                      fontFamily: 'Sans'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Container(
                                            width: myWidth / 3,
                                            height: myWidth / 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    colorGradient1,
                                                    colorGradient2
                                                        .withOpacity(0.8)
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Consumer<UserStaticsViewModel>(
                                                  builder:
                                                      (_, userstaticVM, __) =>
                                                          Text(
                                                    userstaticVM.travelTime,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: colorTextWhite,
                                                        fontSize:
                                                            textFontSizeTitle,
                                                        fontFamily: 'Sans'),
                                                  ),
                                                ),
                                                Text(
                                                  "مجموع زمان سفرها",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colorTextWhite,
                                                      fontSize: textFontSizeSub,
                                                      fontFamily: 'Sans'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  children: <Widget>[
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Container(
                                        width: myWidth / 3,
                                        height: myWidth / 3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                colorGradient1,
                                                colorGradient2
                                                    .withOpacity(0.8)
                                              ]),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Consumer<UserStaticsViewModel>(
                                              builder: (_, userstaticVM, __) =>
                                                  Text(
                                                userstaticVM.travelDiscount,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: colorTextWhite,
                                                    fontSize: textFontSizeTitle,
                                                    fontFamily: 'Sans'),
                                              ),
                                            ),
                                            Text(
                                              "مجموع تخفیف ها",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: colorTextWhite,
                                                  fontSize: textFontSizeSub,
                                                  fontFamily: 'Sans'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )))),
        ));
  }
}
