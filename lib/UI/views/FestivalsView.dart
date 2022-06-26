import 'package:ebus/UI/widgets/FestivalsList.dart';
import 'package:ebus/core/viewmodels/FestivalsViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FestivalsView extends StatefulWidget {
  @override
  _FestivalsViewState createState() => _FestivalsViewState();
}

class _FestivalsViewState extends State<FestivalsView> {
  FestivalsViewModel? festivalsViewModel;

  @override
  void initState() {
    festivalsViewModel =
        Provider.of<FestivalsViewModel>(context, listen: false);
    festivalsViewModel!.getFestivals(context, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorTextPrimary),
        title: Text(
          "جشنواره‌ها",
          style: TextStyle(color: colorTextPrimary),
        ),
      ),
      body: Consumer<FestivalsViewModel>(
          builder: (_, festivalsViewModel, __) =>
              festivalsViewModel.noInternetFestival
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
                              festivalsViewModel.reload(context);
                            },
                          )
                        ],
                      ),
                    )
                  : festivalsViewModel.isFestivalsLoaded
                      ? Container(
                          padding: EdgeInsets.only(top: 8),
                          child: FestivalsList(
                            festivals: festivalsViewModel.festivals,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
    );
  }
}
