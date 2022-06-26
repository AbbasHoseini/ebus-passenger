import 'dart:convert';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/core/viewmodels/GeneratedTicketViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TicketDetailView extends StatelessWidget {
  GeneratedTicketViewModel? generatedTicketViewModel;

  @override
  Widget build(BuildContext context) {
    generatedTicketViewModel =
        Provider.of<GeneratedTicketViewModel>(context, listen: false);
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    if (generatedTicketViewModel!.isHistoryDetail) {
      generatedTicketViewModel!.getTicketsDetail(context);
    }
    GlobalKey _globalKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text("جزئیات"),
        backgroundColor: colorPrimary,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("دریافت بلیط"),
              Consumer<GeneratedTicketViewModel>(builder: (_, captureBTN, __) {
                return captureBTN.downloading == true
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: Icon(
                          Icons.cloud_download,
                        ),
                        tooltip: 'دریافت بلیط',
                        onPressed: () async {
                          captureBTN.setDownloading(true);
                          await captureBTN.capturePng(_globalKey, _);
                        },
                      );
              }),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Container(
                alignment: AlignmentDirectional(0.0, 0.0),
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Consumer<GeneratedTicketViewModel>(
                    builder: (_, generatedVM, __) => generatedVM.getLoading ==
                            true
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: myWidth / 2,
                                  child: QrImage(
                                    data: generatedVM
                                        .base64QR /*??
                                        "an api that is not working like always"*/
                                    ,
                                    size: myWidth / 2,
                                    //embeddedImage: AssetImage('images/icon.png'),
                                    //embeddedImageStyle: QrEmbeddedImageStyle(color: Colors.white),
                                    version: 10,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  showInfoFlushbar(
                                      _,
                                      "نکته!",
                                      "برای دریافت بلیط بصورت pdf لطفا روی عکس را لمس کرده و اندکی نگه دارید",
                                      false,
                                      durationSec: 4);
                                },
                                onLongPress: () {},
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.location_city,
                                            color: colorAccent),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            children: <Widget>[
                                              AutoSizeText(
                                                generatedVM.destinationCity!,
                                                maxLines: 2,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: colorTextSub,
                                                    fontSize: fontSizeTitle + 3,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.radio_button_checked,
                                          color: colorPrimary,
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  ),
                                                  Expanded(
                                                    child: Divider(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  // Icon(
                                                  //   Icons.arrow_forward_ios,
                                                  //   color: Colors.grey,
                                                  //   size: 18,
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.radio_button_unchecked,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            children: <Widget>[
                                              AutoSizeText(
                                                generatedVM.sourceCity!,
                                                maxLines: 2,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: colorTextSub,
                                                    fontSize: fontSizeTitle + 3,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.location_city,
                                            color: colorAccent),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              generatedVM.isHistoryDetail == false
                                  ? Container(
                                      width: myWidth - 40,
                                      child: Consumer<GeneratedTicketViewModel>(
                                        builder: (_, toggleVm, __) =>
                                            LayoutBuilder(builder:
                                                (context, constraints) {
                                          return ToggleButtons(
                                            constraints: BoxConstraints.expand(
                                                width: constraints.maxWidth /
                                                    3), //number 2 is number of toggle buttons
                                            fillColor: colorPrimary,
                                            borderWidth: 0,
                                            selectedColor: colorTextWhite,
                                            color: colorPrimary,
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'مقصد',
                                                  style: TextStyle(
                                                      fontSize: fontSizeTitle),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'مسیر',
                                                  style: TextStyle(
                                                      fontSize: fontSizeTitle),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'مبدا',
                                                  style: TextStyle(
                                                      fontSize: fontSizeTitle),
                                                ),
                                              ),
                                            ],
                                            onPressed: (int index) {
                                              if (index != 1) {
                                                toggleVm
                                                    .setToggleListTrue(index);
                                              }
                                            },
                                            isSelected: toggleVm.toggleList,
                                          );
                                        }),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0.1,
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              (generatedVM.isHistoryDetail == false)
                                  ? Container(
                                      width: myWidth,
                                      height: myHeight * 0.35,
                                      child: Stack(
                                        children: <Widget>[
                                          Consumer<GeneratedTicketViewModel>(
                                            builder: (_, mapVM, __) =>
                                                FlutterMap(
                                              key: Key('mapCurrent'),
                                              mapController: mapVM
                                                  .mapController, // travelDetailViewModel.mapSourceController,
                                              options: MapOptions(
                                                center: mapVM.currentPoint,
                                                zoom: 14.0,
                                              ),
                                              layers: [
                                                TileLayerOptions(
                                                  errorImage: AssetImage(
                                                      'images/login_icon.png'),
                                                  urlTemplate:
                                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  subdomains: ['a', 'b', 'c'],
                                                ),
                                                MarkerLayerOptions(
                                                  markers: [
                                                    Marker(
                                                      point: mapVM.sourcePoint,
                                                      builder: (ctx) =>
                                                          Container(
                                                        child: Icon(
                                                          Icons.home,
                                                          size: 50,
                                                          color: colorPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    Marker(
                                                      point: mapVM
                                                          .destinationPoint,
                                                      builder: (ctx) =>
                                                          Container(
                                                        child: Icon(
                                                          Icons.work,
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
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0.1,
                                    ),
                              generatedVM.isHistoryDetail == true
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "${generatedVM.getTickets.length}" +
                                                " نفر مسافر ",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: colorAccent,
                                                fontSize: fontSizeTitle),
                                          ),
                                          Icon(MdiIcons.human,
                                              color: colorAccent),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 0.1,
                                    ),
                              ((generatedVM.isHistoryDetail == true) || 1 == 1)
                                  ? Column(
                                      children: [
                                        Container(
                                          color: Colors.red,
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                generatedVM.getTickets.length,
                                            itemBuilder: (_, index) {
                                              IconData genderIcon;
                                              String gender;
                                              print('generating tickets');
                                              if (generatedVM.getTickets[index]
                                                      .gender ==
                                                  1) {
                                                gender = "مرد";
                                                genderIcon = MdiIcons.humanMale;
                                              } else if (generatedVM
                                                      .getTickets[index]
                                                      .gender ==
                                                  0) {
                                                gender = "زن";
                                                genderIcon =
                                                    MdiIcons.humanFemale;
                                              } else {
                                                gender = "کودک";
                                                genderIcon = MdiIcons.babyFace;
                                              }
                                              return Card(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 70.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(MdiIcons.seat,
                                                              color:
                                                                  colorAccent),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "شماره صندلی : " +
                                                                "${generatedVM.getTickets[index].seatNumber}",
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "نام :" +
                                                                " " +
                                                                "${generatedVM.getTickets[index].name}" +
                                                                " " +
                                                                "${generatedVM.getTickets[index].familyName}",
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                                color:
                                                                    colorTextSub,
                                                                fontSize:
                                                                    fontSizeMedTitle),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(genderIcon,
                                                              color:
                                                                  colorAccent),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    )
                                  : Container(
                                      color: Colors.red,
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ],
                          ))),
          ),
        ),
      ),
    );
  }
}
