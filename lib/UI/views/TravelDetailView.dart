import 'package:ebus/core/models/TravelDetailsArgs.dart';
import 'package:ebus/core/viewmodels/TravelDetailViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class TravelDetailView extends StatelessWidget {
  TravelDetailsArgs? travelDetailsArgs;

  TravelDetailView({this.travelDetailsArgs});

  @override
  Widget build(BuildContext context) {
    TravelDetailViewModel travelDetailViewModel =
        Provider.of<TravelDetailViewModel>(context);
    List<Marker> _markersStart = <Marker>[];
    _markersStart.add(Marker(
        point: LatLng(35.6892, 51.3890), builder: (context) => Container()));
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    var columnRows = <Widget>[];

    columnRows = travelDetailViewModel.getSortedListWidget(
        travelDetailsArgs!, myWidth, travelDetailViewModel, true, context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("انتخاب صندلی"),
        backgroundColor: colorPrimary,
      ),
      backgroundColor: colorBackground,
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
                Container(
                  height: myHeight / 2,
                  child: SingleChildScrollView(
                    child: Container(
                      key: Key("seatList"),
                      height: myWidth / 4 * travelDetailsArgs!.rowCount! * 0.7,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: columnRows,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  key: Key("voucher"),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  // focusNode: myFocusNodeEmailLogin,
                  controller: travelDetailViewModel.voucherCodeController,
                  style: const TextStyle(fontSize: 20.0, color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45)),
                    suffixIcon: Icon(
                      Icons.money_off,
                      size: 22.0,
                      color: colorPrimary,
                    ),
                    hintText: myTravelDetailsVoucherCode,
                    hintStyle: TextStyle(fontSize: 13.0, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  myTravelDetailsReservePrice +
                      " ${travelDetailViewModel.priceEstimate(travelDetailsArgs!.basePrice!)} " +
                      "تومان",
                  key: Key('estimatedPrice'),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: colorTextTitle,
                    fontSize: textFontSizeTitle,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    minWidth: MediaQuery.of(context).size.width - 80,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: colorPrimary,
                    child: const Text(
                      myTravelDetailsReserveBtn,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      bool go, go2;
                      go = await travelDetailViewModel.getTicketId(
                          travelDetailsArgs!.sourceId!,
                          travelDetailsArgs!.destinationId!,
                          travelDetailsArgs!.travelId!,
                          context);
                      if (go) {
                        go2 = await travelDetailViewModel
                            .getTicketInvoice(context);
                        print("refresh $go2");
                        if (go2) {
                          Navigator.pushNamed(
                            context,
                            '/InvoiceView',
                            arguments: travelDetailViewModel.invoiceArgs,
                          );
                        }
                      } else {
                        go = await travelDetailsArgs!.resultViewModel!
                            .reserveTicket(
                                travelDetailsArgs!.sourceId!,
                                travelDetailsArgs!.destinationId!,
                                travelDetailsArgs!.travelId!,
                                context);
                        print("refresh2 $go");
                        Navigator.popAndPushNamed(
                          context,
                          '/TravelDetailView',
                          arguments: travelDetailsArgs,
                        );
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
