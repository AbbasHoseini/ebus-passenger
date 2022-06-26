import 'package:ebus/core/models/Passenger.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class CurrentPassengerList extends StatelessWidget {
  final List<Passenger>? passengers;

  const CurrentPassengerList({Key? key, this.passengers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: passengers!.length,
      itemBuilder: (context, index) {
        Passenger passenger = passengers![index];
        print("passengers length = ${passengers!.length}");
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            // boxShadow: [
            //   BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 0)
            // ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'نام',
                          style: TextStyle(color: colorTextSub2),
                        ),
                        Text(
                          '${passenger.passengerName} ${passenger.passangerFamily}',
                          style: TextStyle(
                              color: colorTextPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'کد ملی',
                          style: TextStyle(color: colorTextSub2),
                        ),
                        Text(
                          '${passenger.nationalCode}',
                          style: TextStyle(
                              color: colorTextPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'شماره صندلی',
                          style: TextStyle(color: colorTextSub2),
                        ),
                        Text(
                          '${passenger.seatNumber}',
                          style: TextStyle(
                              color: colorTextPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
