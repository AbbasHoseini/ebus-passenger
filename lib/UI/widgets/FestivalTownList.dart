import 'dart:math';

import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/models/FestivalSearch.dart';
import 'package:ebus/core/models/FestivalTown.dart';
import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FestivalTownList extends StatelessWidget {
  final List<FestivalTown>? festivalTowns;
  final Festival? festival;

  const FestivalTownList({Key? key, this.festivalTowns, this.festival})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.festivalTowns!.length,
      itemBuilder: (context, index) {
        FestivalTown festivalTown = this.festivalTowns![index];
        print(festivalTown.toString());

        return makeCard(context, festivalTown);
      },
    );
  }

  Widget makeCard(BuildContext context, FestivalTown festivalTown) {
    return 
    // AnimationHandler().translateFromRight(
      ClipRRect(
        child: InkWell(
          onTap: () {
            print('search festival');
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/MainView', (Route<dynamic> route) => false);
            Navigator.of(context).popUntil(ModalRoute.withName("/MainView"));
            MainViewModel mainViewModel =
                Provider.of<MainViewModel>(context, listen: false);
            mainViewModel.setFestivalSearch(
                FestivalSearch(festival: festival, festivalTown: festivalTown));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.directions_bus,
                  color: colorPrimary,
                ),
                SizedBox(width: 16),
                Text(
                  "از",
                  style: TextStyle(
                      color: colorTextSub2,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 8),
                Text(
                  festivalTown.name!,
                  style: TextStyle(
                      color: colorTextPrimary,
                      fontSize: fontSizeTitle + 5,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 32),
                Container(
                  height: 32,
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  festivalTown.count.toString(),
                  style: TextStyle(
                      color: colorTextSub2,
                      fontSize: fontSizeTitle + 5,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 8),
                Text(
                  "سرویس",
                  style: TextStyle(
                      color: colorTextSub2,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.normal),
                ),
                Expanded(child: Container()),
                Text(
                  "انتخاب",
                  style: TextStyle(
                      color: colorFlatButton,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorFlatButton,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      // )
      // ,
      // Curves.easeOutCubic,
      // Random().nextInt(3) * 100.0,
      // duration: 300,
    );
  }
}
