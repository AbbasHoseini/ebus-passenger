import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/UI/widgets/CurrentQRDialog.dart';
import 'package:ebus/core/viewmodels/GeneratedTicketViewModel.dart';
import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratedTicketsView extends StatefulWidget {
  @override
  _GeneratedTicketsViewState createState() => _GeneratedTicketsViewState();
}

class _GeneratedTicketsViewState extends State<GeneratedTicketsView> {
  GeneratedTicketViewModel? generatedTicketViewModel;

  @override
  void initState() {
    super.initState();
    generatedTicketViewModel =
        Provider.of<GeneratedTicketViewModel>(context, listen: false);
    //generatedTicketViewModel.getTicketsList((context));
    generatedTicketViewModel!.initPR(context);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    GlobalKey _globalKey = GlobalKey();

    return WillPopScope(
      onWillPop: () {
        return generatedTicketViewModel!.onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: colorPrimaryGrey,
        appBar: AppBar(
          leading: Container(),
          backgroundColor: colorPrimaryGrey,
          elevation: 0,
          title: Text(
            'بلیط شماره‌ی ${generatedTicketViewModel!.getTicketId()} صادر شد',
            style: const TextStyle(color: colorTextTitle),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: RepaintBoundary(
            key: _globalKey,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
              decoration: const BoxDecoration(
                color: colorPrimaryGrey,
              ),
              child: Consumer<GeneratedTicketViewModel>(
                builder: (_, qrVM, __) => qrVM.getLoading == true
                    ? const Center(child: CircularProgressIndicator(color: colorPrimary))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // AnimationHandler().popUp(
                                              ((){
                                                print('yyyyyyyyyyyyyyyyyyy ${qrVM.departureDate}');
                                                return Container();
                                              }()),
                                                AutoSizeText(
                                                  getShamsiDate(qrVM.departureDate!),
                                                  maxLines: 1,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      // height: 0.5,
                                                      color: colorTextSub,
                                                      fontSize: fontSizeTitle,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Curves.easeInOut,
                                                // 0,
                                                // duration: 250),
                                            Expanded(child: Container()),
                                            // AnimationHandler().popUp(
                                                AutoSizeText(
                                                  "${qrVM.name} ${qrVM.family}",
                                                  maxLines: 1,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      // height: 0.5,
                                                      color: colorTextSub,
                                                      fontSize: fontSizeTitle,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Curves.easeInOut,
                                                // 0,
                                                // duration: 250),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        const Divider(indent: 32, endIndent: 32),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            // AnimationHandler().popUp(
                                                AutoSizeText(
                                                  "${qrVM.arivalTime}",
                                                  maxLines: 1,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      // height: 0.1,
                                                      color: colorTextTitle,
                                                      fontSize:
                                                          fontSizeTitle + 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Curves.easeOutCubic,
                                                // 200,
                                                // duration: 200),
                                            Expanded(child: Container()),
                                            AutoSizeText(
                                              "${getHourMin(qrVM.duration ?? 240)}",
                                              maxLines: 1,
                                              textDirection: TextDirection.rtl,
                                              style: const TextStyle(
                                                  color: colorTextSub,
                                                  fontSize: fontSizeTitle,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Expanded(child: Container()),
                                            // AnimationHandler().popUp(
                                                AutoSizeText(
                                                  "${qrVM.departureTime}",
                                                  maxLines: 1,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      // height: 0.1,
                                                      color: colorTextTitle,
                                                      fontSize:
                                                          fontSizeTitle + 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Curves.easeInOut,
                                                // 800,
                                                // duration: 250),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20,
                                                  left: 0,
                                                  right: 0,
                                                  bottom: 20),
                                              child: Row(
                                                children: <Widget>[
                                                  // AnimationHandler().popUp(
                                                      const Icon(
                                                        Icons
                                                            .radio_button_unchecked,
                                                        color: colorTextTitle,
                                                        size: 18,
                                                      ),
                                                      // Curves.easeOutCubic,
                                                      // 800,
                                                      // duration: 150),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: 
                                                              // AnimationHandler()
                                                                  // .scaleFromRight(
                                                                      Container(
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            2,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(40)),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              // use your preferred colors
                                                                              colorTextSub2,
                                                                              colorTextSub2,
                                                                            ],
                                                                            // start at the top
                                                                            begin:
                                                                                Alignment.centerRight,
                                                                            // end at the bottom
                                                                            end:
                                                                                Alignment.centerLeft,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // Curves
                                                                      //     .easeOutCubic,
                                                                      // 400,
                                                                      // duration:
                                                                      //     300),
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
                                                  // AnimationHandler().popUp(
                                                      const Icon(
                                                          Icons
                                                              .radio_button_unchecked,
                                                          color: colorTextTitle,
                                                          size: 18),
                                                      // Curves.easeOutCubic,
                                                      // 200,
                                                      // duration: 200),
                                                ],
                                              ),
                                            ),
                                            Positioned.fill(
                                              // alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const[
                                                   Icon(Icons.arrow_back_ios,
                                                      color: colorTextPrimary,
                                                      size: 15),
                                                   Icon(
                                                    Icons
                                                        .directions_bus_rounded,
                                                    color: colorTextPrimary,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // AnimationHandler().popUp(
                                                AutoSizeText(
                                                  qrVM.destinationCity!,
                                                  maxLines: 2,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: const TextStyle(
                                                      height: 1.5,
                                                      color: colorTextTitle,
                                                      fontSize: fontSizeTitle,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Curves.easeInOut,
                                                // 800,
                                                // duration: 250),
                                            Expanded(child: Container()),
                                            // AnimationHandler().popUp(
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: AutoSizeText(
                                                    qrVM.sourceCity ?? '',
                                                    maxLines: 2,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                        height: 1.5,
                                                        color: colorTextTitle,
                                                        fontSize: fontSizeTitle,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // Curves.easeOutCubic,
                                                // 200,
                                                // duration: 200),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 4),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AutoSizeText(
                                          '${qrVM.getSeatList().length}',
                                          maxFontSize: fontSizeTitle + 30,
                                          minFontSize: fontSizeTitle + 5,
                                          style: const TextStyle(
                                              color: colorTextTitle,
                                              fontSize: fontSizeTitle + 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const AutoSizeText(
                                          'صندلی',
                                          maxFontSize: fontSizeTitle,
                                          minFontSize: fontSizeTitle - 5,
                                          style: TextStyle(
                                              color: colorTextSub2,
                                              fontSize: fontSizeTitle,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: const VerticalDivider(
                                      color: colorDivider,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AutoSizeText(
                                          '${qrVM.duration ?? 0}',
                                          maxFontSize: fontSizeTitle + 30,
                                          minFontSize: fontSizeTitle + 5,
                                          style: const TextStyle(
                                              color: colorTextTitle,
                                              fontSize: fontSizeTitle + 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const AutoSizeText(
                                          'دقیقه',
                                          maxFontSize: fontSizeTitle,
                                          minFontSize: fontSizeTitle - 5,
                                          style: TextStyle(
                                              color: colorTextSub2,
                                              fontSize: fontSizeTitle,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: const VerticalDivider(
                                      color: colorDivider,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AutoSizeText(
                                          '${qrVM.distance ?? 0}',
                                          maxFontSize: fontSizeTitle + 30,
                                          minFontSize: fontSizeTitle + 5,
                                          style: const TextStyle(
                                              color: colorTextTitle,
                                              fontSize: fontSizeTitle + 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const AutoSizeText(
                                          'کیلومتر',
                                          maxFontSize: fontSizeTitle,
                                          minFontSize: fontSizeTitle - 5,
                                          style: TextStyle(
                                              color: colorTextSub2,
                                              fontSize: fontSizeTitle,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CurrentQRDialog(qrVM.base64QR));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 20),
                                width: myWidth / 2,
                                child: QrImage(
                                  data: qrVM.base64QR ?? '',
                                  size: myWidth / 2,
                                  version: 2,
                                  // backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: myWidth - 40,
                              height: 40,
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton.icon(
                                      color: colorPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      icon: const Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        "صفحه اصلی ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSizeTitle,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      elevation: 1,
                                      onPressed: () async {
                                        MainViewModel mainViewModel =
                                            Provider.of<MainViewModel>(context,
                                                listen: false);
                                        mainViewModel.getUserCurrentTravel();
                                        Navigator.popUntil(context,
                                            ModalRoute.withName('/MainView'));
                                      }),
                                  Consumer<GeneratedTicketViewModel>(
                                      builder: (_, captureBTN, __) {
                                    return captureBTN.downloading == true
                                        ? const SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator())
                                        : RaisedButton.icon(
                                            color: colorPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            icon: const Icon(
                                              Icons.file_download,
                                              color: Colors.white,
                                            ),
                                            label: const Text(
                                              "دریافت بلیط ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fontSizeTitle + 2,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            elevation: 1,
                                            onPressed: () async {
                                              captureBTN.setDownloading(true);
                                              await captureBTN.capturePng(
                                                  _globalKey, _);
                                            });
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              indent: 64,
                              endIndent: 64,
                              color: colorDivider,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                'مسافران',
                                style: TextStyle(
                                  fontSize: textFontSizeTitle,
                                  color: colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Consumer<GeneratedTicketViewModel>(
                              builder: (_, generatedVM, __) => generatedVM
                                      .getLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          generatedVM.getTickets.length,
                                      itemBuilder: (context, index) {
                                        IconData genderIcon;
                                        String gender;
                                        if (generatedVM
                                                .getTickets[index].gender ==
                                            1) {
                                          gender = "مرد";
                                          genderIcon = MdiIcons.humanMale;
                                        } else if (generatedVM
                                                .getTickets[index].gender ==
                                            0) {
                                          gender = "زن";
                                          genderIcon = MdiIcons.humanFemale;
                                        } else {
                                          gender = "کودک";
                                          genderIcon = MdiIcons.babyFace;
                                        }
                                        return Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              const BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${(index >= generatedVM.getTickets.length / 2 && generatedVM.isTwoWay) ? generatedVM.ticketIdReturn : generatedVM.getTickets[index].seatNumber}" +
                                                        "\t",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: const TextStyle(
                                                        color: colorTextTitle,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            fontSizeTitle),
                                                  ),
                                                  const Text(
                                                    "شماره صندلی ",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                        color: colorTextSub,
                                                        fontSize:
                                                            fontSizeSubTitle),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "${generatedVM.getTickets[index].name}" +
                                                        " " +
                                                        "${generatedVM.getTickets[index].familyName}",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                        color: colorTextTitle,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            fontSizeTitle),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getHourMin(int duration) {
    int hour = 0;
    int minute = 0;
    String hourMinute = ' ';
    hour = (duration / 60).floor();
    minute = duration % 60;
    if (minute == 0) {
      hourMinute = '$hour ساعت';
    } else {
      hourMinute = '$hour ساعت $minute دقیقه';
    }
    return hourMinute;
  }
}
