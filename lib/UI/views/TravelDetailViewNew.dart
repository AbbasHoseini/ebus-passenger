import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/UI/widgets/SeatGenderDialog.dart';
import 'package:ebus/core/models/SeatClass.dart';
import 'package:ebus/core/models/TravelDetailArgsNew.dart';
import 'package:ebus/core/viewmodels/TravelDetailVieModelNew.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TravelDetailViewNew extends StatelessWidget {
  TravelDetailViewModelNew? travelDetailViewModel;
  TravelDetailArgsNew? travelDetailArgs;
  TravelDetailViewNew({
    this.travelDetailArgs,
  });
  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    Color? seatColor;
    travelDetailViewModel =
        Provider.of<TravelDetailViewModelNew>(context, listen: false);
    travelDetailViewModel!.init(travelDetailArgs!, context);
    return Consumer<TravelDetailViewModelNew>(
        builder: (_, travelDetailTabBarVM, __) => DefaultTabController(
              length: travelDetailTabBarVM.isTwoWay == true ? 2 : 1,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: colorTextTitle),
                  bottom: travelDetailTabBarVM.isTwoWay == true
                      ? const TabBar(
                          tabs: [
                            Tab(
                              child: AutoSizeText(
                                "رفت",
                                style: TextStyle(
                                    color: colorTextTitle,
                                    fontSize: fontSizeTitle),
                              ),
                            ),
                            Tab(
                              child: AutoSizeText("برگشت",
                                  style: TextStyle(
                                      color: colorTextTitle,
                                      fontSize: fontSizeTitle)),
                            ),
                          ],
                        )
                      : null,
                  title: const Text(
                    "انتخاب صندلی",
                    style: TextStyle(
                        color: colorTextTitle, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            '${travelDetailTabBarVM.childCount}',
                            key: const Key('childCountText'),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: fontSizeSubTitle + 5,
                              fontWeight: FontWeight.bold,
                              color: colorTextPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  key: const Key('childCountIcon'),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: colorPrimary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.child_care,
                                    color: colorPrimary,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${travelDetailTabBarVM.adultCount}',
                            key: const Key('adultCountText'),
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: fontSizeSubTitle + 5,
                              fontWeight: FontWeight.bold,
                              color: colorTextPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  key: const Key('adultCountIcon'),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: colorPrimary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.person,
                                    color: colorPrimary,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                body: Container(
                  child: Stack(
                    children: <Widget>[
                      travelDetailTabBarVM.loading == true
                          ? Positioned(
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
                            )
                          : Container(),
                      TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children: getTabsWidget(
                              travelDetailTabBarVM.isTwoWay,
                              myWidth,
                              myHeight,
                              // seatColor,
                              Colors.transparent,
                              _,
                              travelDetailTabBarVM)),
                      travelDetailTabBarVM.loading == true
                          ? const Center(
                              child: Center(
                                child: SpinKitThreeBounce(
                                  color: colorPrimary,
                                  size: 25,
                                ),
                              ),
                            )
                          : Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child:
                                  // AnimationHandler().translateFromBottom(
                                  Container(
                                padding: const EdgeInsets.only(
                                    left: 18.0,
                                    right: 18.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: colorPrimaryGrey,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: TextField(
                                            key: const Key("voucher"),
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.text,
                                            // focusNode: myFocusNodeEmailLogin,
                                            controller: travelDetailViewModel!
                                                .voucherCodeController,
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              focusColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              filled: true,
                                              labelText:
                                                  myTravelDetailsVoucherCode,
                                              prefixIcon: const Icon(
                                                Icons.attach_money,
                                                color: colorPrimary,
                                              ),
                                              labelStyle: const TextStyle(
                                                  color: colorTextSub2,
                                                  fontSize: 17,
                                                  height: 1.5),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  borderSide: const BorderSide(
                                                    color: colorPrimary,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 0),
                                        child:
                                            Consumer<TravelDetailViewModelNew>(
                                          builder: (_, mainBtnVM, __) =>
                                              mainBtnVM.isBuying
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 16),
                                                      decoration: BoxDecoration(
                                                          color: colorPrimary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child:
                                                          const SpinKitThreeBounce(
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                    )
                                                  : InkWell(
                                                      key: const Key(
                                                          'buyTicketButton'),
                                                      onTap: () async {
                                                        mainBtnVM
                                                            .getTicketId(_)
                                                            .then((val) {
                                                          if (val == true) {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/InvoiceView',
                                                                arguments: mainBtnVM
                                                                    .invoiceArgs);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 16),
                                                        decoration: BoxDecoration(
                                                            color: colorPrimary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40)),
                                                        child: const Text(
                                                            'خرید',
                                                            style: TextStyle(
                                                                color:
                                                                    colorTextWhite,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    fontSizeTitle)),
                                                      ),
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Curves.easeOutCubic,
                              // 0,
                              // withOpacity: false,
                              // ),
                            )
                    ],
                  ),
                ),
              ),
            ));
  }
}

List<Widget> getTabsWidget(
    bool twoWay,
    double myWidth,
    double myHeight,
    Color? seatColor,
    BuildContext context,
    TravelDetailViewModelNew travelDetailViewModel) {
  List<Widget> temp = [];
  Color seatTextColor = colorTextPrimary;

  temp.add(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Consumer<TravelDetailViewModelNew>(
        builder: (_, travelDetailVM, __) => Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                alignment: const AlignmentDirectional(0.0, 0.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    travelDetailVM.loading == true
                        ? const Center(
                            child: Center(
                              child: SpinKitThreeBounce(
                                color: colorPrimary,
                                size: 25,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Stack(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            //Icon(Icons.location_city, color: colorAccent),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10),
                                              child: Column(
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    travelDetailVM
                                                        .destinationTitle,
                                                    maxLines: 2,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                        color: colorTextSub,
                                                        fontSize:
                                                            fontSizeTitle + 3,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      const Icon(
                                                        Icons
                                                            .radio_button_unchecked,
                                                        color: Colors.grey,
                                                        size: 18,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            gradient:
                                                                const LinearGradient(
                                                              colors: [
                                                                // use your preferred colors
                                                                Colors.grey,
                                                                colorPrimary,
                                                              ],
                                                              // start at the top
                                                              begin: Alignment
                                                                  .centerRight,
                                                              // end at the bottom
                                                              end: Alignment
                                                                  .centerLeft,
                                                            ),
                                                          ),
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
                                            const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Column(
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    travelDetailVM.sourceTitle,
                                                    maxLines: 2,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                        color: colorTextSub,
                                                        fontSize:
                                                            fontSizeTitle + 3,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            /*Icon(Icons.location_city, color: colorAccent),*/
                                          ],
                                        ),
                                        Container(
                                          key: const Key('seatLegend'),
                                          padding: const EdgeInsets.only(
                                              top: 40, right: 5, left: 5),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          width: (myWidth /
                                                                  4 *
                                                                  0.4) -
                                                              4,
                                                          height: (myWidth /
                                                                  4 *
                                                                  0.4) +
                                                              8,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  colorSeatDisabled,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        1),
                                                              ]),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 2),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 0,
                                                                  right: 0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.7),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black12,
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius:
                                                                      1),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: const Text(
                                                            '?',
                                                            style: TextStyle(
                                                                color:
                                                                    colorTextSub),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                    'غیرقابل انتخاب',
                                                    style: TextStyle(
                                                        fontSize:
                                                            textFontSizeSub),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: (myWidth / 4 * 0.4),
                                                    height:
                                                        (myWidth / 4 * 0.4) + 8,
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            width: (myWidth /
                                                                    4 *
                                                                    0.4) -
                                                                4,
                                                            height: (myWidth /
                                                                    4 *
                                                                    0.4) +
                                                                8,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    colorSeatChoosen,
                                                                borderRadius: BorderRadius.circular(5),
                                                                boxShadow: [
                                                                  const BoxShadow(
                                                                      color: Colors
                                                                          .black12,
                                                                      blurRadius:
                                                                          2,
                                                                      spreadRadius:
                                                                          1)
                                                                ]),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7),
                                                              boxShadow: [
                                                                const BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        1),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Text(
                                                              '?',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorTextSub),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Text(
                                                    'انتخاب شده',
                                                    style: TextStyle(
                                                        fontSize:
                                                            textFontSizeSub),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: (myWidth / 4 * 0.4),
                                                    height:
                                                        (myWidth / 4 * 0.4) + 8,
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            width: (myWidth /
                                                                    4 *
                                                                    0.4) -
                                                                4,
                                                            height: (myWidth /
                                                                    4 *
                                                                    0.4) +
                                                                8,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    colorSeatAvailable,
                                                                borderRadius: BorderRadius.circular(5),
                                                                boxShadow: [
                                                                  const BoxShadow(
                                                                      color: Colors
                                                                          .black12,
                                                                      blurRadius:
                                                                          2,
                                                                      spreadRadius:
                                                                          1)
                                                                ]),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0,
                                                                    right: 0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7),
                                                              boxShadow: [
                                                                const BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    spreadRadius:
                                                                        1,
                                                                    blurRadius:
                                                                        1),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Text(
                                                              '?',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorTextSub),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Text(
                                                    'قابل انتخاب',
                                                    style: TextStyle(
                                                        fontSize:
                                                            textFontSizeSub),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                // padding: const EdgeInsets.only(
                                //     left: 16, right: 16, top: 32),
                                child: Stack(
                                  children: [
                                    /* should be remove */
                                    // const Positioned.fill(
                                    //   child:
                                    //       //  AnimationHandler()
                                    //       //     .translateFromBottom(
                                    //       Hero(
                                    //     tag: 'busTag',
                                    //     child: Image(
                                    //       key: Key('busSchema'),
                                    //       image: AssetImage(
                                    //           'images/bus_schema.png'),
                                    //       // height: travelDetailVM.rowCount,
                                    //       // width: myWidth,
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    //   // Curves.easeOutCubic,
                                    //   // 0,
                                    //   // duration: 1500,
                                    //   // withOpacity: false),
                                    // ),
                                    // AnimationHandler().translateFromBottom(
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(60),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          )),
                                      key: const Key("seatList"),
                                      // margin: const EdgeInsets.only(
                                      //     top: 60,
                                      //     right: 20,
                                      //     left: 20,
                                      //     bottom: 10),
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      // height: myHeight / 2,
                                      child: Consumer<TravelDetailViewModelNew>(
                                        builder: (_, seatVM, __) => seatVM
                                                        .seats ==
                                                    null ||
                                                seatVM.seats.length < 1
                                            ? const Center(
                                                child: Text(
                                                  "لییست صندلی ها قابل نمایش نیست!",
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              )
                                            : Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: myWidth / 4 * 0.3,
                                                    ),
                                                    Expanded(
                                                      child: GridView.count(
                                                        shrinkWrap: true,
                                                        crossAxisCount: 4,
                                                        mainAxisSpacing: 0,
                                                        crossAxisSpacing: 0,
                                                        childAspectRatio: 1.0,
                                                        primary: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: List.generate(
                                                            seatVM.seats.length,
                                                            (int index) {
                                                          if (seatVM
                                                                  .seats[index]
                                                                  .available ==
                                                              1) {
                                                            seatColor = getClassColor(
                                                                seatVM
                                                                    .seats[
                                                                        index]
                                                                    .seatClass!,
                                                                seatVM
                                                                    .seats[
                                                                        index]
                                                                    .available);
                                                            seatTextColor =
                                                                Colors.white60;
                                                          } else if (seatVM
                                                                  .seats[index]
                                                                  .available ==
                                                              0) {
                                                            // seatColor =
                                                            //     colorSeatDisabled;
                                                            seatColor =
                                                                unableToSelectSeatBorderColor;

                                                            seatTextColor =
                                                                Colors.black12;
                                                          } else {
                                                            seatColor =
                                                                colorSeatChoosen;

                                                            seatTextColor =
                                                                Colors.white60;
                                                          }
                                                          Widget _seat;
                                                          var driverSeat =
                                                              Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    myWidth /
                                                                        4 *
                                                                        0.1),
                                                            child: const Image(
                                                              fit: BoxFit
                                                                  .contain,
                                                              color: Colors
                                                                  .black12,
                                                              key: Key("steer"),
                                                              image: AssetImage(
                                                                  'images/steer_wheel.png'),
                                                            ),
                                                          );

                                                          // var door = Padding(
                                                          //   padding:
                                                          //       EdgeInsets.all(
                                                          //           myWidth /
                                                          //               4 *
                                                          //               0.1),
                                                          //   child: const Image(
                                                          //     fit: BoxFit
                                                          //         .contain,
                                                          //     color: Colors
                                                          //         .black12,
                                                          //     key: Key("exit"),
                                                          //     image: AssetImage(
                                                          //         'images/exit.png'),
                                                          //   ),
                                                          // );
                                                          var emptySpace =
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: SizedBox(
                                                              width: myWidth /
                                                                  5 *
                                                                  0.7,
                                                              height: myWidth /
                                                                  5 *
                                                                  0.7,
                                                            ),
                                                          );

                                                          var availableSeat =
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: InkWell(
                                                              child: Container(
                                                                width: myWidth /
                                                                    4 *
                                                                    0.7,
                                                                height:
                                                                    myWidth /
                                                                        4 *
                                                                        0.7,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: seatColor ==
                                                                          classAColor
                                                                      ? insideClassAColor
                                                                      : seatColor ==
                                                                              unableToSelectSeatBorderColor
                                                                          ? unableToSelectSeatInsideColor
                                                                          : selectedInsideColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  border: Border.all(
                                                                      color: getClassColor(
                                                                          seatVM
                                                                              .seats[
                                                                                  index]
                                                                              .seatClass!,
                                                                          seatVM
                                                                              .seats[index]
                                                                              .available),
                                                                      width: 2.0),
                                                                ),
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2,
                                                                    vertical:
                                                                        2),
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Align(
                                                                      // top: 6,
                                                                      // left: 6,
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 5),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "${seatVM.seats[index].seatNumber}",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                // color: seatTextColor,
                                                                                fontSize: textFontSizeTitle,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'Sans'),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (seatVM
                                                                        .seats[
                                                                            index]
                                                                        .available ==
                                                                    0) {
                                                                  showInfoFlushbar(
                                                                      context,
                                                                      "این صندلی قابل انتخاب نیست",
                                                                      "این صندلی قابل انتخاب نیست",
                                                                      false,
                                                                      durationSec:
                                                                          2);
                                                                } else {
                                                                  if (seatVM
                                                                          .seats[
                                                                              index]
                                                                          .available ==
                                                                      2) {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (BuildContext context) => SeatGenderDialog(
                                                                            seatVM.seats[index].index!,
                                                                            false,
                                                                            seatVM.seats[index].seatClass!,
                                                                            seatVM.seats[index].gender!));
                                                                  } else {
                                                                    if ((seatVM.childCount +
                                                                            seatVM
                                                                                .adultCount) <=
                                                                        (seatVM.getChildSeatsCount() +
                                                                            seatVM.getAdultSeatCount())) {
                                                                      showInfoFlushbar(
                                                                          context,
                                                                          "تعداد صندلی‌های انتخابی نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                                                          "",
                                                                          false,
                                                                          durationSec:
                                                                              2);
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) => SeatGenderDialog(
                                                                              seatVM.seats[index].index!,
                                                                              false,
                                                                              seatVM.seats[index].seatClass!,
                                                                              seatVM.seats[index].gender!));
                                                                    }
                                                                  }
                                                                }
                                                              },
                                                            ),
                                                          );
                                                          if (seatVM
                                                                  .seats[index]
                                                                  .carLocationTypeId ==
                                                              4) {
                                                            // _seat = driverSeat;
                                                            _seat = Container();
                                                          } else if (seatVM
                                                                      .seats[
                                                                          index]
                                                                      .carLocationTypeId ==
                                                                  3 ||
                                                              seatVM
                                                                      .seats[
                                                                          index]
                                                                      .carLocationTypeId ==
                                                                  6) {
                                                            _seat =
                                                                availableSeat;
                                                          } else if (seatVM
                                                                  .seats[index]
                                                                  .carLocationTypeId ==
                                                              1) {
                                                            // _seat = door;
                                                            _seat = Container();
                                                          } else {
                                                            _seat = emptySpace;
                                                          }
                                                          Color _classColor =
                                                              getClassColor(
                                                                  seatVM
                                                                      .seats[
                                                                          index]
                                                                      .seatClass!,
                                                                  seatVM
                                                                      .seats[
                                                                          index]
                                                                      .available);

                                                          return Stack(
                                                            key: Key(
                                                                'seatWithId${seatVM.seats[index].id}'),
                                                            children: [
                                                              _seat,
                                                              /* Price of seats*/
                                                              // seatVM
                                                              //             .seats[
                                                              //                 index]
                                                              //             .seatClass ==
                                                              //         null
                                                              //     ? Container()
                                                              //     : seatVM.seats[index]
                                                              //                 .seatClass ==
                                                              //             null
                                                              //         ? Container()
                                                              //         : Align(
                                                              //             alignment:
                                                              //                 Alignment.bottomRight,
                                                              //             child:
                                                              //                 Container(
                                                              //               padding:
                                                              //                   const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                              //               margin:
                                                              //                   const EdgeInsets.only(top: 0, right: 4),
                                                              //               decoration:
                                                              //                   BoxDecoration(
                                                              //                 color: _classColor,
                                                              //                 boxShadow: [
                                                              //                   const BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1),
                                                              //                 ],
                                                              //                 borderRadius: BorderRadius.circular(5),
                                                              //               ),
                                                              //               child:
                                                              //                   Text(
                                                              //                 seatVM.seats[index].seatClass!.classTitle.toString(),
                                                              //                 style: const TextStyle(color: colorTextSub),
                                                              //               ),
                                                              //             ),
                                                              //           ),
                                                              // seatVM
                                                              //             .seats[
                                                              //                 index]
                                                              //             .gender ==
                                                              //         null
                                                              //     ? Container()
                                                              //     : seatVM.seats[index].available ==
                                                              //             1
                                                              //         ? Container()
                                                              //         : (seatVM.seats[index].carLocationTypeId != 3 &&
                                                              //                 seatVM.seats[index].carLocationTypeId != 6)
                                                              //             ? Container()
                                                              //             : Align(
                                                              //                 alignment: Alignment.bottomLeft,
                                                              //                 child: Container(
                                                              //                   key: Key('seatGenderIcon${seatVM.seats[index].id}'),
                                                              //                   padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                                              //                   margin: const EdgeInsets.only(top: 0, left: 4),
                                                              //                   decoration: BoxDecoration(
                                                              //                     color: _classColor,
                                                              //                     boxShadow: [
                                                              //                       const BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1),
                                                              //                     ],
                                                              //                     borderRadius: BorderRadius.circular(5),
                                                              //                   ),
                                                              //                   child: Icon(
                                                              //                     seatVM.getGenderIcon(seatVM.seats[index].gender!),
                                                              //                     size: 15,
                                                              //                   ),
                                                              //                 ),
                                                              //               ),
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: myWidth / 4 * 0.3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                    // Curves.easeOutCubic,
                                    // 1000,
                                    // duration: 1500,
                                    // withOpacity: true,
                                    // fromDownUnder:
                                    //     MediaQuery.of(context).size.height *
                                    //         -1.0),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 85,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  if (twoWay) {
    temp.add(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Consumer<TravelDetailViewModelNew>(
          builder: (_, travelDetailVM, __) => Stack(
            children: <Widget>[
              Container(
                alignment: const AlignmentDirectional(0.0, 0.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Stack(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    //Icon(Icons.location_city, color: colorAccent),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        children: <Widget>[
                                          AutoSizeText(
                                            travelDetailVM.sourceTitle,
                                            maxLines: 2,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                                color: colorTextSub,
                                                fontSize: fontSizeTitle + 3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                Icons.radio_button_unchecked,
                                                color: Colors.grey,
                                                size: 18,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        // use your preferred colors
                                                        colorPrimary,
                                                        colorPrimary
                                                            .withOpacity(0.5),
                                                      ],
                                                      // start at the top
                                                      begin:
                                                          Alignment.centerRight,
                                                      // end at the bottom
                                                      end: Alignment.centerLeft,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(
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
                                            travelDetailVM.destinationTitle,
                                            maxLines: 2,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                                color: colorTextSub,
                                                fontSize: fontSizeTitle + 3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*Icon(Icons.location_city, color: colorAccent),*/
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 30, right: 5, left: 5),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Image(
                                            width: myWidth / 4 * 0.4,
                                            height: myWidth / 4 * 0.4,
                                            fit: BoxFit.contain,
                                            color: Colors.black12,
                                            image: const AssetImage(
                                                'images/seat.png'),
                                          ),
                                          const Text(
                                            'غیرقابل انتخاب',
                                            style: TextStyle(
                                                fontSize: textFontSizeSub),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Image(
                                            width: myWidth / 4 * 0.4,
                                            height: myWidth / 4 * 0.4,
                                            fit: BoxFit.contain,
                                            color: Colors.orange,
                                            image: const AssetImage(
                                                'images/seat.png'),
                                          ),
                                          const Text(
                                            'انتخاب شده',
                                            style: TextStyle(
                                                fontSize: textFontSizeSub),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Image(
                                            width: myWidth / 4 * 0.4,
                                            height: myWidth / 4 * 0.4,
                                            fit: BoxFit.contain,
                                            color: colorAccent,
                                            image: const AssetImage(
                                                'images/seat.png'),
                                          ),
                                          const Text(
                                            'قابل انتخاب',
                                            style: TextStyle(
                                                fontSize: textFontSizeSub),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    travelDetailVM.loading == true
                        ? const Center(
                            child: Center(
                              child: SpinKitThreeBounce(
                                color: colorPrimary,
                                size: 25,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          color: colorPrimary),
                                      borderRadius: BorderRadius.circular(40)),
                                  margin: const EdgeInsets.only(
                                      top: 5, right: 30, left: 30),
                                  padding: const EdgeInsets.only(top: 5),
                                  height: myHeight / 2,
                                  /*height: travelDetailVM.seatsReturn.length /
                                      4 *
                                      myWidth /
                                      4 *
                                      0.75,*/
                                  child: Consumer<TravelDetailViewModelNew>(
                                    builder:
                                        (_, seatVM, __) =>
                                            seatVM.seatsReturn == null ||
                                                    seatVM.seatsReturn!.length <
                                                        1
                                                ? const Center(
                                                    child: Text(
                                                      "لییست صندلی ها قابل نمایش نیست!",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  )
                                                : Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width:
                                                              myWidth / 4 * 0.3,
                                                        ),
                                                        Expanded(
                                                          child: GridView.count(
                                                            crossAxisCount: 4,
                                                            mainAxisSpacing: 0,
                                                            crossAxisSpacing: 0,
                                                            childAspectRatio:
                                                                1.0,
                                                            primary: true,
                                                            children: List.generate(
                                                                seatVM
                                                                    .seatsReturn!
                                                                    .length,
                                                                (int index) {
                                                              if (seatVM
                                                                      .seatsReturn![
                                                                          index]
                                                                      .available ==
                                                                  1) {
                                                                seatColor = getClassColor(
                                                                seatVM
                                                                    .seats[
                                                                        index]
                                                                    .seatClass!,
                                                                seatVM
                                                                    .seats[
                                                                        index]
                                                                    .available);
                                                              } else if (seatVM
                                                                      .seatsReturn![
                                                                          index]
                                                                      .available ==
                                                                  0) {
                                                                seatColor =
                                                                    unableToSelectSeatBorderColor;
                                                              } else {
                                                                seatColor =
                                                                    // Colors
                                                                    //     .orange;
                                                                    selectedSeatBorderColor;
                                                              }
                                                              Widget _seat;
                                                              /*TODO: should be remove*/
                                                              // var driverSeat =
                                                              //     Padding(
                                                              //   padding:
                                                              //       EdgeInsets.all(
                                                              //           myWidth /
                                                              //               4 *
                                                              //               0.1),
                                                              //   child:
                                                              //       const Image(
                                                              //     fit: BoxFit
                                                              //         .contain,
                                                              //     color: Colors
                                                              //         .black45,
                                                              //     key: Key(
                                                              //         "steer"),
                                                              //     image: AssetImage(
                                                              //         'images/steer_wheel.png'),
                                                              //   ),
                                                              // );

                                                              /* should be remove */
                                                              // var door =
                                                              //     Padding(
                                                              //   padding:
                                                              //       EdgeInsets.all(
                                                              //           myWidth /
                                                              //               4 *
                                                              //               0.1),
                                                              //   child:
                                                              //       const Image(
                                                              //     fit: BoxFit
                                                              //         .contain,
                                                              //     color: Colors
                                                              //         .black45,
                                                              //     key: Key(
                                                              //         "exit"),
                                                              //     image: AssetImage(
                                                              //         'images/exit.png'),
                                                              //   ),
                                                              // );
                                                              var emptySpace =
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    SizedBox(
                                                                  width:
                                                                      myWidth /
                                                                          4 *
                                                                          0.7,
                                                                  height:
                                                                      myWidth /
                                                                          4 *
                                                                          0.7,
                                                                ),
                                                              );

                                                              var availableSeat =
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child: InkWell(
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        myWidth /
                                                                            4 *
                                                                            0.7,
                                                                    height:
                                                                        myWidth /
                                                                            4 *
                                                                            0.7,
                                                                    child:
                                                                        Stack(
                                                                      children: <
                                                                          Widget>[
                                                                        Positioned
                                                                            .fill(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Image(
                                                                              width: myWidth / 4 * 0.7,
                                                                              height: myWidth / 4 * 0.7,
                                                                              fit: BoxFit.contain,
                                                                              color: seatColor,
                                                                              image: const AssetImage('images/seatnew.png'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned
                                                                            .fill(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              "${seatVM.seatsReturn![index].seatNumber}",
                                                                              textAlign: TextAlign.center,
                                                                              style: const TextStyle(color: colorTextTitle, fontSize: textFontSizeSub, fontFamily: 'Sans'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    if (seatVM
                                                                            .seats[index]
                                                                            .available ==
                                                                        0) {
                                                                      showInfoFlushbar(
                                                                          context,
                                                                          "این صندلی قابل انتخاب نیست",
                                                                          "این صندلی قابل انتخاب نیست",
                                                                          false,
                                                                          durationSec:
                                                                              2);
                                                                    } else {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) => SeatGenderDialog(
                                                                              seatVM.seatsReturn![index].index!,
                                                                              true,
                                                                              seatVM.seatsReturn![index].seatClass!,
                                                                              seatVM.seatsReturn![index].gender!));
                                                                    }
                                                                  },
                                                                ),
                                                              );
                                                              print(
                                                                  'seatVM.seatsReturn[index].carLocationTypeId = ${seatVM.seatsReturn![index].carLocationTypeId}');
                                                              if (seatVM.seatsReturn![index]
                                                                          .carLocationTypeId ==
                                                                      4 // door
                                                                  ) {
                                                                _seat =
                                                                    Container();
                                                              } else if (seatVM
                                                                              .seatsReturn![
                                                                                  index]
                                                                              .carLocationTypeId ==
                                                                          3 // seat
                                                                      ||
                                                                      seatVM.seatsReturn![index]
                                                                              .carLocationTypeId ==
                                                                          6 //seat
                                                                  ) {
                                                                _seat =
                                                                    availableSeat;
                                                              } else if (seatVM
                                                                          .seatsReturn![
                                                                              index]
                                                                          .carLocationTypeId ==
                                                                      1 //driver seat
                                                                  ) {
                                                                // _seat = door;
                                                                _seat =
                                                                    Container();
                                                              } else {
                                                                _seat =
                                                                    emptySpace;
                                                              }
                                                              Color _classColor = getClassColor(
                                                                  seatVM
                                                                      .seatsReturn![
                                                                          index]
                                                                      .seatClass!,
                                                                  seatVM
                                                                      .seats[
                                                                          index]
                                                                      .available);
                                                              return Stack(
                                                                children: [
                                                                  _seat,
                                                                  seatVM.seatsReturn![index]
                                                                              .seatClass ==
                                                                          null
                                                                      ? Container()
                                                                      : Align(
                                                                          alignment:
                                                                              Alignment.bottomCenter,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                                            decoration:
                                                                                BoxDecoration(color: _classColor, borderRadius: BorderRadius.circular(5)),
                                                                            child:
                                                                                Text(
                                                                              seatVM.seatsReturn![index].seatClass!.seatPrice.toString(),
                                                                              style: const TextStyle(color: colorTextWhite),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                  seatVM.seatsReturn![index]
                                                                              .seatClass ==
                                                                          null
                                                                      ? Container()
                                                                      : Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                                                            margin:
                                                                                const EdgeInsets.only(top: 4, right: 4),
                                                                            decoration:
                                                                                BoxDecoration(color: _classColor, shape: BoxShape.circle),
                                                                            child:
                                                                                Text(
                                                                              seatVM.seatsReturn![index].seatClass!.classTitle.toString(),
                                                                              style: const TextStyle(color: colorTextWhite),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                ],
                                                              );
                                                            }),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              myWidth / 4 * 0.3,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 85,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return temp;
}

// Color getClassColor(SeatClass seatClass) {
//   //  Colors.white.withOpacity(0.75);
//   if (seatClass.classId == 0) {
//     return Colors.transparent;
//   } else {
//     switch (seatClass.classTitle) {
//       case 'A':
//         // if (seatAvailable == 0) {
//         //     return unableToSelectSeatBorderColor;
//         //   } else if (seatAvailable == 1) {
//         //     return classAColor;
//         //   } else {
//         //     return selectedSeatBorderColor;
//         // }
//         return classAColor;
//       case 'B':
//         return classBColor;
//       case 'C':
//         return classCColor;
//       default:
//         return defaultColor;
//     }
//   }
// }

Color getClassColor(seatClass, seatAvailable) {
  if (seatClass.classId == 0) {
    return Colors.transparent;
  } else {
    switch (seatClass.classTitle) {
      case 'A':
        print('EEEEEEEEEEEEEEEEEEee $seatAvailable');
        if (seatAvailable == 0) {
          return unableToSelectSeatBorderColor;
        } else if (seatAvailable == 1) {
          return classAColor;
        } else {
          return selectedSeatBorderColor;
        }
      // return Colors.yellow[600];
      // break;
      case 'B':
        // return Colors.cyan;
        if (seatAvailable == 0) {
          return unableToSelectSeatBorderColor;
        } else if (seatAvailable == 1) {
          return classBColor;
        } else {
          return selectedSeatBorderColor;
        }
      // break;
      case 'C':
        // return Colors.brown[300];
        if (seatAvailable == 0) {
          return unableToSelectSeatBorderColor;
        } else if (seatAvailable == 1) {
          return classCColor;
        } else {
          return selectedSeatBorderColor;
        }
      // break;
      default:
        return defaultColor;
    }
  }
}
