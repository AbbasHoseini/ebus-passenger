import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/UI/widgets/CancelPayDialog.dart';
import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/core/viewmodels/InvoiceViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class InvoiceView extends StatefulWidget {
  InvoiceArgs? invoiceArgs;
  InvoiceView({this.invoiceArgs});

  @override
  _InvoiceViewState createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  InvoiceViewModel? invoiceViewModel;
  String? date;
  @override
  void initState() {
    super.initState();
    invoiceViewModel = Provider.of<InvoiceViewModel>(context, listen: false);
    invoiceViewModel!.init(context, widget.invoiceArgs!);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        showDialog(context: context, builder: (context) => CancelPayDialog());
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   title: Text(
          //     "خرید بلیط",
          //     style: TextStyle(
          //         color: colorTextPrimary,
          //         fontSize: fontSizeTitle + 3,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   iconTheme: IconThemeData(color: Colors.black),
          // ),
          backgroundColor: colorBackground,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      child: Container(
                        height: 300,
                        child: FlutterMap(
                          key: Key('mapSource'),
                          mapController: invoiceViewModel!.mapController,
                          options: MapOptions(
                            center: widget.invoiceArgs!.sourcePoint ??
                                LatLng(36.5, 36.5),
                            zoom: 14.0,
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
                                  point: widget.invoiceArgs!.sourcePoint ??
                                      LatLng(0.0, 0.0),
                                  builder: (ctx) => const Icon(
                                    Icons.location_on,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                ),
                                Marker(
                                  point: widget.invoiceArgs!.destinationPoint ??
                                      LatLng(0.0, 0.0),
                                  builder: (ctx) => const Icon(
                                    Icons.location_on,
                                    size: 50,
                                    color: colorPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).padding.top),
                        // margin: EdgeInsets.only(left: 24, right: 24),
                        height: kToolbarHeight,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1.0),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 1,
                                color: Colors.black12),
                          ],
                        ),
                        child: const Text(
                          "پیش فاکتور",
                          style: TextStyle(
                              color: colorTextPrimary,
                              fontSize: fontSizeTitle + 3,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // AnimationHandler().translateFromBottom(
                    (Container(
                      margin:
                          const EdgeInsets.only(top: 250, left: 24, right: 24),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 24, bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: Colors.black12),
                        ],
                      ),
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color:
                                                colorPrimary.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.attach_money_rounded,
                                          color: colorPrimary,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  invoiceViewModel!.formatter.format(
                                      widget.invoiceArgs!.discountAmount),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: fontSizeTitle + 2,
                                    fontWeight: FontWeight.bold,
                                    color: colorTextTitle,
                                  ),
                                ),
                                Text(
                                  ' ریال',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: fontSizeTitle,
                                    fontWeight: FontWeight.bold,
                                    color: colorTextSub,
                                  ),
                                ),
                                Spacer(),
                                SizedBox(width: 4),
                                Text(
                                  '${widget.invoiceArgs!.ticketId}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: fontSizeSubTitle + 5,
                                    fontWeight: FontWeight.bold,
                                    color: colorTextPrimary,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  // padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color:
                                                colorPrimary.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.money,
                                          color: colorPrimary,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  widget.invoiceArgs!.sourceName!,
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
                                        child: Divider(
                                            thickness: 2,
                                            indent: 10,
                                            endIndent: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.directions_bus,
                                          size: 25,
                                          color: colorTextSub2,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_left,
                                          size: 25,
                                          color: colorTextSub2,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                                Container(
                                    child: Text(
                                  widget.invoiceArgs!.destinationName!,
                                  style: TextStyle(
                                      color: colorTextSub,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle + 5),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colorPrimary.withOpacity(0.2),
                                    // color: Colors.white,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black12,
                                    //     blurRadius: 5,
                                    //     spreadRadius: 0.5,
                                    //   )
                                    // ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: colorPrimary,
                                    size: 25,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  widget.invoiceArgs!.fullName!,
                                  style: TextStyle(
                                      color: colorTextSub,
                                      fontSize: fontSizeTitle + 2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              ' صندلی با شماره‌های ${_getTSeatNumbers()} برای شما رزرو شدند. درصورت عدم پرداخت تا ۱۵ دقیقه، صندلی‌های رزرو شده لغو خواهند شد.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: colorTextSub2),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Webservice()
                                          .getPayByBank(
                                              widget
                                                  .invoiceArgs!.discountAmount!,
                                              widget.invoiceArgs!.orderId!)
                                          .then((value) {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Icon(
                                              MdiIcons.bank,
                                              color: colorTextWhite,
                                            ),
                                          ),
                                          // SizedBox(width: 8),
                                          Container(
                                            alignment: Alignment.center,
                                            child: AutoSizeText(
                                              'پرداخت بانکی',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: colorTextWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: fontSizeTitle - 2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      //TODO
                                      if (widget.invoiceArgs!.discountAmount ==
                                              null ||
                                          widget.invoiceArgs!.discountAmount! <=
                                              0) {
                                        showInfoFlushbar(
                                            context,
                                            "مبلغ پرداختی معتبر نیست",
                                            "مبلغ پرداختی معتبر نیست",
                                            false,
                                            durationSec: 2);
                                      } else {
                                        String token = await getToken();
                                        print('wwwwwwwwwwwwwww orderId ${widget.invoiceArgs!.orderId}');
                                        Webservice()
                                            .getPayByCreditResult(
                                                token, widget.invoiceArgs!)
                                            .then((response) {
                                          if (response != null) {
                                            final bodyResponse =
                                                json.decode(response.body);

                                            int statusCode =
                                                response.statusCode;

                                            print(
                                                'response getPayByCreditResult = ${response.statusCode}');
                                            print(
                                                'rrrrrrrrrrrrrrrrrrrrrrrrrrr ${response.body}');

                                            if (statusCode == 200 ||
                                                statusCode == 201) {
                                              Navigator.pushNamed(
                                                context,
                                                '/AssignPassengersView',
                                              );
                                            } else {
                                              if (response.statusCode == 403 ||
                                                  bodyResponse['message'] ==
                                                      'Credit is not enough') {
                                                showInfoFlushbar(
                                                    context,
                                                    'اعتبار کیف پول شما کافی نیست',
                                                    'اعتبار کیف پول کافی نیست',
                                                    false,
                                                    durationSec: 3);
                                              } else {
                                                String message;
                                                message =
                                                    bodyResponse["message"];
                                                showInfoFlushbar(context, 'خطا',
                                                    message, false,
                                                    durationSec: 3);
                                              }
                                            }
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.wallet_travel_rounded,
                                              color: colorTextWhite,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            alignment: Alignment.center,
                                            child: AutoSizeText(
                                              'کیف پول',
                                              style: TextStyle(
                                                  color: colorTextWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: fontSizeTitle - 2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                    // Curves.easeOutExpo,
                    // 0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTSeatNumbers() {
    String seats = '';
    for (var i = 0; i < widget.invoiceArgs!.seats!.length; i++) {
      seats += widget.invoiceArgs!.seats![i].seatNumber.toString();
      if (i != widget.invoiceArgs!.seats!.length - 1) {
        seats += '، ';
      }
    }
    return seats;
  }
}
