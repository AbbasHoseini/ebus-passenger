import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ebus/core/models/SeatClass.dart';
import 'package:ebus/core/models/TravelDetailsArgs.dart';
import 'package:ebus/core/viewmodels/TravelDetailVieModelNew.dart';
import 'package:flutter/material.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SeatGenderDialog extends Dialog {
  TravelDetailViewModelNew? travelDetailViewModelNew;
  int? index;
  bool? twoWay;
  int? gender;
  SeatClass? seatClass;
  SeatGenderDialog(this.index, this.twoWay, this.seatClass, this.gender);
  var formatter = intl.NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    travelDetailViewModelNew =
        Provider.of<TravelDetailViewModelNew>(context, listen: false);
    return Dialog(
      key: Key('seatGenderDialog'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: colorTextWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
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
                              color: colorPrimary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.attach_money_rounded,
                            color: colorPrimary,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    formatter.format(seatClass!.seatPrice),
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
                    'کلاس',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: fontSizeSubTitle + 5,
                      fontWeight: FontWeight.normal,
                      color: colorTextSub,
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorPrimary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            seatClass!.classTitle!,
                            style: TextStyle(
                              color: colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              // margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                // crossAxisCount: 3,
                // crossAxisSpacing: 5,
                // mainAxisSpacing: 20,
                children: <Widget>[
                  Consumer<TravelDetailViewModelNew>(
                    builder: (_, childVM, __) => InkWell(
                      key: Key('childButton'),
                      onTap: () {
                        if (twoWay!)
                          childVM.setSeatReturn(index!, 2, 2, _);
                        else {
                          if ((childVM.childCount <
                                  (childVM.getChildSeatsCount() + 1)) &&
                              childVM.seats[index!].gender != 2) {
                            showInfoFlushbar(
                                context,
                                "تعداد صندلی کودک نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                "تعداد صندلی کودک نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                false,
                                durationSec: 2);
                          } else {
                            childVM.setSeat(index!, 2, 2, _);
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'کودک',
                              style: TextStyle(
                                  color: colorTextSub,
                                  fontSize: fontSizeTitle + 5,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 32),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorPrimary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.child_care,
                                color: colorPrimary,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Consumer<TravelDetailViewModelNew>(
                    builder: (_, womenVM, __) => InkWell(
                      key: Key('femaleButton'),
                      onTap: () {
                        if (twoWay!)
                          womenVM.setSeatReturn(index!, 0, 2, _);
                        else {
                          print(
                              '1 = ${(womenVM.adultCount <= (womenVM.getAdultSeatCount()))}');
                          print(
                              '2 = ${(womenVM.seats[index!].gender == 0 || womenVM.seats[index!].gender == 1)}');
                          print(
                              'available = ${womenVM.seats[index!].available}');
                          if (womenVM.adultCount <=
                              (womenVM.getAdultSeatCount())) {
                            if (womenVM.seats[index!].available == 2 &&
                                (womenVM.seats[index!].gender == 0 ||
                                    womenVM.seats[index!].gender == 1)) {
                              womenVM.setSeat(index!, 0, 2, _);
                            } else {
                              showInfoFlushbar(
                                  context,
                                  "تعداد صندلی بزرگسال نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                  "تعداد صندلی بزرگسال نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                  false,
                                  durationSec: 2);
                            }
                          } else {
                            womenVM.setSeat(index!, 0, 2, _);
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'زن',
                              style: TextStyle(
                                  color: colorTextSub,
                                  fontSize: fontSizeTitle + 5,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 32),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorPrimary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                MdiIcons.humanFemale,
                                color: colorPrimary,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Consumer<TravelDetailViewModelNew>(
                    builder: (_, manVM, __) => InkWell(
                      key: Key('maleButton'),
                      onTap: () {
                        if (twoWay!)
                          manVM.setSeatReturn(index!, 1, 2, _);
                        else {
                          if (manVM.adultCount <= (manVM.getAdultSeatCount())) {
                            if (manVM.seats[index!].available == 2 &&
                                (manVM.seats[index!].gender == 0 ||
                                    manVM.seats[index!].gender == 1)) {
                              manVM.setSeat(index!, 1, 2, _);
                            } else {
                              showInfoFlushbar(
                                  context,
                                  "تعداد صندلی بزرگسال نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                  "تعداد صندلی بزرگسال نمی‌تواند بیشتر از تعداد جستجو شده باشد",
                                  false,
                                  durationSec: 2);
                            }
                          } else {
                            manVM.setSeat(index!, 1, 2, _);
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'مرد',
                              style: TextStyle(
                                  color: colorTextSub,
                                  fontSize: fontSizeTitle + 5,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 32),
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
                                MdiIcons.humanMale,
                                color: colorPrimary,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
              child: Consumer<TravelDetailViewModelNew>(
                  builder: (_, removeVM, __) => InkWell(
                        key: Key('removeSeatButton'),
                        onTap: () {
                          if (twoWay!)
                            removeVM.setSeatReturn(index!, 0, 1, _);
                          else
                            removeVM.setSeat(index!, 0, 1, _);
                          /*_travelDetailsArgs.seatList[index].gender = 0;
                          _travelDetailsArgs.seatList[index].available = 1;
                          Navigator.popAndPushNamed(
                            context,
                            '/TravelDetailView',
                            arguments: _travelDetailsArgs,
                          );*/
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'حذف صندلی',
                                style: TextStyle(
                                    color: colorTextSub,
                                    fontSize: fontSizeTitle,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 32),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorDanger.withOpacity(0.2),
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
                                  MdiIcons.delete,
                                  color: colorDanger,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
