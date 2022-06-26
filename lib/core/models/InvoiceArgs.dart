import 'package:latlong2/latlong.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'Seat.dart';

class InvoiceArgs {
  int? ticketId,
      ticketIdReturn,
      invoiceTotal,
      discountAmount,
      amount,
      returnAmount,
      orderId;
  String? destinationName, sourceName, fullName, todayDate;
  LatLng? sourcePoint;
  LatLng? destinationPoint;

  List<Seat>? seats;

  InvoiceArgs(
      {this.invoiceTotal,
      this.discountAmount,
      this.destinationPoint,
      this.sourcePoint,
      this.ticketId,
      this.ticketIdReturn,
      this.destinationName,
      this.orderId,
      this.sourceName,
      this.amount,
      this.todayDate,
      this.fullName,
      this.seats,
      this.returnAmount});
}
