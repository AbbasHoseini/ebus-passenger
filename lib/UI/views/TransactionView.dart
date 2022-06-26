import 'package:auto_size_text/auto_size_text.dart';
import 'package:ebus/core/models/TransactionArgs.dart';
import 'package:ebus/core/viewmodels/TransactionViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class TransactionView extends StatefulWidget {
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  TransactionViewModel? transactionViewModel;

  @override
  void initState() {
    super.initState();
    transactionViewModel =
        Provider.of<TransactionViewModel>(context, listen: false);
    transactionViewModel!.getTransactionList(context);
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorTextTitle),
        title: const Text(
          'تراکنش‌ها',
          style: TextStyle(
            color: colorTextTitle,
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<TransactionViewModel>(
        builder: (_, viewModel, __) => Stack(
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.ltr,
              child: viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: colorPrimary),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        (viewModel.transactions.length == null ||
                                viewModel.transactions.length < 1)
                            ? Center(
                                child: Text("نتیجه ای یافت نشد"),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    key: Key('listOfTransaction'),
                                    itemCount: viewModel.transactions.length,
                                    itemBuilder: (context, index) {
                                      TransactionArgs transaction =
                                          viewModel.transactions[index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(color: Colors.black12)
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorPrimary
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          child: const Text(
                                                            'ریال',
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: TextStyle(
                                                              color:
                                                                  colorPrimary,
                                                              fontSize:
                                                                  fontSizeTitle,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Expanded(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: AutoSizeText(
                                                              (transaction.amount
                                                                      ??
                                                                  '0').toString(),
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                color:
                                                                    colorTextPrimary,
                                                                fontSize:
                                                                    fontSizeTitle +
                                                                        10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration: BoxDecoration(
                                                              color: colorTextSub2
                                                                  .withOpacity(
                                                                      0.05),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Icon(
                                                            Icons.date_range,
                                                            color: colorTextSub2
                                                                .withOpacity(
                                                                    0.2),
                                                            size: 18,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(
                                                          transaction.date
                                                                 ??
                                                              ' ',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          style: TextStyle(
                                                            color: colorTextSub,
                                                            fontSize:
                                                                fontSizeSubTitle,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: AutoSizeText(
                                                      transaction.title ?? ' ',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      maxLines: 2,
                                                      maxFontSize:
                                                          fontSizeTitle,
                                                      style: TextStyle(
                                                        color: colorTextPrimary,
                                                        // fontSize: fontSizeTitle,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      transaction.type ?? ' ',
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
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: colorPrimary
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                Icons.unfold_more_sharp,
                                                color: colorPrimary,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
