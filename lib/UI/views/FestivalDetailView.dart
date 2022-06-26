import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/viewmodels/FestivalDetailViewModel.dart';
import 'package:ebus/helpers/AnimationHandler.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FestivalDetailView extends StatefulWidget {
  final Festival? festival;

  const FestivalDetailView({Key? key, this.festival}) : super(key: key);

  @override
  _FestivalDetailViewState createState() => _FestivalDetailViewState();
}

class _FestivalDetailViewState extends State<FestivalDetailView> {
  FestivalDetailViewModel? festivalDetailViewModel;
  List<dynamic>? images;

  String startDate = " ";
  String endDate = " ";
  int days = 0;

  @override
  void initState() {
    festivalDetailViewModel =
        Provider.of<FestivalDetailViewModel>(context, listen: false);
    images = festivalDetailViewModel!.getImages(widget.festival!);
    print("images length = ${images!.length}");
    startDate = convertTojalali(widget.festival!.startDate!);
    endDate = convertTojalali(widget.festival!.endDate!);
    days = getDays(widget.festival!.startDate!, widget.festival!.endDate!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Hero(
            tag: widget.festival!.id.toString() + "title",
            child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.festival!.festivalTitle!,
                  style: const TextStyle(
                      color: colorTextPrimary,
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.bold),
                ))),
        backgroundColor: colorBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: colorTextPrimary),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Hero(
                      tag: widget.festival!.id.toString() + "image",
                      child: Carousel(
                        autoplayDuration: Duration(seconds: 7),
                        boxFit: BoxFit.cover,
                        dotBgColor: Colors.transparent,
                        dotSize: 6.0,
                        dotIncreaseSize: 1.5,
                        dotIncreasedColor: colorPrimary,
                        dotSpacing: 15.0,
                        dotPosition: DotPosition.bottomCenter,
                        dotVerticalPadding: 25,
                        images: images as List<Widget>,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(top: 215),
                    decoration: BoxDecoration(
                      color: colorBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 24, right: 24, top: 8),
                          child: Row(
                            children: <Widget>[
                              // AnimationHandler().translateFromRight(
                              Text(
                                widget.festival!.festivalTitle!,
                                style: TextStyle(
                                    color: colorTextPrimary,
                                    fontSize: fontSizeTitle + 3),
                              ),
                              //   Curves.easeInOutCubic,
                              //   200,
                              //   duration: 500,
                              // ),
                              Expanded(child: Container()),
                              // AnimationHandler().scalePop(
                              Container(
                                decoration: BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          spreadRadius: 1)
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Text(
                                  '${widget.festival!.discountValue} درصد تخفیف',
                                  style: TextStyle(
                                      color: colorTextWhite,
                                      fontSize: fontSizeTitle),
                                ),
                              ),
                              //   Curves.elasticOut,
                              //   500,
                              //   duration: 1000,
                              // ),
                            ],
                          ),
                        ),
                        // AnimationHandler().translateFromRight(
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                startDate,
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
                                endDate,
                                style: TextStyle(
                                    color: colorTextPrimary,
                                    fontSize: fontSizeSubTitle),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'به مدت',
                                style: TextStyle(
                                    color: colorTextPrimary,
                                    fontSize: fontSizeSubTitle),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '$days روز',
                                style: TextStyle(
                                    color: colorTextPrimary,
                                    fontSize: fontSizeTitle,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        //   Curves.easeInOutCubic,
                        //   200,
                        //   duration: 500,
                        // ),
                        // AnimationHandler().translateFromRight(
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Text(
                            widget.festival!.festivalDescription!,
                            style: TextStyle(
                                color: colorTextPrimary,
                                fontSize: fontSizeMedTitle),
                          ),
                        ),
                        //   Curves.easeInOutCubic,
                        //   200,
                        //   duration: 500,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Hero(
              tag: widget.festival!.id.toString() + "buy",
              child: Material(
                color: Colors.transparent,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: InkWell(
                    onTap: () {
                      print("buy ticket for festival");
                      Navigator.of(context).pushNamed('/FestivalTownView',
                          arguments: widget.festival);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: const BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text(
                            'خرید بلیط',
                            style: TextStyle(
                                color: colorTextWhite,
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: colorTextWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
