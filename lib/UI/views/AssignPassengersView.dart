import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/viewmodels/GeneratedTicketViewModel.dart';
import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/core/viewmodels/TravelDetailVieModelNew.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignPassengersView extends StatefulWidget {
  @override
  _AssignPassengersViewState createState() => _AssignPassengersViewState();
}

class _AssignPassengersViewState extends State<AssignPassengersView> {
  PassengersViewModel? passengersViewModel;

  GeneratedTicketViewModel? generatedTicketViewModel;

  TravelDetailViewModelNew? travelDetailViewModel;

  @override
  void initState() {
    super.initState();
    passengersViewModel =
        Provider.of<PassengersViewModel>(context, listen: false);
    travelDetailViewModel =
        Provider.of<TravelDetailViewModelNew>(context, listen: false);
    generatedTicketViewModel =
        Provider.of<GeneratedTicketViewModel>(context, listen: false);

    passengersViewModel!.initPassengersSeat(travelDetailViewModel!.seats,
        travelDetailViewModel!.seatsReturn, context);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: colorTextPrimary),
        title: const Text(
          'اطلاعات مسافران',
          style: TextStyle(
              color: colorTextPrimary,
              fontWeight: FontWeight.bold,
              fontSize: fontSizeTitle),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<PassengersViewModel>(
            builder: (_, mainAssignVM, __) => mainAssignVM.loading == true
                ? const Center(child: CircularProgressIndicator( color: colorPrimary,))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Container(
                                    child: Text(
                                  mainAssignVM.destName,
                                  style: const TextStyle(
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
                                        child: const Divider(
                                            thickness: 2,
                                            indent: 10,
                                            endIndent: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.directions_bus,
                                          size: 25,
                                          color: colorTextSub2,
                                        ),
                                        const Icon(
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
                                  mainAssignVM.sourceName,
                                  style: const TextStyle(
                                      color: colorTextSub,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle + 5),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.check, size: 50, color: colorPrimary),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  "پرداخت با موفقیت انجام شد",
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                      fontSize: textFontSizeTitle,
                                      color: colorTextTitle,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                    "لطفا مسافر مربوط به هر صندلی را وارد کنید",
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                      fontSize: textFontSizeSub,
                                      color: colorTextSub,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Consumer<PassengersViewModel>(
                        builder: (_, pass, __) => Center(
                          child: Text(
                            pass.selectedSeats == null ? "لیست خالیست!" : "",
                          ),
                        ),
                      ),
                      Container(
                          key: const Key("selectedSeatList"),
                          child: Consumer<PassengersViewModel>(
                              builder: (_, passenger, __) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: passenger.selectedSeats.length,
                                  itemBuilder: (BuildContext _, int mainIndex) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white,
                                          boxShadow: [
                                            const BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1,
                                                blurRadius: 10)
                                          ]),
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          right: 16,
                                          left: 16),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: (myWidth / 4 * 0.5),
                                                height: (myWidth / 4 * 0.5) + 8,
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        width: (myWidth /
                                                                4 *
                                                                0.5) -
                                                            4,
                                                        height: (myWidth /
                                                                4 *
                                                                0.5) +
                                                            8,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                colorSeatChoosen,
                                                            borderRadius: BorderRadius.circular(5),
                                                            boxShadow: [
                                                              const BoxShadow(
                                                                  color: Colors
                                                                      .black12,
                                                                  blurRadius: 2,
                                                                  spreadRadius:
                                                                      1)
                                                            ]),
                                                      ),
                                                    ),
                                                    Align(
                                                      // top: 6,
                                                      // left: 6,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5),
                                                        child: Text(
                                                          "${passenger.selectedSeats[mainIndex].seatNumber}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontSize:
                                                                  textFontSizeTitle +
                                                                      15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Sans'),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 6,
                                                                vertical: 2),
                                                        margin: const EdgeInsets.only(
                                                            top: 0, right: 0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          boxShadow: [
                                                            const BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                spreadRadius: 1,
                                                                blurRadius: 1),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          passenger
                                                              .selectedSeats[
                                                                  mainIndex]
                                                              .seatClass!
                                                              .classTitle
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  colorTextPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 3,
                                                                vertical: 3),
                                                        margin: const EdgeInsets.only(
                                                            top: 0, left: 0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          boxShadow: [
                                                            const BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                spreadRadius: 1,
                                                                blurRadius: 1),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Icon(
                                                          travelDetailViewModel!
                                                              .getGenderIcon(passenger
                                                                  .selectedSeats[
                                                                      mainIndex]
                                                                  .gender!),
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              mainAssignVM.isTwoWay == true
                                                  ? Flexible(
                                                      flex: 4,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color:
                                                                colorPrimaryGrey),
                                                        child: Text(
                                                          passenger
                                                              .selectedSeatsReturn[
                                                                  mainIndex]
                                                              .seatNumber
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: const TextStyle(
                                                            color: colorPrimary,
                                                            fontSize:
                                                                textFontSizeTitle,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    PopupMenuButton<
                                                        PassengerArgs>(
                                                      elevation: 1,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              const BoxShadow(
                                                                  color: Colors
                                                                      .black12,
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius:
                                                                      10)
                                                            ]),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              decoration: BoxDecoration(
                                                                  color: colorPrimary
                                                                      .withOpacity(
                                                                          0.2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: const Icon(
                                                                Icons.group,
                                                                color:
                                                                    colorPrimary,
                                                                size: 25,
                                                              ),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            const Text(
                                                              'مسافرین منتخب',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorTextPrimary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      color: Colors.white
                                                          .withOpacity(1.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      onSelected: (newValue) {
                                                        passenger
                                                            .setSelectedSeatByIndex(
                                                                newValue,
                                                                mainIndex);
                                                      },
                                                      itemBuilder: (context) {
                                                        return List.generate(
                                                            passenger
                                                                .passengerArgs
                                                                .length,
                                                            (int index) {
                                                          return PopupMenuItem<
                                                                  PassengerArgs>(
                                                              value: passenger
                                                                      .passengerArgs[
                                                                  index],
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      "${passenger.passengerArgs[index].name} ${passenger.passengerArgs[index].lastName}",
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              colorTextTitle,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              fontSizeMedTitle),
                                                                    ),
                                                                    Text(
                                                                      "${passenger.passengerArgs[index].nationalCode}",
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              colorTextSub,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontSize:
                                                                              fontSizeSubTitle),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          const Divider(),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 2,
                                                  ),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              right: 8,
                                                              top: 8,
                                                              bottom: 4),
                                                      icon: Container(
                                                        padding:
                                                            const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            color: colorPrimary
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: const Icon(
                                                          Icons.person,
                                                          color: colorPrimary,
                                                        ),
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      labelText: 'نام',
                                                      labelStyle: const TextStyle(
                                                          color: colorTextSub),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    cursorColor: colorPrimary,
                                                    controller: passenger
                                                            .nameControllerList[
                                                        mainIndex],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: TextFormField(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(
                                                    left: 4,
                                                    right: 8,
                                                    top: 8,
                                                    bottom: 4),
                                                icon: Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: colorPrimary
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: colorPrimary,
                                                  ),
                                                ),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                labelText: 'نام خانوادگی',
                                                labelStyle: const TextStyle(
                                                    color: colorTextSub2),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                    color: colorPrimary,
                                                  ),
                                                ),
                                              ),
                                              keyboardType: TextInputType.text,
                                              cursorColor: colorPrimary,
                                              controller: passenger
                                                      .lastNameControllerList[
                                                  mainIndex],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.only(
                                                    left: 4,
                                                    right: 8,
                                                    top: 8,
                                                    bottom: 4),
                                                icon: Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: colorPrimary
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Icon(
                                                    Icons.person,
                                                    color: colorPrimary,
                                                  ),
                                                ),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                labelText: 'کد ملی',
                                                labelStyle: const TextStyle(
                                                    color: colorTextSub2),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: const BorderSide(
                                                    color: colorPrimary,
                                                  ),
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: colorPrimary,
                                              controller: passenger
                                                      .nationalCodeControllerList[
                                                  mainIndex],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }))),
                      Consumer<GeneratedTicketViewModel>(
                        builder: (_, generatedTicketVM, __) => InkWell(
                          onTap: () async {
                            if (mainAssignVM.isAllFilled()) {
                              if (mainAssignVM.isAllUnique()) {
                                generatedTicketVM.setTicketId(
                                    travelDetailViewModel!.ticketId);
                                generatedTicketVM.setSeatList(
                                    passengersViewModel!.selectedSeats);
                                generatedTicketVM.setBasePrice(
                                    travelDetailViewModel!
                                        .travelDetailArgsNew.basePrice!);
                                bool go =
                                    await mainAssignVM.setSelectedSeats(_);

                                bool goT = true;
                                if (mainAssignVM.isTwoWay) {
                                  generatedTicketVM.setTicketIdReturn(
                                      travelDetailViewModel!.ticketIdReturn);
                                  generatedTicketVM.setSeatListReturn(
                                      passengersViewModel!.selectedSeatsReturn);
                                  goT =
                                      mainAssignVM.checkSelectedSeatsReturn(_);
                                }

                                generatedTicketVM.setOrderId(travelDetailViewModel!.invoiceArgs.orderId!);

                                if (go && goT) {
                                  Navigator.pushNamed(
                                      context, '/GeneratedTicketsView');
                                }
                              } else {
                                showInfoFlushbar(
                                    context,
                                    'دو مسافر نمی‌تواند کد ملی یکسان داشته باشند',
                                    ' ',
                                    false,
                                    durationSec: 3);
                              }
                            } else {
                              showInfoFlushbar(
                                  context,
                                  'اطلاعات مسافران را کامل وارد کنید',
                                  ' ',
                                  false,
                                  durationSec: 3);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: colorTextWhite,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'تأیید اطلاعات مسافران',
                                  style: const TextStyle(
                                      color: colorTextWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
