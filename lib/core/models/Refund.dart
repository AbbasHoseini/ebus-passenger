import 'dart:convert';

class Refund {
  int? id, status, travelTicketId;
  String? subject, description, phone, date;

  Refund({
    this.id,
    this.status,
    this.subject,
    this.description,
    this.travelTicketId,
    this.phone,
    this.date,
  });

  Refund copyWith({
    int? id, status, travelTicketId,
    String? subject, description, phone, data,
  }) {
    return Refund(
      id: id ?? this.id,
      status: status ?? this.status,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      travelTicketId: travelTicketId ?? this.travelTicketId,
      phone: phone ?? this.phone,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'subject': subject,
      'description': description,
      'travelTicketId': travelTicketId,
      'phone': phone,
      'date': date,
    };
  }

  factory Refund.fromMap(map) {
    return Refund(
      id: map['id'],
      status: map['status'],
      subject: map['subject'],
      description: map['description'],
      travelTicketId: map['travelTicketId'],
      phone: map['phone'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Refund.fromJson(source) => Refund.fromMap(source);

  @override
  String toString() {
    return 'Refund(id: $id, status: $status, subject: $subject, description: $description, travelTicketId: $travelTicketId, phone: $phone, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Refund &&
        other.id == id &&
        other.status == status &&
        other.subject == subject &&
        other.description == description &&
        other.travelTicketId == travelTicketId &&
        other.phone == phone &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        subject.hashCode ^
        description.hashCode ^
        travelTicketId.hashCode ^
        phone.hashCode ^
        date.hashCode;
  }
}
