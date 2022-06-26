import 'dart:math';

import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';

class FestivalsList extends StatelessWidget {
  final List<Festival>? festivals;

  const FestivalsList({Key? key, this.festivals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.festivals!.length,
      itemBuilder: (context, index) {
        final festival = this.festivals![index];

        return makeCard(context, festival);
      },
    );
  }

  Widget makeCard(BuildContext context, Festival festival) {
    return 
    // AnimationHandler().translateFromRight(
      ClipRRect(
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(50),
        //     topRight: Radius.circular(50),
        //     bottomLeft: Radius.circular(50),
        //     bottomRight: Radius.circular(50)),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/FestivalDetailView', arguments: festival);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                      ),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: festival.id.toString() + "image",
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(festival.images[0]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0, right: 24, top: 0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 4),
                              Hero(
                                tag: festival.id.toString() + "title",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    festival.festivalTitle!,
                                    style: TextStyle(
                                        color: colorTextPrimary,
                                        fontSize: fontSizeTitle + 3),
                                  ),
                                ),
                              ),
                              Container(
                                // padding:
                                //     EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      convertTojalali(festival.startDate!),
                                      style: TextStyle(
                                          color: colorTextPrimary,
                                          fontSize: fontSizeSubTitle),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'تا',
                                      style: TextStyle(
                                          color: colorTextPrimary,
                                          fontSize: fontSizeTitle),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      convertTojalali(festival.endDate!),
                                      style: TextStyle(
                                          color: colorTextPrimary,
                                          fontSize: fontSizeSubTitle),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8)
                            ],
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              print("buy ticket for festival");
                              Navigator.of(context).pushNamed(
                                  '/FestivalTownView',
                                  arguments: festival);
                            },
                            child: Hero(
                              tag: festival.id.toString() + "buy",
                              child: Material(
                                color: Colors.transparent,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: colorPrimary,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            spreadRadius: 1)
                                      ],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 0),
                                    child: Row(
                                      children: const <Widget>[
                                        Text(
                                          'خرید بلیط',
                                          style: TextStyle(
                                              color: colorTextWhite,
                                              fontSize: fontSizeTitle),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: colorTextWhite,
                                        )
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
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorPrimary.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1)
                        ]),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(
                      '${festival.discountValue} درصد تخفیف',
                      style: TextStyle(
                          color: colorTextWhite, fontSize: fontSizeTitle),
                    ),
                  ),
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
