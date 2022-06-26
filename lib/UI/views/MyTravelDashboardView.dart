import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/UI/widgets/CurrentQRDialog.dart';
import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/core/viewmodels/MyTravelDashboardViewModel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTravelDashboardView extends StatefulWidget {
  @override
  _MyTravelDashboardViewState createState() => _MyTravelDashboardViewState();
}

class _MyTravelDashboardViewState extends State<MyTravelDashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  MyTravelDashboardViewModel? myTravelDashboardVM;

  @override
  void initState() {
    super.initState();
    myTravelDashboardVM =
        Provider.of<MyTravelDashboardViewModel>(context, listen: false);
    myTravelDashboardVM!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    print('MyTravelDashboardView build called');
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/MainView'));
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: AutoSizeText(
            myTravelsTitle,
            style: TextStyle(
                color: colorTextTitle,
                fontSize: fontSizeTitle + 5,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/RefundsView');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Text(
                  'استردادها',
                  style: TextStyle(
                      color: colorFlatButton,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
          iconTheme: IconThemeData(color: colorTextTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: colorBackground,
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Consumer<MyTravelDashboardViewModel>(
              builder: (_, mainVM, __) => Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 0.0),
                    child: mainVM.loading == true
                        ? Center(
                            key: Key('loading'),
                            child: CircularProgressIndicator(),
                          )
                        : Consumer<MyTravelDashboardViewModel>(
                            builder: (_, listVM, __) {
                            return Container(
                              child: (mainVM.myTravels == null) ||
                                      (mainVM.myTravels.length < 0 ||
                                          mainVM.myTravels.isEmpty)
                                  ? Container(
                                      height: myHeight * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "نتیجه ای برای نمایش وجود ندارد!",
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      primary: true,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Image.asset('images/bus.png',
                                                height: 200),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      double.parse(
                                                              mainVM.travelTime)
                                                          .ceil()
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: const TextStyle(
                                                          color: colorTextTitle,
                                                          fontSize:
                                                              fontSizeTitle +
                                                                  20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Text(
                                                      "ساعت با ایباس",
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          color: colorTextSub2,
                                                          fontSize:
                                                              fontSizeTitle,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "${mainVM.travelCount}",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: colorTextTitle,
                                                        fontSize:
                                                            fontSizeTitle + 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "سفر با ایباس",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: colorTextSub2,
                                                        fontSize: fontSizeTitle,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "${mainVM.travelDistance}",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: colorTextTitle,
                                                        fontSize:
                                                            fontSizeTitle + 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "کیلومتر با ایباس",
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: colorTextSub2,
                                                        fontSize: fontSizeTitle,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          ListView.builder(
                                              itemCount:
                                                  listVM.myTravels.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                listVM.myTravels[index]
                                                        .shamsiDate =
                                                    getShamsiDate(
                                                        "${listVM.myTravels[index].date!.substring(0, 10)}");
                                                TravelHistoryArgs travel =
                                                    listVM.myTravels[index];
                                                return
                                                    // AnimationHandler()
                                                    //     .translateFromRight(
                                                    _travelItem(
                                                        travel, context, index);
                                                // Curves.easeOutCubic,
                                                // Random().nextInt(200) *
                                                //     1.0,
                                                // duration: 250);
                                              }),
                                        ],
                                      ),
                                    ),
                            );
                          }),
                  )),
        ),
      ),
    );
  }

  Widget _travelItem(
      TravelHistoryArgs travel, BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.black12)
          ]),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  child: FlutterMap(
                    key: Key('mapCurrent'),
                    mapController: myTravelDashboardVM!.mapList[index],
                    options: MapOptions(
                      center: LatLng(travel.sourceLat!, travel.sourceLong!),
                      zoom: 10.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        errorImage: AssetImage('images/login_icon.png'),
                        urlTemplate:
                            "http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                        // urlTemplate:
                        //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b'],
                      ),
                      MarkerLayerOptions(
                        markers: [
                          Marker(
                            point:
                                LatLng(travel.sourceLat!, travel.sourceLong!),
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                size: 50,
                                color: colorPrimary,
                              ),
                            ),
                          ),
                          Marker(
                            point: LatLng(travel.destLat!, travel.destLong!),
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                size: 50,
                                color: colorPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                myTravelDashboardVM!.isAfter(travel.date!)
                    ? Positioned(
                        top: 8,
                        left: 8,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/RefundView', arguments: travel.id);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'استرداد',
                              style: TextStyle(color: colorTextWhite),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                travel.qrCode != null
                    ? Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    CurrentQRDialog(travel.qrCode!));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: QrImage(
                              padding: EdgeInsets.all(0.1),
                              data: travel.qrCode!,
                              size: 35,
                              version: 2,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24, right: 24, top: 12),
            child: Row(
              children: [
                Container(
                    child: Text(
                  travel.destTown!,
                  style: TextStyle(
                      color: colorTextSub,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle + 5),
                )),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 25,
                        child:
                            Divider(thickness: 2, indent: 10, endIndent: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 25,
                          color: colorTextSub2,
                        ),
                        Icon(
                          Icons.directions_bus,
                          size: 25,
                          color: colorTextSub2,
                        ),
                      ],
                    )
                  ],
                )),
                Container(
                    child: Text(
                  travel.sourceTown!,
                  style: TextStyle(
                      color: colorTextSub,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle + 5),
                )),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(left: 24, right: 24, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    child: Text(
                  travel.shamsiDate ?? ' ',
                  style: TextStyle(
                      color: colorTextSub2,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                  textDirection: TextDirection.rtl,
                )),
                Spacer(),
                Container(
                    child: Text(
                  myTravelDashboardVM!.formatter
                          .format(travel.travelTicketPrice) +
                      ' ریال',
                  style: TextStyle(
                      color: colorTextSub2,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                  textDirection: TextDirection.rtl,
                )),
                Spacer(),
                Container(
                    child: Text(
                  travel.time ?? ' ',
                  style: TextStyle(
                      color: colorTextSub2,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                  textDirection: TextDirection.rtl,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
