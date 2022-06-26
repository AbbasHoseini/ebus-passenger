import 'package:ebus/core/models/ResultArgs.dart';
import 'package:ebus/core/viewmodels/FilterViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedRangePrice = RangeValues(0.0, 999.0);
  var selectedRangeTime = RangeValues(0.0, 24.0);

  ResultArgs? resultArgs;
  FilterView({
    this.resultArgs,
  });

  @override
  Widget build(BuildContext context) {
    FilterViewModel filterViewModel = Provider.of<FilterViewModel>(context);
    filterViewModel.setArg(resultArgs!);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(filterTitle),
        backgroundColor: colorPrimary,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          alignment: AlignmentDirectional(0.0, 0.0),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  myFilterPrice,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: colorTextTitle,
                    fontSize: textFontSizeTitle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RangeSlider(
                  key: Key('rangeSlider1'),
                  values: RangeValues(
                      filterViewModel.minPrice, filterViewModel.maxPrice),
                  onChanged: (RangeValues newRange) {
                    filterViewModel.setMinPrice(newRange.start);
                    filterViewModel.setMaxPrice(newRange.end);
                  },
                  divisions: 10000000,
                  min: 0,
                  max: 10000000,
                  labels: RangeLabels('${filterViewModel.minPrice.floor()}',
                      '${filterViewModel.maxPrice.floor()}'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  myMainTime,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: colorTextTitle,
                      fontSize: textFontSizeTitle,),
                ),
                SizedBox(
                  height: 20,
                ),
                RangeSlider(
                  key: Key('rangeSlider2'),
                  values: RangeValues(filterViewModel.departureTime,
                      filterViewModel.arrivalTime),
                  onChanged: (RangeValues newRange) {
                    filterViewModel.setArrivalTime(newRange.end);
                    filterViewModel.setDepartureTime(newRange.start);
                  },
                  divisions: 48,
                  min: 0.0,
                  max: 24.0,
                  labels: RangeLabels(
                      '${filterViewModel.departureTime.floor()}',
                      '${filterViewModel.arrivalTime.floor()}'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  myFilterBusType,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: colorTextTitle,
                      fontSize: textFontSizeTitle,),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: CheckboxListTile(
                          title: Text(myFilterBusVip),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: filterViewModel.vipChecked,
                          onChanged: (bool? val) {
                            filterViewModel.setVipChecked(val!);
                          },
                        ),
                      ),
                      Flexible(
                        child: CheckboxListTile(
                          title: Text(myFilterBusCasual),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: filterViewModel.casualChecked,
                          onChanged: (bool? val) {
                            filterViewModel.setCasualChecked(val!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                    minWidth: MediaQuery.of(context).size.width - 80,
                    color: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      myFilterApplyButton,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold
                          /*fontFamily: "WorkSansBold"*/
                          ),
                    ),
                    //
                    onPressed: () async {
                      Navigator.popAndPushNamed(
                        context,
                        '/ResultView',
                        arguments: filterViewModel.getFilteredList(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
