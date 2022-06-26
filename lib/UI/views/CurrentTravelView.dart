import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/UI/widgets/CurrentPassengerList.dart';
import 'package:ebus/UI/widgets/CurrentQRDialog.dart';
import 'package:ebus/core/viewmodels/CurrentTravelViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import 'package:latlong2/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CurrentTravelView extends StatefulWidget {
  @override
  _CurrentTravelViewState createState() => _CurrentTravelViewState();
}

class _CurrentTravelViewState extends State<CurrentTravelView> {
  CurrentTravelViewModel? currentTravelViewModel;
  @override
  void initState() {
    currentTravelViewModel =
        Provider.of<CurrentTravelViewModel>(context, listen: false);
    currentTravelViewModel!.getUserLocation(false);
    currentTravelViewModel!.initiate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'سفر فعلی',
            style: TextStyle(
                color: colorTextTitle,
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: colorTextTitle),
        ),
        body: Consumer<CurrentTravelViewModel>(
          builder: (_, currentTravelConsumer, __) => !currentTravelConsumer
                  .isInternetOff
              ? currentTravelConsumer.isLoaded
                  ? Container(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 200,
                              child: FlutterMap(
                                mapController:
                                    currentTravelConsumer.mapController,
                                options: MapOptions(
                                  center: LatLng(30, 30),
                                  zoom: 14.0,
                                ),
                                layers: [
                                  TileLayerOptions(
                                    errorImage:
                                        AssetImage('images/login_icon.png'),
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'],
                                  ),
                                  MarkerLayerOptions(
                                    markers: currentTravelConsumer.markers +
                                        [currentTravelConsumer.userMarker],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text('زمان حرکت',
                                        style: TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeSubTitle)),
                                    SizedBox(height: 2),
                                    Text(
                                        convertDateTimeToJalali(
                                            currentTravelConsumer.currentTravel
                                                .departureDatetime!),
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 2)),
                                    SizedBox(height: 2),
                                    Text('راننده',
                                        style: TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeSubTitle)),
                                    Text(
                                        currentTravelConsumer.currentTravel
                                                .primaryDriverFirstName! +
                                            ' ' +
                                            currentTravelConsumer.currentTravel
                                                .primaryDriverLastName!,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            color: colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 2)),
                                    SizedBox(height: 2),
                                    Text('پلاک',
                                        style: TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeSubTitle)),
                                    Text(
                                        currentTravelConsumer
                                                .currentTravel.plaqueNumber ??
                                            "۴۴۱ پ ۵۶",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 2)),
                                    SizedBox(height: 2),
                                    Text('خریدار',
                                        style: TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeSubTitle)),
                                    Text(
                                        currentTravelConsumer.currentTravel
                                                .passengerSupervisorName ??
                                            " ",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 2)),
                                    Text('هزینه',
                                        style: TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeSubTitle)),
                                    Text(
                                        '${currentTravelConsumer.currentTravel.orginalPrice} تومان',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: colorTextPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: fontSizeTitle + 2)),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 16),
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      right: BorderSide(
                                          width: 1.0, color: Colors.black12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: colorPrimary,
                                                size: 20,
                                              ),
                                              Container(
                                                color: colorPrimary,
                                                width: 3,
                                                height: 65,
                                              ),
                                              Icon(
                                                Icons.radio_button_unchecked,
                                                color: colorPrimary,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            children: <Widget>[
                                              AutoSizeText(
                                                currentTravelConsumer
                                                    .currentTravel.srcTitle!,
                                                style: TextStyle(
                                                  color: colorTextPrimary,
                                                  fontSize: fontSizeTitle + 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Stack(
                                                children: <Widget>[
                                                  Container(
                                                    width: 5,
                                                    height: 65,
                                                  ),
                                                  Container(
                                                    height: 65,
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: colorPrimary,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              AutoSizeText(
                                                currentTravelConsumer
                                                    .currentTravel.destTitle!,
                                                style: TextStyle(
                                                  color: colorTextPrimary,
                                                  fontSize: fontSizeTitle + 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CurrentQRDialog(
                                                      currentTravelConsumer
                                                          .currentTravel
                                                          .qrcode!));
                                        },
                                        child: Hero(
                                          tag: "qrcode",
                                          child: Container(
                                            padding: EdgeInsets.only(right: 0),
                                            height: 120,
                                            width: 120,
                                            // child: Image.memory(
                                            //   base64Decode(
                                            //     currentTravelConsumer
                                            //         .convertToBase64(
                                            //             currentTravelConsumer
                                            //                 .currentTravel
                                            //                 .qrcode),
                                            //   ),
                                            //   fit: BoxFit.cover,
                                            // ),
                                            child: QrImage(
                                              data: currentTravelConsumer
                                                  .currentTravel.qrcode!,
                                              version: 2,
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: Colors.black45,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child: Text('مسافران',
                                  style: TextStyle(
                                      color: colorTextSub,
                                      fontSize: fontSizeTitle,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 8),
                            CurrentPassengerList(
                              passengers: currentTravelConsumer
                                  .currentTravel.listOfPassanger!,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'خطا در ارتباط با اینترنت',
                      ),
                      SizedBox(height: 8),
                      RaisedButton(
                        color: colorPrimary,
                        child: Text(
                          'سعی مجدد',
                          style: TextStyle(color: colorTextWhite),
                        ),
                        onPressed: () {
                          currentTravelConsumer.getUserCurrentTravel(false);
                        },
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
