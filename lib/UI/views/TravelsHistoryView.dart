import 'dart:async';
import 'dart:typed_data';

import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/core/viewmodels/GeneratedTicketViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TravelsHistoryView extends StatelessWidget {
  List<TravelHistoryArgs>? travels;

  TravelsHistoryView({this.travels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myTravelsBtnTitle),
        backgroundColor: colorPrimary,
        actions: <Widget>[],
      ),
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (travels!.length == null || travels!.length < 1)
                    ? Center(
                        child: Text("نتیجه ای یافت نشد"),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: travels!.length,
                            itemBuilder: (context, index) {
                              travels![index].shamsiDate =
                                  getShamsiDate("${travels![index].date}");
                              /*return Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: 120.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.0, color: colorSecond),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      "${travels[index].travelTicketPrice}"+"تومان ",
                                                      textDirection:
                                                      TextDirection
                                                          .ltr,
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      "از:  " +
                                                          travels[index].sourceTown,
                                                      textDirection:
                                                      TextDirection
                                                          .rtl,
                                                      style: TextStyle(
                                                          color:
                                                          colorTextSub,
                                                          fontSize:
                                                          fontSizeMedTitle),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "${travels[index].id}"+"شماره بلیط ",
                                                        textDirection:
                                                        TextDirection
                                                            .ltr,
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Text(
                                                        "به:  " +
                                                            travels[index].destTown,
                                                        textDirection:
                                                        TextDirection
                                                            .rtl,
                                                        style: TextStyle(
                                                            color:
                                                            colorTextSub,
                                                            fontSize:
                                                            fontSizeMedTitle),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: colorAccent,
                                            width: 10,
                                            thickness: 3,
                                            indent: 5,
                                            endIndent: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            travels[index].time+
                                                "\n" +
                                                travels[index].shamsiDate ,
                                            textDirection:
                                            TextDirection.ltr,
                                          ),
                                          MaterialButton(
                                              color: colorPrimary,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5.0),
                                              ),
                                              child: Text(
                                                "مشاهده جزئیات",
                                                textDirection:
                                                TextDirection.rtl,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  textFontSizeSub,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              //
                                              onPressed: () async {
                                                //Todo show detail dialog
                                              }),
                                          Text(
                                                "تعداد صندلی های"+"\n"+
                                                "  خریداری شده : "+ "${travels[index].seatCount}",
                                            style: TextStyle(
                                                color: colorTextSub,
                                                fontSize:
                                                fontSizeMedTitle),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );*/
                              return Card(
                                child: Container(
//                    margin: const EdgeInsets.only(top: 10.0),
                                  padding: const EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width,
                                  height: 185.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(MdiIcons.ticketAccount,
                                                        color: colorAccent),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "شماره بلیط : " +
                                                          "${travels![index].id}" +
                                                          "\t",
                                                      textDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "تعداد صندلی های" +
                                                          "\n" +
                                                          "  خریداری شده : " +
                                                          "${travels![index].seatCount}",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          color: colorTextSub,
                                                          fontSize:
                                                              fontSizeMedTitle),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(MdiIcons.seatPassenger,
                                                        color: colorAccent),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: colorAccent,
                                            ),
                                            Flexible(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Icon(
                                                                    MdiIcons
                                                                        .calendarRange,
                                                                    color:
                                                                        colorAccent),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  travels![index]
                                                                      .shamsiDate!,
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 1,
                                                            ),
                                                            Text(
                                                              travels![index]
                                                                  .sourceTown!,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              style: TextStyle(
                                                                  color:
                                                                      colorTextSub,
                                                                  fontSize:
                                                                      fontSizeMedTitle),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Flexible(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      MdiIcons
                                                                          .calendarClock,
                                                                      color:
                                                                          colorAccent),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    "${travels![index].time}",
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                travels![index]
                                                                    .destTown!,
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                style: TextStyle(
                                                                    color:
                                                                        colorTextSub,
                                                                    fontSize:
                                                                        fontSizeMedTitle),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .radio_button_unchecked,
                                                        color: Colors.grey,
                                                        size: 18,
                                                      ),
                                                      Container(
                                                        color: colorAccent,
                                                        width: 3,
                                                        height: 18,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .radio_button_checked,
                                                        color: colorPrimary,
                                                        size: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  /* Row(
                                              children: <Widget>[
                                                Icon(genderIcon,
                                                    color: colorAccent),
                                                Text(
                                                  " $gender",
                                                  textDirection:
                                                  TextDirection.ltr,
                                                ),
                                              ],
                                            ),*/
                                                  Text(
                                                    "${travels![index].travelTicketPrice}" +
                                                        "تومان ",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: colorPrimary,
                                                        fontSize:
                                                            fontSizeMedTitle),
                                                  ),
                                                  Consumer<
                                                          GeneratedTicketViewModel>(
                                                      builder:
                                                          (_, generatedVM, __) {
                                                    return RaisedButton.icon(
                                                        color: colorPrimary,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        icon: Icon(
                                                            MdiIcons
                                                                .cardAccountDetailsOutline,
                                                            color:
                                                                colorTextWhite),
                                                        label: Text(
                                                          "مشاهده جزئیات",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                textFontSizeSub,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        //
                                                        onPressed: () async {
                                                          generatedVM
                                                              .setIsHistoryDetail(
                                                                  true);
                                                          generatedVM
                                                              .setTicketId(
                                                                  travels![index]
                                                                      .id!);
                                                          Navigator.pushNamed(
                                                            context,
                                                            '/TicketDetailView',
                                                          );
                                                          /*
                                                      List<int> pdf;
                                                      pdf = await generateTicketPdf(PdfPageFormat.a4);
                                                      try{
                                                        print("runtimeType TravelHistoryView ${pdf.runtimeType}");
                                                      }
                                                      catch(e){
                                                        print("e TravelHistoryView $e");
                                                      }
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/TicketDetailPdf',
                                                        arguments: pdf,
                                                      );
                                                      */
                                                        });
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
              ],
            ),
          )),
    );
  }
}
