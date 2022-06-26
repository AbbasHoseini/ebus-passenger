import 'dart:async';

import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/models/ReportTitleItem.dart';
import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/core/viewmodels/ReportViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmitReportView extends StatefulWidget {
  @override
  _SubmitReportViewState createState() => _SubmitReportViewState();
}

class _SubmitReportViewState extends State<SubmitReportView> {
  bool rebuild = true;
  ReportViewModel? reportViewModel;

  @override
  void initState() {
    super.initState();
    reportViewModel = Provider.of<ReportViewModel>(context, listen: false);
    reportViewModel!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            title: const Text(
              'پشتیبانی',
              style: TextStyle(
                color: colorTextTitle,
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: <Widget>[],
          ),
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      color: Colors.grey[100],
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 30.0, bottom: 10),
                      child: const Text(
                        'چه مشکلی پیش آمده است؟',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    color: Colors.grey[100],
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: Consumer<ReportViewModel>(
                      builder: (_, reportVM, __) => reportVM.loading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: reportVM.mainTitleList.length,
                              itemBuilder: (_, index) {
                                if (true) {
                                  return ExpandablePanel(
                                    key: Key('supportItem$index'),
                                    collapsed: Container(),
                                    header: Container(
                                      // height: 50,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        semanticContainer: true,
                                        margin: const EdgeInsets.all(5),
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Icon(
                                                  reportVM
                                                          .expandableController[
                                                              index]
                                                          .expanded
                                                      ? Icons
                                                          .keyboard_arrow_down_rounded
                                                      : Icons
                                                          .keyboard_arrow_left,
                                                  size: 18,
                                                ),
                                                const Expanded(
                                                  child: SizedBox(
                                                    width: 1,
                                                  ),
                                                ),
                                                Text(
                                                  "${reportVM.mainTitleList[index].title}",
                                                  style: const TextStyle(
                                                    color: colorTextTitle,
                                                    fontSize: textFontSizeSub,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            if (reportVM.list[index].length < 1) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    25.0)),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      key: const Key(
                                                          'submitReportWidget'),
                                                      //alignment: Alignment.topCenter,
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Consumer<
                                                              ReportViewModel>(
                                                          builder:
                                                              (_, reportVM,
                                                                      __) =>
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Consumer<ReportViewModel>(
                                                                              builder: (_, reportVM3, __) => Expanded(
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.all(10),
                                                                                  child: Directionality(
                                                                                    textDirection: TextDirection.rtl,
                                                                                    child: TextField(
                                                                                      key: const Key("description"),
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: reportVM3.travelIdController,
                                                                                      style: const TextStyle(
                                                                                        color: colorTextTitle,
                                                                                        fontSize: textFontSizeTitle,
                                                                                      ),
                                                                                      decoration: InputDecoration(
                                                                                        fillColor: colorPrimaryGrey,
                                                                                        focusColor: Colors.white,
                                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                                        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40)),
                                                                                        filled: true,
                                                                                        labelText: 'کد سفر',
                                                                                        prefixIcon: const Icon(
                                                                                          Icons.date_range,
                                                                                          color: colorPrimary,
                                                                                        ),
                                                                                        labelStyle: const TextStyle(color: colorTextSub2, fontSize: 17, height: 1.5),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.circular(40),
                                                                                            borderSide: const BorderSide(
                                                                                              color: colorPrimary,
                                                                                            )),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Consumer<
                                                                            ReportViewModel>(
                                                                          builder: (_, reportVM4, __) =>
                                                                              TextField(
                                                                            //key: Key("description"),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            controller:
                                                                                reportVM4.descriptionController,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: colorTextTitle,
                                                                              fontSize: textFontSizeSub,
                                                                            ),
                                                                            maxLines:
                                                                                5,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                              isDense: true, // Added this
                                                                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black45)),
                                                                              hintText: "توضیحات",
                                                                              hintStyle: TextStyle(
                                                                                color: colorTextSub2,
                                                                                fontSize: textFontSizeTitle,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Divider(),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: <
                                                                              Widget>[
                                                                            Flexible(
                                                                              child: SizedBox(
                                                                                width: double.infinity,
                                                                                child: RaisedButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(_);
                                                                                  },
                                                                                  child: const Text(
                                                                                    btnCancel,
                                                                                    style: TextStyle(color: colorPrimary),
                                                                                  ),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Flexible(
                                                                                child: Consumer<ReportViewModel>(
                                                                              builder: (_, reportVM5, __) => SizedBox(
                                                                                width: double.infinity,
                                                                                child: MaterialButton(
                                                                                  onPressed: () async {
                                                                                    //todo
                                                                                    bool submitted = false;
                                                                                    submitted = await reportVM5.submitReportInfo(_);
                                                                                    if (submitted) {
                                                                                      Timer(const Duration(seconds: 5), () {
                                                                                        Navigator.of(_).pop();
                                                                                      });
                                                                                    } else {
                                                                                      Timer(const Duration(seconds: 3), () {
                                                                                        Navigator.of(_).pop();
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                  child: const Text(
                                                                                    myProfileSuccess,
                                                                                    style: TextStyle(color: colorTextWhite),
                                                                                  ),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                  disabledColor: colorPrimary,
                                                                                  color: colorPrimary,
                                                                                ),
                                                                              ),
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                    );
                                                  });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    controller:
                                        reportVM.expandableController[index],
                                    theme: ExpandableThemeData(
                                        hasIcon: false,
                                        tapBodyToExpand:
                                            reportVM.list[index].length > 0
                                                ? true
                                                : false),
                                    expanded: reportVM.list[index].length > 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: List.generate(
                                              reportVM.list[index].length,
                                              (int index2) {
                                                return GestureDetector(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    margin: const EdgeInsets.all(5),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      child: Text(
                                                        "${reportVM.list[index][index2].title}",
                                                        style: const TextStyle(
                                                          color: colorTextTitle,
                                                          fontSize:
                                                              textFontSizeSub,
                                                        ),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    reportVM.selectedSubTitle =
                                                        reportVM.list[index]
                                                            [index2];
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        25.0)),
                                                      ),
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          key: const Key(
                                                              'submitReportWidget'),
                                                          // padding:
                                                          //     MediaQuery.of(
                                                          //             context)
                                                          //         .viewInsets,
                                                          child: Consumer<
                                                              ReportViewModel>(
                                                            builder: (_,
                                                                    reportVM,
                                                                    __) =>
                                                                reportVM.loading ==
                                                                        true
                                                                    ? const Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(15.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: <
                                                                              Widget>[
                                                                            Row(
                                                                              children: <Widget>[
                                                                                Consumer<ReportViewModel>(
                                                                                  builder: (_, reportVM3, __) => Expanded(
                                                                                    child: Container(
                                                                                      margin: const EdgeInsets.only(bottom: 10),
                                                                                      child: Directionality(
                                                                                        textDirection: TextDirection.rtl,
                                                                                        child: TextField(
                                                                                          key: const Key("travelId"),
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: reportVM3.travelIdController,
                                                                                          style: const TextStyle(
                                                                                            color: colorTextTitle,
                                                                                            fontSize: textFontSizeTitle,
                                                                                          ),
                                                                                          decoration: InputDecoration(
                                                                                            fillColor: colorPrimaryGrey,
                                                                                            focusColor: Colors.white,
                                                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40)),
                                                                                            filled: true,
                                                                                            labelText: 'کد سفر را وارد کنید',
                                                                                            labelStyle: const TextStyle(color: colorTextSub2, fontSize: 17, height: 1.5),
                                                                                            focusedBorder: OutlineInputBorder(
                                                                                                borderRadius: BorderRadius.circular(40),
                                                                                                borderSide: const BorderSide(
                                                                                                  color: colorPrimary,
                                                                                                )),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Consumer<ReportViewModel>(
                                                                              builder: (_, reportVM4, __) => Container(
                                                                                child: Directionality(
                                                                                  textDirection: TextDirection.rtl,
                                                                                  child: TextField(
                                                                                    key: const Key("description"),
                                                                                    keyboardType: TextInputType.text,
                                                                                    controller: reportVM4.descriptionController,
                                                                                    style: const TextStyle(
                                                                                      color: colorTextTitle,
                                                                                      fontSize: textFontSizeTitle,
                                                                                    ),
                                                                                    maxLines: 5,
                                                                                    decoration: InputDecoration(
                                                                                      fillColor: colorPrimaryGrey,
                                                                                      focusColor: Colors.white,
                                                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40)),
                                                                                      filled: true,
                                                                                      labelText: 'توضیحات',
                                                                                      // prefixIcon: Icon(
                                                                                      //   Icons.date_range,
                                                                                      //   color: colorPrimary,
                                                                                      // ),
                                                                                      labelStyle: const TextStyle(color: colorTextSub2, fontSize: 17, height: 1.5),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(1),
                                                                                          borderSide: const BorderSide(
                                                                                            color: colorPrimary,
                                                                                          )),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: SizedBox(
                                                                                    width: double.infinity,
                                                                                    child: OutlineButton(
                                                                                      key: const Key('cancelSupportButton'),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      color: Colors.white,
                                                                                      child: const Text(
                                                                                        btnCancel,
                                                                                        style: TextStyle(color: colorPrimary),
                                                                                      ),
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Flexible(
                                                                                  child: Consumer<ReportViewModel>(
                                                                                    builder: (_, reportVM5, __) => SizedBox(
                                                                                      width: double.infinity,
                                                                                      child: MaterialButton(
                                                                                        key: const Key('submitSupportButton'),
                                                                                        elevation: 0,
                                                                                        onPressed: () async {
                                                                                          bool submitted = false;
                                                                                          submitted = await reportVM5.submitReportInfo(_);
                                                                                          // Navigator.of(context).pop();
                                                                                        },
                                                                                        child: const Text(
                                                                                          myProfileSuccess,
                                                                                          style: TextStyle(color: colorTextWhite),
                                                                                        ),
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                        ),
                                                                                        disabledColor: colorPrimary,
                                                                                        color: colorPrimary,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                        : Container(),
                                  );
                                }
                              },
                            ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 30.0, bottom: 10),
                    child: const Text(
                      'مشکل پیش آمده در موارد بالا نیست ؟',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        launch("tel://02433460244");
                      },
                      child: Container(
                        color: Colors.grey[100],
                        // height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const Icon(
                                  Icons.phone,
                                  size: 18,
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    width: 1,
                                  ),
                                ),
                                const Text(
                                  "تماس با پشتیبانی",
                                  style: TextStyle(
                                    color: colorTextTitle,
                                    fontSize: textFontSizeSub,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: MediaQuery.of(context).size.height / 1.3,
          // bottom: 80,
          child: SizedBox(
            width: 120,
            child: RaisedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/ReportsView');
              },
              color: colorPrimary,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  side: BorderSide(color: colorPrimary)),
              child: const Text(
                "گزارشات ثبت شده",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
