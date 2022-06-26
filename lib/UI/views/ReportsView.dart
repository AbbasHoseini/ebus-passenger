import 'package:ebus/UI/views/SubmitReportView.dart';
import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/viewmodels/ReportsViewModel.dart';
import 'package:ebus/core/viewmodels/ResultViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ReportsView extends StatefulWidget {
  @override
  _ReportsViewState createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ReportsViewModel? reportsViewModel;
  @override
  void initState() {
    reportsViewModel = Provider.of<ReportsViewModel>(context, listen: false);
    reportsViewModel!.getReportsList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        key: Key('reportsAppBar'),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'گزارشات ثبت شده',
          style: TextStyle(
            color: colorTextTitle,
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
      ),
      body: Consumer<ReportsViewModel>(
        builder: (_, viewModel, __) => Stack(
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    viewModel.isLoading
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : (viewModel.reportArgs.length == null ||
                                viewModel.reportArgs.length < 1)
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    "نتیجه ای یافت نشد",
                                    key: Key('reportNotFound'),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    key: Key('listOfReports'),
                                    itemCount: viewModel.reportArgs.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 10.0),
                                        decoration: BoxDecoration(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  color: Colors.black12,
                                                )
                                              ]),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        viewModel
                                                            .reportArgs[index]
                                                            .reportId
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: colorTextTitle,
                                                          fontSize:
                                                              fontSizeTitle,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      child: Text(
                                                        viewModel
                                                            .reportArgs[index]
                                                            .title!
                                                            .trim(),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          color: colorTextTitle,
                                                          fontSize:
                                                              fontSizeTitle,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        viewModel
                                                            .reportArgs[index]
                                                            .travelDate!,
                                                        style: TextStyle(
                                                          color: colorTextSub2,
                                                          fontSize:
                                                              fontSizeSubTitle,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      child: Text(
                                                        viewModel
                                                            .reportArgs[index]
                                                            .destination!
                                                            .trim(),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          color: colorTextSub,
                                                          fontSize:
                                                              fontSizeSubTitle,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4, right: 4),
                                                      child: Text(
                                                        'به',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          color: colorTextSub,
                                                          fontSize:
                                                              fontSizeSubTitle,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        viewModel
                                                            .reportArgs[index]
                                                            .source!
                                                            .trim(),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          color: colorTextSub,
                                                          fontSize:
                                                              fontSizeTitle,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
