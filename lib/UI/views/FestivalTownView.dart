import 'package:ebus/UI/widgets/FestivalTownList.dart';
import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/viewmodels/FestivalTownViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FestivalTownView extends StatefulWidget {
  final Festival? festival;

  const FestivalTownView({this.festival});
  @override
  _FestivalTownViewState createState() => _FestivalTownViewState();
}

class _FestivalTownViewState extends State<FestivalTownView> {
  FestivalTownViewModel? festivalTownViewModel;
  @override
  void initState() {
    print('festival end date = ${widget.festival!.endDate}');

    festivalTownViewModel =
        Provider.of<FestivalTownViewModel>(context, listen: false);
    festivalTownViewModel!.init(context, widget.festival!);
    super.initState();
  }

  @override
  void dispose() {
    festivalTownViewModel!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: colorAccent,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              titleSpacing: 0,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Hero(
                    tag: widget.festival!.id.toString() + "title",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.festival!.festivalTitle!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeTitle,
                        ),
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                background: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Hero(
                        tag: widget.festival!.id.toString() + "image",
                        child: Material(
                          color: Colors.transparent,
                          child: Image(
                            image: NetworkImage(widget.festival!.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 1,
                          child: Container(
                            color: Colors.black12,
                            height: 75,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Consumer<FestivalTownViewModel>(
            builder: (_, festivalTownViewModel, __) =>
                festivalTownViewModel.noInternetFestivalTowns
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'خطا در ارتباط با اینترنت',
                            ),
                            SizedBox(height: 8),
                            RaisedButton(
                              color: colorPrimary,
                              child: Text(
                                'سعی مجدد',
                                style: TextStyle(color: colorTextWhite),
                              ),
                              onPressed: () {
                                festivalTownViewModel.reload(context);
                              },
                            )
                          ],
                        ),
                      )
                    : festivalTownViewModel.isFestivalTownsLoaded
                        ? (festivalTownViewModel.festivalTowns == null ||
                                festivalTownViewModel.festivalTowns.length < 1)
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'برای این جشنواره بلیطی وجود ندارد',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 8),
                                child: FestivalTownList(
                                  festivalTowns:
                                      festivalTownViewModel.festivalTowns,
                                  festival: widget.festival!,
                                ),
                              )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
      ),
    );
  }
}
