import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/core/models/Bus.dart';
import 'package:ebus/core/models/ResultArgs.dart';
import 'package:ebus/core/models/TravelDetailArgsNew.dart';
import 'package:ebus/core/viewmodels/ResultViewModel.dart';
import 'package:ebus/core/viewmodels/TravelDetailVieModelNew.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/CustomClipper.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ResultView extends StatefulWidget {
  ResultArgs? resultArgs;
  String moonType = 'بعد ظهر';
  String moonTypeReturn = 'بعد ظهر';
  ResultView({
    this.resultArgs,
  });

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ResultViewModel? resultViewModel;

  @override
  void initState() {
    resultViewModel = Provider.of<ResultViewModel>(context, listen: false);
    if (widget.resultArgs!.isRoundTrip!) {
      //widget.resultArgs.comingDate =
      //  resultViewModel.setGregorianDate(widget.resultArgs.comingDate);
    }
    print("first ${widget.resultArgs!.goingDate}");
    //widget.resultArgs.goingDate =
    //resultViewModel.setGregorianDate(widget.resultArgs.goingDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.resultArgs.comingDate = ${widget.resultArgs!.comingDate}');

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    // if (resultViewModel!.resultArgs == null) {
    resultViewModel!.setResultArgs(widget.resultArgs!);
    // }
    print('resultArgs.busList.length = ${widget.resultArgs!.busList!.length}');
    TravelDetailViewModelNew travelDetailViewModelNew =
        Provider.of<TravelDetailViewModelNew>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        resultViewModel!.clear();
        return true;
      },
      child: Consumer<ResultViewModel>(
        builder: (_, resultConsumer, __) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const AutoSizeText(
              resultTitle,
              style: TextStyle(
                  color: colorTextTitle,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeTitle + 5),
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: colorTextTitle),
            actions: const <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Icons.filter_list,
              //     color: colorTextTitle,
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(
              //       context,
              //       '/FilterView',
              //       arguments: widget.resultArgs,
              //     );
              //   },
              // ),
            ],
          ),
          backgroundColor: Colors.white,
          body: resultConsumer.isLoading
              ? const Center(
                  child: SpinKitChasingDots(
                    size: 25,
                    color: colorPrimary,
                  ),
                )
              : Directionality(
                  textDirection: TextDirection.ltr,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Align(
                          heightFactor: 1,
                          child: Hero(
                            tag: 'busTag',
                            child: Image.asset(
                              'images/bus_schema.png',
                              height: 100,
                              width: myWidth - 32,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              // color: colorPrimaryGrey,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40))),
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5,
                                                  spreadRadius: 1)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.arrow_back_ios,
                                              color: colorTextWhite,
                                              size: 15,
                                            ),
                                            SizedBox(width: 8),
                                            AutoSizeText(
                                              resultViewModel!.getNextDayString(
                                                  widget
                                                      .resultArgs!.goingDate!),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: colorTextWhite,
                                                fontSize: fontSizeTitle,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        bool go;
                                        go = await resultViewModel!.getNextPrevDay(
                                            widget.resultArgs!,
                                            true, //widget.resultArgs. busList[0].departureDateTime
                                            "${widget.resultArgs!.goingDate}",
                                            context);
                                        if (go) {
                                          ResultArgs resultArgs = ResultArgs(
                                              resultViewModel!.busList,
                                              widget.resultArgs!.sourceName,
                                              widget.resultArgs!.sourceId,
                                              widget
                                                  .resultArgs!.destinationName,
                                              widget.resultArgs!.destinationId,
                                              widget.resultArgs!.sourceCode,
                                              widget
                                                  .resultArgs!.destinationCode,
                                              widget.resultArgs!.isRoundTrip,
                                              resultViewModel!.getGoingDate(
                                                  widget.resultArgs!.goingDate!,
                                                  true),
                                              resultViewModel!.getComingDate(
                                                  widget
                                                      .resultArgs!.comingDate!,
                                                  true),
                                              busListReturn: <Bus>[]);
                                          //print("busList length ${resultArgs.busList.length}");
                                          //print("busListReturn length ${resultArgs.busListReturn.length}");
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/ResultView',
                                            arguments: resultArgs,
                                          );
                                        }
                                      }),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        resultViewModel!.getAppbarDate(
                                            widget.resultArgs!.goingDate!),
                                        style: const TextStyle(
                                            color: colorTextSub,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 3),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5,
                                                  spreadRadius: 1)
                                            ]),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Row(
                                          children: <Widget>[
                                            AutoSizeText(
                                              resultViewModel!
                                                  .getPreviousDayString(widget
                                                      .resultArgs!.goingDate!),
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: colorTextWhite,
                                                fontSize: fontSizeTitle,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: colorTextWhite,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //
                                      onTap: () async {
                                        bool go;
                                        go = await resultViewModel!.getNextPrevDay(
                                            widget.resultArgs!,
                                            false, //goingDate busList[0].departureDateTime
                                            "${widget.resultArgs!.goingDate}",
                                            context);
                                        if (go) {
                                          ResultArgs resultArgs = ResultArgs(
                                              resultViewModel!.busList,
                                              widget.resultArgs!.sourceName,
                                              widget.resultArgs!.sourceId,
                                              widget
                                                  .resultArgs!.destinationName,
                                              widget.resultArgs!.destinationId,
                                              widget.resultArgs!.sourceCode,
                                              widget
                                                  .resultArgs!.destinationCode,
                                              widget.resultArgs!.isRoundTrip,
                                              resultViewModel!.getGoingDate(
                                                  widget.resultArgs!.goingDate!,
                                                  false),
                                              resultViewModel!.getComingDate(
                                                  widget
                                                      .resultArgs!.comingDate!,
                                                  false),
                                              busListReturn: <Bus>[]);
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/ResultView',
                                            arguments: resultArgs,
                                          );
                                        }
                                      }),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Consumer<ResultViewModel>(
                                  builder: (_, returnConsumer, __) =>
                                      returnConsumer.goingTripSelected == true
                                          ?
                                          //  AnimationHandler()
                                          //     .translateFromRight(
                                          Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              blurRadius: 5,
                                                              spreadRadius: 1)
                                                        ]),
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4,
                                                        horizontal: 4),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16,
                                                            horizontal: 16),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: Row(
                                                            children: <Widget>[
                                                              /*Icon(Icons.location_city,
                                                          color: colorAccent),*/
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                child:
                                                                    // AnimationHandler().popUp(
                                                                    Column(
                                                                  children: <
                                                                      Widget>[
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .destinationName!,
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              colorTextSub,
                                                                          fontSize: fontSizeTitle +
                                                                              3,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const AutoSizeText(
                                                                      "14:52",
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextSub,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // Curves.easeInOut,
                                                                // 800,
                                                                // duration: 250),
                                                              ),
                                                              // AnimationHandler().popUp(
                                                              const Icon(
                                                                Icons
                                                                    .radio_button_unchecked,
                                                                color:
                                                                    colorPrimary,
                                                                size: 18,
                                                              ),
                                                              // Curves.easeOutCubic,
                                                              // 800,
                                                              // duration: 150),
                                                              SizedBox(
                                                                  width: 4),
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    // AnimationHandler().popUp(
                                                                    AutoSizeText(
                                                                      widget.resultArgs!.busList![resultConsumer.goingDateIndex].isMidWay ==
                                                                              true
                                                                          ? 'بین راهی'
                                                                          : 'مستقیم',
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          height:
                                                                              1.6,
                                                                          color:
                                                                              colorPrimary,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    // Curves.easeOutCubic,
                                                                    // 550,
                                                                    // duration: 150),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        // AnimationHandler().popUp(
                                                                        Icon(
                                                                          Icons
                                                                              .arrow_back_ios,
                                                                          color:
                                                                              Colors.grey,
                                                                          size:
                                                                              18,
                                                                        ),
                                                                        // Curves.easeOutCubic,
                                                                        // 700,
                                                                        // duration: 150),
                                                                        Expanded(
                                                                          child:
                                                                              // AnimationHandler().scaleFromRight(
                                                                              Container(
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                5,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(40)),
                                                                              gradient: LinearGradient(
                                                                                colors: [
                                                                                  // use your preferred colors
                                                                                  Colors.black38,
                                                                                  colorPrimary,
                                                                                ],
                                                                                // start at the top
                                                                                begin: Alignment.centerRight,
                                                                                // end at the bottom
                                                                                end: Alignment.centerLeft,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Curves.easeOutCubic,
                                                                          // 400,
                                                                          // duration: 300),
                                                                        ),
                                                                        // Icon(
                                                                        //   Icons.arrow_forward_ios,
                                                                        //   color: Colors.grey,
                                                                        //   size: 18,
                                                                        // )
                                                                      ],
                                                                    ),
                                                                    // AnimationHandler().popUp(
                                                                    AutoSizeText(
                                                                      "${widget.resultArgs!.busList![resultConsumer.goingDateIndex].durationMinute}" +
                                                                          " دقیقه",
                                                                      maxLines:
                                                                          1,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextSub),
                                                                    ),
                                                                    // Curves.easeOutCubic,
                                                                    // 550,
                                                                    // duration: 150),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 4),
                                                              // AnimationHandler().popUp(
                                                              const Icon(
                                                                  Icons
                                                                      .radio_button_checked,
                                                                  color: Colors
                                                                      .black38,
                                                                  size: 18),
                                                              // Curves
                                                              //     .easeOutCubic,
                                                              // 200,
                                                              // duration:
                                                              //     200),
                                                              // AnimationHandler().popUp(
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .sourceName!,
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextSub,
                                                                          fontSize: fontSizeTitle +
                                                                              3,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .busList![resultConsumer
                                                                              .goingDateIndex]
                                                                          .departureDateTime!
                                                                          .substring(
                                                                              11,
                                                                              16),
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextSub,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Curves.easeOutCubic,
                                                              // 200,
                                                              // duration: 200),
                                                              /*AnimationHandler().popUp(
                                                          Icon(
                                                              Icons.location_city,
                                                              color: colorAccent),
                                                          Curves.easeOutCubic,
                                                          200,
                                                          duration:s 200),*/
                                                            ],
                                                          ),
                                                        ),
                                                        //SizedBox(height: 20),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          Expanded(
                                                              child: Divider(
                                                            endIndent: 16,
                                                            thickness: 2,
                                                          )),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        16,
                                                                    vertical:
                                                                        8),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    colorPrimary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            child: Row(
                                                              children: const <
                                                                  Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                    width: 4),
                                                                AutoSizeText(
                                                                  "انتخاب بلیط‌ بازگشت",
                                                                  minFontSize:
                                                                      fontSizeTitle,
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextWhite),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            )
                                          // ,
                                          // Curves.easeInOutCubic,
                                          // 0,
                                          // duration: 250)
                                          : Container()),
                              (widget.resultArgs!.busList!.length == null ||
                                      widget.resultArgs!.busList!.length < 1)
                                  ? Center(
                                      child: AutoSizeText("نتیجه ای یافت نشد"),
                                    )
                                  : (resultConsumer.goingTripSelected == false)
                                      ? Consumer<ResultViewModel>(
                                          builder: (_, busItemConsumer, __) =>
                                              Expanded(
                                            child: ListView.builder(
                                                itemCount: widget.resultArgs!
                                                    .busList!.length,
                                                itemBuilder: (context, index) {
                                                  if (6 >=
                                                          int.parse(widget
                                                              .resultArgs!
                                                              .busList![index]
                                                              .departureDateTime!
                                                              .substring(
                                                                  11, 13)) &&
                                                      18 <=
                                                          int.parse(widget
                                                              .resultArgs!
                                                              .busList![index]
                                                              .departureDateTime!
                                                              .substring(
                                                                  11, 13))) {
                                                    widget.moonType = 'شب';
                                                  } else if (12 >
                                                          int.parse(widget
                                                              .resultArgs!
                                                              .busList![index]
                                                              .departureDateTime!
                                                              .substring(
                                                                  11, 13)) &&
                                                      6 <
                                                          int.parse(widget
                                                              .resultArgs!
                                                              .busList![index]
                                                              .departureDateTime!
                                                              .substring(
                                                                  11, 13))) {
                                                    widget.moonType = 'صبح';
                                                  }
                                                  widget
                                                          .resultArgs!
                                                          .busList![index]
                                                          .shamsiDate =
                                                      getShamsiDate(widget
                                                          .resultArgs!
                                                          .busList![index]
                                                          .departureDateTime!
                                                          .substring(0, 10));

                                                  return
                                                      // AnimationHandler()
                                                      //     .translateFromRight(
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      //color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16,
                                                            horizontal: 10),
                                                    width: myWidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          width: myWidth * 0.4 -
                                                              21,
                                                          height: 150,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 7,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          7),
                                                              topRight: Radius
                                                                  .circular(7),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius:
                                                                      10,
                                                                  spreadRadius:
                                                                      1,
                                                                  color: Colors
                                                                      .black12)
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    widget
                                                                        .resultArgs!
                                                                        .busList![
                                                                            index]
                                                                        .carTypeTitle!,
                                                                        textDirection: TextDirection.rtl,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .amber,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          fontSizeTitle,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  AutoSizeText(
                                                                    busItemConsumer
                                                                            .formatter
                                                                            .format(widget.resultArgs!.busList![index].basePrice)
                                                                            .toString() +
                                                                        ' ریال',
                                                                    maxLines: 1,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            textFontSizeTitle,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  AutoSizeText(
                                                                    'از ',
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTextSub),
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: <
                                                                    Widget>[
                                                                  AutoSizeText(
                                                                    "${(widget.resultArgs!.busList![index].emptySeatCount)}" +
                                                                        " نفر",
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTextTitle,
                                                                        fontSize:
                                                                            fontSizeTitle,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                  ),
                                                                  AutoSizeText(
                                                                    'ظرفیت  ',
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTextSub),
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Consumer<
                                                                          TravelDetailViewModelNew>(
                                                                      builder: (_,
                                                                          travelVM,
                                                                          __) {
                                                                    return MaterialButton(
                                                                      elevation:
                                                                          5,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      color:
                                                                          colorPrimary,
                                                                      disabledColor:
                                                                          colorPrimary,
                                                                      onPressed:
                                                                          () async {
                                                                        if (await resultViewModel!
                                                                            .isRegisterCompleted()) {
                                                                          if (resultViewModel!
                                                                              .resultArgs
                                                                              .isRoundTrip!) {
                                                                            print("index is  = $index");
                                                                            busItemConsumer.goingDateSelected(index);
                                                                          } else {
                                                                            TravelDetailArgsNew travelDetailArgsNew = TravelDetailArgsNew(
                                                                                sourceId: widget.resultArgs!.sourceId,
                                                                                destinationId: widget.resultArgs!.destinationId,
                                                                                travelId: widget.resultArgs!.busList![index].travelId,
                                                                                basePrice: widget.resultArgs!.busList!.first.basePrice,
                                                                                travelIdReturn: null,
                                                                                basePriceReturn: null);
                                                                            print('travel id in result is ${widget.resultArgs!.busList![index].travelId}');
                                                                            travelVM.setShouldInit(true);
                                                                            Navigator.pushNamed(
                                                                              context,
                                                                              '/TravelDetailViewNew',
                                                                              arguments: travelDetailArgsNew,
                                                                            );
                                                                          }
                                                                        } else {
                                                                          showInfoFlushbar(
                                                                              context,
                                                                              '',
                                                                              "لطفا اطلاعات پروفایل خود را تکمیل کنید!",
                                                                              true,
                                                                              durationSec: 2,
                                                                              function: resultViewModel!.goToProfile);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "خرید بلیط",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                fontSizeSubTitle,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 150,
                                                          width: 1,
                                                          //color: Colors.white,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  bottom: 20),
                                                          child: Text(
                                                            '|\n|\n|\n|\n|\n|\n|\n',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                height: 1.2,
                                                                color: Colors
                                                                    .black26),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: myWidth * 0.6 -
                                                              20,
                                                          height: 150,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 7,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20),
                                                              topRight: Radius
                                                                  .circular(20),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius:
                                                                      10,
                                                                  spreadRadius:
                                                                      1,
                                                                  color: Colors
                                                                      .black12)
                                                            ],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            2,
                                                                        left: 4,
                                                                        right:
                                                                            4,
                                                                        top: 8),
                                                                child: Row(
                                                                  children: [
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .busList![
                                                                              index]
                                                                          .arrivedTime!
                                                                          .substring(
                                                                              11,
                                                                              16),
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextTitle,
                                                                          fontSize:
                                                                              30,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Spacer(),
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .busList![
                                                                              index]
                                                                          .departureDateTime!
                                                                          .substring(
                                                                              11,
                                                                              16),
                                                                      maxLines:
                                                                          2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextTitle,
                                                                          fontSize:
                                                                              30,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            16),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .radio_button_unchecked,
                                                                      color:
                                                                          colorPrimary,
                                                                      size: 18,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                25,
                                                                            child:
                                                                                Container(
                                                                              constraints: BoxConstraints(maxHeight: 2),
                                                                              height: 2,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                                                gradient: LinearGradient(
                                                                                  colors: [
                                                                                    colorTextTitle,
                                                                                    colorPrimary,
                                                                                  ],
                                                                                  begin: Alignment.centerRight,
                                                                                  end: Alignment.centerLeft,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Icon(
                                                                              Icons.directions_bus_rounded,
                                                                              size: 25,
                                                                              color: Colors.black54,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .radio_button_unchecked,
                                                                      color:
                                                                          colorTextTitle,
                                                                      size: 18,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        top: 2),
                                                                child: Row(
                                                                  children: [
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .destinationName!,
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextTitle,
                                                                          fontSize: fontSizeTitle +
                                                                              3,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    AutoSizeText(
                                                                      widget
                                                                          .resultArgs!
                                                                          .sourceName!,
                                                                      maxLines:
                                                                          2,
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: TextStyle(
                                                                          color:
                                                                              colorTextTitle,
                                                                          fontSize: fontSizeTitle +
                                                                              3,
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            16,
                                                                        right:
                                                                            16),
                                                                child: Row(
                                                                  children: [
                                                                    const Image(
                                                                        image: AssetImage(
                                                                            'images/routing.png'),
                                                                        color:
                                                                            colorTextSub,
                                                                        height:
                                                                            20),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                        (widget.resultArgs!.busList![index].distanceFromSource ?? '380')
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                colorTextSub,
                                                                            fontSize:
                                                                                fontSizeSubTitle)),
                                                                    const Text(
                                                                        'km',
                                                                        style: TextStyle(
                                                                            color:
                                                                                colorTextSub,
                                                                            fontSize:
                                                                                fontSizeSubTitle - 3)),
                                                                    const Spacer(),
                                                                    const Icon(
                                                                      Icons
                                                                          .timelapse_sharp,
                                                                      size: 20,
                                                                      color:
                                                                          colorTextSub,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                        (widget.resultArgs!.busList![index].durationOverDistance ?? '240')
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                colorTextSub,
                                                                            fontSize:
                                                                                fontSizeSubTitle)),
                                                                    const Text(
                                                                        ' دقیقه',
                                                                        style: TextStyle(
                                                                            color:
                                                                                colorTextSub,
                                                                            fontSize:
                                                                                fontSizeSubTitle - 3)),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                  // ,
                                                  // Curves.easeOutCubic,
                                                  // Random().nextInt(
                                                  //         200) *
                                                  //     1.0,
                                                  // duration: 250);
                                                }),
                                          ),
                                        )
                                      : Container(),
                              ((widget.resultArgs!.busListReturn!.length ==
                                              null ||
                                          widget.resultArgs!.busListReturn!
                                                  .length <
                                              1) &&
                                      resultConsumer.resultArgs.isRoundTrip ==
                                          true &&
                                      resultConsumer.goingTripSelected == true)
                                  ? Column(
                                      children: <Widget>[
                                        Center(
                                          child:
                                              AutoSizeText("نتیجه ای یافت نشد"),
                                        ),
                                        SizedBox(width: 12),
                                        MaterialButton(
                                            color: colorPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            // padding: EdgeInsets.symmetric(vertical: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'تغییر تاریخ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: fontSizeTitle,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                Icon(Icons.date_range,
                                                    color: colorTextWhite,
                                                    size: 18)
                                              ],
                                            ),
                                            onPressed: () async {
                                              print('chang the date');
                                              resultViewModel!.clear();
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )
                                  : (resultConsumer.goingTripSelected == true)
                                      ? Expanded(
                                          child: ListView.builder(
                                              itemCount: widget.resultArgs!
                                                  .busListReturn!.length,
                                              itemBuilder: (context, index) {
                                                if (6 >=
                                                        int.parse(widget
                                                            .resultArgs!
                                                            .busList![index]
                                                            .departureDateTime!
                                                            .substring(
                                                                11, 13)) &&
                                                    18 <=
                                                        int.parse(widget
                                                            .resultArgs!
                                                            .busList![index]
                                                            .departureDateTime!
                                                            .substring(
                                                                11, 13))) {
                                                  widget.moonTypeReturn = 'شب';
                                                } else if (12 >
                                                        int.parse(widget
                                                            .resultArgs!
                                                            .busList![index]
                                                            .departureDateTime!
                                                            .substring(
                                                                11, 13)) &&
                                                    6 <
                                                        int.parse(widget
                                                            .resultArgs!
                                                            .busList![index]
                                                            .departureDateTime!
                                                            .substring(
                                                                11, 13))) {
                                                  widget.moonTypeReturn = 'صبح';
                                                }
                                                widget
                                                        .resultArgs!
                                                        .busListReturn![index]
                                                        .shamsiDate =
                                                    getShamsiDate(
                                                        "${widget.resultArgs!.busListReturn![index].departureDateTime!.substring(0, 10)}");

                                                return
                                                    // AnimationHandler()
                                                    //     .translateFromRight(
                                                    Container(
                                                  decoration: BoxDecoration(
                                                    //color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 10),
                                                  width: myWidth,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        width:
                                                            myWidth * 0.4 - 21,
                                                        height: 150,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 7,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                AutoSizeText(
                                                                  widget
                                                                      .resultArgs!
                                                                      .busListReturn![
                                                                          index]
                                                                      .shamsiDate!,
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextTitle,
                                                                      fontSize:
                                                                          fontSizeSubTitle,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                                AutoSizeText(
                                                                  'تاریخ : ',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                AutoSizeText(
                                                                  widget
                                                                          .resultArgs!
                                                                          .busListReturn![
                                                                              index]
                                                                          .basePrice
                                                                          .toString() +
                                                                      ' تومان',
                                                                  maxLines: 1,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                AutoSizeText(
                                                                  'قیمت : ',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                AutoSizeText(
                                                                  "${widget.resultArgs!.busListReturn![index].emptySeatCount}" +
                                                                      " نفر",
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextTitle,
                                                                      fontSize:
                                                                          fontSizeSubTitle,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                                AutoSizeText(
                                                                  'ظرفیت : ',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Consumer<
                                                                        TravelDetailViewModelNew>(
                                                                    builder: (_,
                                                                        travelVM,
                                                                        __) {
                                                                  return RaisedButton(
                                                                    elevation:
                                                                        5,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              18.0),
                                                                    ),
                                                                    color:
                                                                        colorPrimary,
                                                                    disabledColor:
                                                                        colorPrimary,
                                                                    onPressed:
                                                                        () async {
                                                                      TravelDetailArgsNew travelDetailArgsNew = TravelDetailArgsNew(
                                                                          sourceId: widget
                                                                              .resultArgs!
                                                                              .sourceId,
                                                                          destinationId: widget
                                                                              .resultArgs!
                                                                              .destinationId,
                                                                          travelId: widget
                                                                              .resultArgs!
                                                                              .busList![
                                                                                  index]
                                                                              .travelId,
                                                                          basePrice: widget
                                                                              .resultArgs!
                                                                              .busList!
                                                                              .first
                                                                              .basePrice,
                                                                          travelIdReturn: widget
                                                                              .resultArgs!
                                                                              .busListReturn![
                                                                                  index]
                                                                              .travelId,
                                                                          basePriceReturn: widget
                                                                              .resultArgs!
                                                                              .busListReturn!
                                                                              .first
                                                                              .basePrice);
                                                                      print(
                                                                          "return button tapped");
                                                                      travelVM.setShouldInit(
                                                                          true);
                                                                      Navigator
                                                                          .pushNamed(
                                                                        context,
                                                                        '/TravelDetailViewNew',
                                                                        arguments:
                                                                            travelDetailArgsNew,
                                                                      );
                                                                      resultConsumer
                                                                          .setreturnDateIndex(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "خرید بلیط",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              fontSizeSubTitle,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 150,
                                                        width: 1,
                                                        //color: Colors.white,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20,
                                                                bottom: 20),
                                                        child: Text(
                                                          '|\n|\n|\n|\n|\n|\n|\n',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              height: 1.2,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            myWidth * 0.6 - 20,
                                                        height: 150,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 7,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  Container(),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                AutoSizeText(
                                                                  "${widget.resultArgs!.busListReturn![index].departureDateTime!.substring(11, 16)}",
                                                                  maxLines: 2,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextSub,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                                AutoSizeText(
                                                                  widget
                                                                      .resultArgs!
                                                                      .destinationName!,
                                                                  maxLines: 2,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextSub,
                                                                      fontSize:
                                                                          fontSizeTitle +
                                                                              3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Container(
                                                                  width: 0,
                                                                  height: 40,
                                                                ),
                                                                AutoSizeText(
                                                                  widget
                                                                      .resultArgs!
                                                                      .sourceName!,
                                                                  maxLines: 2,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  style: TextStyle(
                                                                      color:
                                                                          colorTextSub,
                                                                      fontSize:
                                                                          fontSizeTitle +
                                                                              3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  AutoSizeText(
                                                                    widget
                                                                        .moonType,
                                                                    maxLines: 1,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTextSub,
                                                                        fontSize:
                                                                            fontSizeTitle,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .radio_button_checked,
                                                                      color: Colors
                                                                          .black38,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 5,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            gradient:
                                                                                LinearGradient(
                                                                              colors: [
                                                                                // use your preferred colors
                                                                                Colors.black38,
                                                                                colorPrimary,
                                                                              ],
                                                                              // start at the top
                                                                              begin: Alignment.topCenter,
                                                                              // end at the bottom
                                                                              end: Alignment.bottomCenter,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(40))),
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .radio_button_unchecked,
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                // ,
                                                // Curves.easeOutCubic,
                                                // Random().nextInt(200) *
                                                //     1.0,
                                                // duration: 250);
                                              }),
                                        )
                                      : Container(),
                            ],
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
