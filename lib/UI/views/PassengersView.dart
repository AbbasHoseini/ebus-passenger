import 'package:ebus/UI/widgets/AddPassengerDialog.dart';
import 'package:ebus/UI/widgets/DeletePassengerDialog.dart';
import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PassengersView extends StatefulWidget {
  List<PassengerArgs>? passengersArgs;
  PassengersView({this.passengersArgs});

  @override
  _PassengersViewState createState() => _PassengersViewState();
}

class _PassengersViewState extends State<PassengersView> {
  PassengersViewModel? passengersViewModel;

  @override
  void initState() {
    super.initState();
    passengersViewModel =
        Provider.of<PassengersViewModel>(context, listen: false);
    passengersViewModel!.initPassengersSeat(null, null, context);
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('PassengersView'),
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'مسافران منتخب',
          style: TextStyle(
            color: colorTextPrimary,
            fontSize: fontSizeTitle + 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: colorTextPrimary),
      ),
      floatingActionButton: Consumer<PassengersViewModel>(
          builder: (_, passenger, __) => Container(
                child: FloatingActionButton(
                  key: Key('addPassenger'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AddPassengerDialog());
                  },
                  backgroundColor: colorPrimary,
                  child: Icon(
                    Icons.add,
                    size: 24,
                  ),
                  shape: CircleBorder(),
                ),
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
              key: Key("passengerList"),
              child: Consumer<PassengersViewModel>(
                  builder: (_, passenger, __) => ListView.builder(
                        itemCount: passenger.passengerArgs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              Container(
                                  key: Key(index == 0
                                      ? 'passengerFirst'
                                      : 'passenger${passenger.passengerArgs[index].nationalCode}'),
                                  padding: EdgeInsets.only(
                                      right: 12, left: 12, top: 12, bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: 16, right: 16, top: 8),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(left: 15.0, right: 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Icon(
                                            Icons.person,
                                            color: colorPrimary,
                                            size: 25,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  passenger.passengerArgs[index]
                                                                  .name ==
                                                              null ||
                                                          passenger
                                                                  .passengerArgs[
                                                                      index]
                                                                  .name ==
                                                              " "
                                                      ? " "
                                                      : passenger
                                                          .passengerArgs[index]
                                                          .name,
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: fontSizeTitle,
                                                      color: colorTextPrimary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  passenger.passengerArgs[index]
                                                                  .lastName ==
                                                              null ||
                                                          passenger
                                                                  .passengerArgs[
                                                                      index]
                                                                  .lastName ==
                                                              " "
                                                      ? " "
                                                      : passenger
                                                          .passengerArgs[index]
                                                          .lastName,
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: fontSizeTitle,
                                                      color: colorTextPrimary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              passenger.passengerArgs[index]
                                                              .nationalCode ==
                                                          null ||
                                                      passenger
                                                              .passengerArgs[
                                                                  index]
                                                              .nationalCode ==
                                                          " "
                                                  ? " "
                                                  : passenger
                                                      .passengerArgs[index]
                                                      .nationalCode,
                                              textAlign: TextAlign.right,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontSize: fontSizeMedTitle,
                                                  color: colorTextSub,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        InkWell(
                                            key: Key(index == 0
                                                ? 'passengerFirstDelete'
                                                : 'passengerDelete${passenger.passengerArgs[index].nationalCode}'),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          DeletePassengerDialog(
                                                            id: passenger
                                                                .passengerArgs[
                                                                    index]
                                                                .id,
                                                          ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: colorDanger
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              padding: EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.close,
                                                color: colorDanger,
                                                size: 15,
                                              ),
                                            )),
                                      ],
                                    ),
                                  )),
                            ],
                          );
                        },
                      ))),
        ),
      ),
    );
  }
}
