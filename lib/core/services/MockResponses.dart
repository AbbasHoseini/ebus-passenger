import 'dart:io';

import 'package:http/http.dart' as http;

http.Response correctMobileLoginResponse = http.Response(
    '''
{
    "message": "Verification Code Sent ",
    "codeExpireTime": "2021-07-11 07:17:29",
    "status": 200
}
''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response wrongMobileLoginResponse = http.Response(
    '''
{
    "message": "User Not found.",
    "status": 404
}
''',
    404,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response correctSignInFastResponse = http.Response(
    '''
{
    "status": 200,
    "id": 10,
    "userName": "",
    "firstName": "آرش",
    "lastName": "محمدی",
    "nationalCode": "1234567897",
    "email": "",
    "roles": [],
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
}
''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response wrongSignInFastResponse = http.Response(
    '''
{
    "Message": "Verification Code Is Expired."
}
''',
    404,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response wrongSignUpResponse = http.Response(
    '''
    {
    "message": "user already exists with this phone!",
    "status": 403
}''',
    403,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response correctSignUpResponse = http.Response(
    '''{
    "message": "کد فعال سازی ارسال شد",
    "status": 200,
    "data": {
        "codeExpireTime": "2021-07-11 08:52:07"
    }
}''',
    201,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response correctUserVerificationResponse = http.Response(
    '''{
    "Status": 200,
    "message": "کاربر با موفقیت اهراز هویت شد",
    "data": {
        "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzksImlhdCI6MTYyNTk4NjU1OCwiZXhwIjoxNjI2MDcyOTU4fQ.DKrLkC6Y6bzQwPI_8IaaU3qtH1LjJhKSUEr_m1LcbU0",
        "id": 39
    }
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response wrongUserVerificationResponse = http.Response(
    '''{
    "message": "کد تایید معتبر نمیباشد",
    "status": 404
}''',
    404,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response noCurrentTravelResponse = http.Response(
    '''{
    "data": []
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response currentTravelResponse = http.Response(
    '''{
    "data": []
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctAllTownShipResponse = http.Response(
    '''{
    "data": [
        {
            "id": 1,
            "title": "زنجان",
            "lat": 36.683,
            "lon": 48.5087,
            "isActive": 1,
            "isCapital": 1,
            "createdAt": "2021-05-10T11:45:22.399Z",
            "updatedAt": "2021-05-10T11:45:22.399Z",
            "provinceId": 1
        },
        {
            "id": 2,
            "title": "ابهر",
            "lat": 36.1525,
            "lon": 49.2385,
            "isActive": 1,
            "isCapital": 0,
            "createdAt": "2021-05-10T11:45:37.394Z",
            "updatedAt": "2021-05-10T11:45:37.394Z",
            "provinceId": 1
        },
        {
            "id": 3,
            "title": "قزوین",
            "lat": 36.2737,
            "lon": 49.9982,
            "isActive": 1,
            "isCapital": 1,
            "createdAt": "2021-05-10T11:45:44.806Z",
            "updatedAt": "2021-05-10T11:45:44.806Z",
            "provinceId": 2
        },
        {
            "id": 4,
            "title": "کرج",
            "lat": 35.84,
            "lon": 50.9391,
            "isActive": 1,
            "isCapital": 1,
            "createdAt": "2021-05-10T11:45:59.529Z",
            "updatedAt": "2021-05-10T11:45:59.529Z",
            "provinceId": 3
        },
        {
            "id": 5,
            "title": "تهران",
            "lat": 35.6892,
            "lon": 51.389,
            "isActive": 1,
            "isCapital": 1,
            "createdAt": "2021-05-10T11:46:12.924Z",
            "updatedAt": "2021-05-10T11:46:12.924Z",
            "provinceId": 4
        }
    ],
    "status": 200
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response correctSearchResultResponse = http.Response(
    '''{
    "Status": 200,
    "Data": [
        {
            "travelId": 26,
            "sourceTownshipId": 1,
            "destTownshipId": 5,
            "travelDate": "2021-07-15",
            "departureDatetime": "2021-07-15T16:00:00.000Z",
            "emptySeatCount": 20,
            "id": 26,
            "basePrice": "60000",
            "carTypeTitle": "VIP",
            "durationOverDistance": 240,
            "isMidway": false,
            "ridingTime": "2021-07-15T16:00:00.000Z",
            "arrivedTime": "2021-07-15T20:00:00.000Z",
            "directionSourceTitle": "زنجان",
            "directionDestTitle": "تهران"
        }
    ]
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response noTravelsSearchResultResponse = http.Response(
    '''{
    "Status": 200,
    "Data": []
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctTravelDetailsResponse = http.Response(
    '''{
    "Data": {
        "DirectionInfo": {
            "directionId": 2,
            "departureDatetime": "2021-07-15T16:00:00.000Z",
            "directionSourceTitle": "زنجان",
            "directionDestTitle": "تهران"
        },
        "FullSeats": [
            {
                "seatNumber": 25,
                "genderId": 1
            },
            {
                "seatNumber": 6,
                "genderId": 1
            },
            {
                "seatNumber": 12,
                "genderId": 0
            },
            {
                "seatNumber": 13,
                "genderId": 1
            },
            {
                "seatNumber": 1,
                "genderId": 1
            }
        ],
        "CarInfo": {
            "Car": {
                "seatCount": 25,
                "seatRowCount": 10,
                "seatColumnCount": 4,
                "id": 1
            },
            "Schema": [
                {
                    "id": 1,
                    "rowId": 0,
                    "columnId": 0,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 1
                },
                {
                    "id": 2,
                    "rowId": 0,
                    "columnId": 1,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 4,
                    "rowId": 0,
                    "columnId": 3,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 4
                },
                {
                    "id": 3,
                    "rowId": 0,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 6,
                    "rowId": 1,
                    "columnId": 1,
                    "seatNumber": 2,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 7,
                    "rowId": 1,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 8,
                    "rowId": 1,
                    "columnId": 3,
                    "seatNumber": 3,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 5,
                    "rowId": 1,
                    "columnId": 0,
                    "seatNumber": 1,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 10,
                    "rowId": 2,
                    "columnId": 1,
                    "seatNumber": 5,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 11,
                    "rowId": 2,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 12,
                    "rowId": 2,
                    "columnId": 3,
                    "seatNumber": 6,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 9,
                    "rowId": 2,
                    "columnId": 0,
                    "seatNumber": 4,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 14,
                    "rowId": 3,
                    "columnId": 1,
                    "seatNumber": 8,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 15,
                    "rowId": 3,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 16,
                    "rowId": 3,
                    "columnId": 3,
                    "seatNumber": 9,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 13,
                    "rowId": 3,
                    "columnId": 0,
                    "seatNumber": 7,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 1,
                    "carLocationTypeId": 3
                },
                {
                    "id": 18,
                    "rowId": 4,
                    "columnId": 1,
                    "seatNumber": 11,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 19,
                    "rowId": 4,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 20,
                    "rowId": 4,
                    "columnId": 3,
                    "seatNumber": 12,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 17,
                    "rowId": 4,
                    "columnId": 0,
                    "seatNumber": 10,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 21,
                    "rowId": 5,
                    "columnId": 0,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 1
                },
                {
                    "id": 23,
                    "rowId": 5,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 22,
                    "rowId": 5,
                    "columnId": 1,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 24,
                    "rowId": 5,
                    "columnId": 3,
                    "seatNumber": 13,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 27,
                    "rowId": 6,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 25,
                    "rowId": 6,
                    "columnId": 0,
                    "seatNumber": 14,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 26,
                    "rowId": 6,
                    "columnId": 1,
                    "seatNumber": 15,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 28,
                    "rowId": 6,
                    "columnId": 3,
                    "seatNumber": 16,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 31,
                    "rowId": 7,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 29,
                    "rowId": 7,
                    "columnId": 0,
                    "seatNumber": 17,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 32,
                    "rowId": 7,
                    "columnId": 3,
                    "seatNumber": 19,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 30,
                    "rowId": 7,
                    "columnId": 1,
                    "seatNumber": 18,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 33,
                    "rowId": 8,
                    "columnId": 0,
                    "seatNumber": 20,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 36,
                    "rowId": 8,
                    "columnId": 3,
                    "seatNumber": 22,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 35,
                    "rowId": 8,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 34,
                    "rowId": 8,
                    "columnId": 1,
                    "seatNumber": 21,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 2,
                    "carLocationTypeId": 3
                },
                {
                    "id": 40,
                    "rowId": 9,
                    "columnId": 3,
                    "seatNumber": 25,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 38,
                    "rowId": 9,
                    "columnId": 1,
                    "seatNumber": 24,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                },
                {
                    "id": 39,
                    "rowId": 9,
                    "columnId": 2,
                    "seatNumber": null,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": null,
                    "carLocationTypeId": 2
                },
                {
                    "id": 37,
                    "rowId": 9,
                    "columnId": 0,
                    "seatNumber": 23,
                    "createdAt": "2021-02-01T20:30:00.000Z",
                    "updatedAt": "2021-02-01T20:30:00.000Z",
                    "carTypeId": 1,
                    "carSeatId": 3,
                    "carLocationTypeId": 3
                }
            ]
        },
        "RidingTime": "2021-07-15T16:00:00.000Z",
        "TownshipsInfo": {
            "sourceTownshipLat": 36.683,
            "sourceTownshipLon": 48.5087,
            "sourceTownshipTitle": "زنجان",
            "destTownshipLat": 35.6892,
            "destTownshipLon": 51.389,
            "destTownshipTitle": "تهران"
        },
        "TripPrice": [
            {
                "classTitle": "A",
                "classId": 1,
                "seatPrice": 768000
            },
            {
                "classTitle": "B",
                "classId": 2,
                "seatPrice": 546000
            },
            {
                "classTitle": "C",
                "classId": 3,
                "seatPrice": 600000
            }
        ]
    },
    "Status": 200
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

http.Response wrongTravelTicketIdResponse = http.Response(
    '''{
    "Message": "صندلی انتخاب شده در دسترس نمیباشد . لطفا صندلی دیگری را انتخاب کنید",
    "Status": 400
}''',
    400,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctTravelTicketIdResponse = http.Response(
    '''{
    "Message": "بلیط با شماره 350 باموفقیت صادر شد",
    "Data": {
        "TicketId": 350
    },
    "Status": 200
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctTravelTicketInvoiceResponse = http.Response(
    '''{
    "Data": {
        "price": 768000
    }
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response wrongTravelTicketInvoiceResponse = http.Response(
    '''{
    "message": "بلیطی با این شماره یافت نشد"
}''',
    404,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctPayByCreditResultResponse = http.Response(
    '''{
    "message": "مبلغ با موفقیت از حساب شما کسر شد",
    "status": 200
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response noCreditPayByCreditResultResponse = http.Response(
    '''{
    "message": "اعتبار شما کافی نمیباشد",
    "status": 403
}''',
    403,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctPassengersOfFaveListResponse = http.Response(
    '''{
    "Message": "Get All Passangers Successfully",
    "Status": 200,
    "Data": [
        {
            "id": 19,
            "passengerFirstName": "آرش",
            "passengerLastName": "محمدی",
            "passengerFirstNationalCode": "5600040855"
        }
    ]
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctRemovePassengersOfFaveListResponse = http.Response(
    '''{
    "Message": "passenger Was Deleted Successfully",
    "Status": 200
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctAddPassengersToFaveListResponse = http.Response(
    '''{
    "Message": "Favorite Passanger Created Successfully",
    "Status": 201
}''',
    201,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
http.Response correctTicketsInfoResponse = http.Response(
    '''{
    "data": {
        "passengerInfo": [
            {
                "passengerFirstName": "Mahmmod",
                "passengerLastName": "Rezaii",
                "passengerNationalCode": "123456289",
                "seatNumber": 3,
                "genderId": 1
            }
        ],
        "ticketInfo": [
            {
                "userFirstName": "محمود",
                "userLastName": "رضایی",
                "userNationalCode": "1234567897",
                "sourceTitle": "زنجان",
                "destTitle": "تهران",
                "directionTitle": "زنجان - تهران",
                "purchaseTime": "2021-07-12T09:16:28.991Z",
                "departureDatetime": "2021-07-15T16:00:00.000Z",
                "price": 768000,
                "arrivedTime": "2021-06-04T02:00:00.000Z",
                "distance": 380,
                "duration": 240
            }
        ],
        "qrCode": "vq99PXyA"
    }
}''',
    200,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });

///////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
//////////////////////////////
///

String correctTravelsHistoryResultResponse = '{' +
    '    "status": "200",' +
    '     "msg": "Users Travel Reports",' +
    '    "data": [' +
    '      {' +
    '        "id": 500,' +
    '        "source_township": "ابهر",' +
    '        "dest_township": "تهران",' +
    '        "seat_count": 1,' +
    '        "departure_datetime": "2020-07-19T08:00:00",' +
    '        "travel_ticket_price": 0' +
    '      }' +
    '    ]' +
    '}';
String wrongTravelsHistoryResultResponse = '{' +
    '    "status": "404",' +
    '    "msg": "unauthorized",' +
    '    "data": {' +
    '      "data": "-1"' +
    '    }' +
    '}';

String correctTransactionsHistoryResultResponse = '{' +
    '    "status": "200",' +
    '    "msg": "All Transactions",' +
    '    "data": null' +
    '}';

String wrongTransactionsHistoryResultResponse = '{' +
    '    "status": "404",' +
    '    "msg": "unauthorized",' +
    '    "data": {' +
    '      "data": "-1"' +
    '    }' +
    '}';

String correctReportItemTitlesResponse = '{' +
    '    "status": "200",' +
    '"msg": "All SupportItems",' +
    '"data": [' +
    '{' +
    '"id": 4,' +
    '"parent_id": null,' +
    '"title": "مشکلی با راننده داشتم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 1,' +
    '"parent_id": null,' +
    '"title": "بسته ای را در خودرو جا گذاشتم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 2,' +
    '"parent_id": null,' +
    '"title": "مشکلی با سوار شدن داشتم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 5,' +
    '"parent_id": null,' +
    '"title": "مشکلی با خودرو داشتم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 3,' +
    '"parent_id": null,' +
    '"title": "مشکلی با اپلیمیشن دارم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 7,' +
    '"parent_id": null,' +
    '"title": "پشتیبانی",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 6,' +
    '"parent_id": null,' +
    '"title": "مشکلی با هزینه سفر دارم",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 8,' +
    '"parent_id": 2,' +
    '"title": "تفاوت در محل سوار شدن",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 9,' +
    '"parent_id": 2,' +
    '"title": "راننده سفر من را لغو کرد",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 10,' +
    '"parent_id": 2,' +
    '"title": "طولانی شدن زمان انتظار",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 11,' +
    '"parent_id": 2,' +
    '"title": "مسافر دیگری در صندلی من نشسته بود",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 12,' +
    '"parent_id": 2,' +
    '"title": "موارد دیگر",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 13,' +
    '"parent_id": 3,' +
    '"title": "اپلیکیشن خود به خود بسته میشود",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 14,' +
    '"parent_id": 3,' +
    '"title": "موارد دیگر",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 15,' +
    '"parent_id": 3,' +
    '"title": "درخواست سفر ارسال نمیشود",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 16,' +
    '"parent_id": 4,' +
    '"title": "مکالمه زیاد",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 17,' +
    '"parent_id": 4,' +
    '"title": "عدم رعایت نکات ایمنی در رانندگی",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 18,' +
    '"parent_id": 4,' +
    '"title": "چانه زنی ",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 19,' +
    '"parent_id": 4,' +
    '"title": "نظافت راننده",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 20,' +
    '"parent_id": 4,' +
    '"title": "موارد دیگر",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 21,' +
    '"parent_id": 4,' +
    '"title": "عدم استفاده از سیستم گرمایشی / سرمایشی",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 22,' +
    '"parent_id": 4,' +
    '"title": "ادب و حفظ احترام",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '},' +
    '{' +
    '"id": 23,' +
    '"parent_id": 4,' +
    '"title": "نا مناسب بودن صدای ضبط و رادیو",' +
    '"create_time": "2020-06-27T08:24:50.241615"' +
    '}' +
    ']' +
    '}';

String correctSubmitReportResponse = '{' +
    '    "status": "201",' +
    '    "msg": "successful",' +
    '    "data": {' +
    '      "id": "43"' +
    '    }' +
    '}';

String correctUserStaticsResponse = '';

String postNewPassForgetPassResponse = '[' +
    '    {' +
    '        "update_driver_password": {' +
    '            "status": "201",' +
    '            "msg": "successful",' +
    '            "data": {' +
    '                "New Password": 1' +
    '            }' +
    '        }' +
    '    }' +
    ']';

String fetchPassengersResponse = '[' +
    '    {' +
    '        "get_travel_passengers": {' +
    '            "status": "200",' +
    '            "msg": "Travel_details",' +
    '            "data": {' +
    '                "Passengers List": [' +
    '                    {' +
    '                        "travel_ticket_id": 220,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 221,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 222,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 223,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 224,' +
    '                        "seat_number": 7,' +
    '                        "passenger_name": "ali",' +
    '                        "national_code": "1234124545",' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 225,' +
    '                        "seat_number": 15,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 226,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": " نام کاربر",' +
    '                        "national_code": "1234124545",' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 227,' +
    '                        "seat_number": 1,' +
    '                        "passenger_name": "Arash",' +
    '                        "national_code": "123       ",' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 227,' +
    '                        "seat_number": 2,' +
    '                        "passenger_name": "Ali",' +
    '                        "national_code": "1234      ",' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 228,' +
    '                        "seat_number": 23,' +
    '                        "passenger_name": "ali",' +
    '                        "national_code": "1234124545",' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 228,' +
    '                        "seat_number": 24,' +
    '                        "passenger_name": "ali0",' +
    '                        "national_code": "1234124540",' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 229,' +
    '                        "seat_number": 11,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 3,' +
    '                        "source_township_title": "شاندیز",' +
    '                        "dest_township_id": 1,' +
    '                        "dest_township_title": "سنگان"' +
    '                    },' +
    '                    {' +
    '                        "travel_ticket_id": 259,' +
    '                        "seat_number": 5,' +
    '                        "passenger_name": null,' +
    '                        "national_code": null,' +
    '                        "source_township_id": 128,' +
    '                        "source_township_title": "زنجان",' +
    '                        "dest_township_id": 1018,' +
    '                        "dest_township_title": "تهران"' +
    '                    }' +
    '                ]' +
    '            }' +
    '        }' +
    '    }' +
    ']';

String fetchTravelStationsResponse = '[' +
    '    {' +
    '        "get_travel_stations": {' +
    '            "status": "201",' +
    '            "msg": "successfullllllllllllll",' +
    '            "data": [' +
    '                {' +
    '                    "station_id": 1,' +
    '                    "station_title": "پایانه مسافربری زنجان",' +
    '                    "township_id": 128,' +
    '                    "township_title": "زنجان",' +
    '                    "lat": 36.652355,' +
    '                    "lon": 48.571353' +
    '                },' +
    '                {' +
    '                    "station_id": 2,' +
    '                    "station_title": "میدان بسیج",' +
    '                    "township_id": 128,' +
    '                    "township_title": "زنجان",' +
    '                    "lat": 36.6617731,' +
    '                    "lon": 48.497025' +
    '                },' +
    '                {' +
    '                    "station_id": 4,' +
    '                    "station_title": "عوارضی زنجان - قزوین",' +
    '                    "township_id": 128,' +
    '                    "township_title": "زنجان",' +
    '                    "lat": 36.653489,' +
    '                    "lon": 48.570766' +
    '                },' +
    '                {' +
    '                    "station_id": 5,' +
    '                    "station_title": "سلطانیه",' +
    '                    "township_id": 130,' +
    '                    "township_title": "سلطانیه",' +
    '                    "lat": 36.478811,' +
    '                    "lon": 48.846118' +
    '                },' +
    '                {' +
    '                    "station_id": 7,' +
    '                    "station_title": "هیدج",' +
    '                    "township_id": 136,' +
    '                    "township_title": "هیدج",' +
    '                    "lat": 36.278439,' +
    '                    "lon": 49.15255' +
    '                },' +
    '                {' +
    '                    "station_id": 9,' +
    '                    "station_title": "خرمدره",' +
    '                    "township_id": 124,' +
    '                    "township_title": "خرمدره",' +
    '                    "lat": 36.239789,' +
    '                    "lon": 49.22082' +
    '                },' +
    '                {' +
    '                    "station_id": 13,' +
    '                    "station_title": "ابهر",' +
    '                    "township_id": 119,' +
    '                    "township_title": "ابهر",' +
    '                    "lat": 0,' +
    '                    "lon": 0' +
    '                },' +
    '                {' +
    '                    "station_id": 14,' +
    '                    "station_title": "تاکستان",' +
    '                    "township_id": 293,' +
    '                    "township_title": "تاکستان",' +
    '                    "lat": 36.076301,' +
    '                    "lon": 49.677348' +
    '                },' +
    '                {' +
    '                    "station_id": 16,' +
    '                    "station_title": "عوارضی قزوین",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 36.272652,' +
    '                    "lon": 49.935139' +
    '                },' +
    '                {' +
    '                    "station_id": 18,' +
    '                    "station_title": "نظرآباد",' +
    '                    "township_id": 854,' +
    '                    "township_title": "نظرآباد",' +
    '                    "lat": 0,' +
    '                    "lon": 0' +
    '                },' +
    '                {' +
    '                    "station_id": 21,' +
    '                    "station_title": "پل فردیس کرج",' +
    '                    "township_id": 847,' +
    '                    "township_title": "کرج",' +
    '                    "lat": 35.790765,' +
    '                    "lon": 50.999286' +
    '                },' +
    '                {' +
    '                    "station_id": 20,' +
    '                    "station_title": "پایانه مسافربری غرب تهران",' +
    '                    "township_id": 1018,' +
    '                    "township_title": "تهران",' +
    '                    "lat": 0,' +
    '                    "lon": 0' +
    '                },' +
    '                {' +
    '                    "station_id": 30,' +
    '                    "station_title": "دانشگاه بین المللی امام خمینی",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 48.571353,' +
    '                    "lon": 36.652918' +
    '                },' +
    '                {' +
    '                    "station_id": 31,' +
    '                    "station_title": "باراجین",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 50.016739,' +
    '                    "lon": 36.248144' +
    '                },' +
    '                {' +
    '                    "station_id": 32,' +
    '                    "station_title": "عوارضی قزوین - کرج",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 50.119994,' +
    '                    "lon": 36.248144' +
    '                },' +
    '                {' +
    '                    "station_id": 33,' +
    '                    "station_title": "دانشگاه البرز محمدیه",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 50.181321,' +
    '                    "lon": 36.233176' +
    '                },' +
    '                {' +
    '                    "station_id": 34,' +
    '                    "station_title": "محمدیه",' +
    '                    "township_id": 303,' +
    '                    "township_title": "قزوین",' +
    '                    "lat": 50.198435,' +
    '                    "lon": 36.225612' +
    '                },' +
    '                {' +
    '                    "station_id": 35,' +
    '                    "station_title": "آبیک",' +
    '                    "township_id": 289,' +
    '                    "township_title": "آبیک",' +
    '                    "lat": 50.542787,' +
    '                    "lon": 36.048119' +
    '                },' +
    '                {' +
    '                    "station_id": 36,' +
    '                    "station_title": "هشتگرد",' +
    '                    "township_id": 855,' +
    '                    "township_title": "هشتگرد",' +
    '                    "lat": 50.70069,' +
    '                    "lon": 35.970276' +
    '                },' +
    '                {' +
    '                    "station_id": 28,' +
    '                    "station_title": "حصارک",' +
    '                    "township_id": 847,' +
    '                    "township_title": "کرج",' +
    '                    "lat": 50.908804,' +
    '                    "lon": 35.85116' +
    '                },' +
    '                {' +
    '                    "station_id": 27,' +
    '                    "station_title": "مهرشهر",' +
    '                    "township_id": 847,' +
    '                    "township_title": "کرج",' +
    '                    "lat": 50.937672,' +
    '                    "lon": 35.816012' +
    '                },' +
    '                {' +
    '                    "station_id": 37,' +
    '                    "station_title": "پایانه مسافری شهید کلانتری",' +
    '                    "township_id": 847,' +
    '                    "township_title": "کرج",' +
    '                    "lat": 50.968894,' +
    '                    "lon": 35.802347' +
    '                },' +
    '                {' +
    '                    "station_id": 26,' +
    '                    "station_title": "وردآورد",' +
    '                    "township_id": 847,' +
    '                    "township_title": "کرج",' +
    '                    "lat": 51.143305,' +
    '                    "lon": 35.744294' +
    '                }' +
    '            ]' +
    '        }' +
    '    }' +
    ']';
String getDriverResponse = '[ ' +
    '    { ' +
    '        "get_driver_profile": { ' +
    '            "status": "200", ' +
    '            "msg": "Driver Information", ' +
    '            "data": [ ' +
    '                { ' +
    '                    "id": 4, ' +
    '                    "first_name": "ali", ' +
    '                    "last_name": "mohammadi", ' +
    '                    "father_name": "hasan", ' +
    '                    "id_no": "12345", ' +
    '                    "national_code": "427348793", ' +
    '                    "birth_date": "1986-12-12", ' +
    '                    "driving_licence_number": null, ' +
    '                    "driving_licence_expire_date": null, ' +
    '                    "smart_cart_number": null, ' +
    '                    "smart_cart_expire_date": null, ' +
    '                    "is_active": true, ' +
    '                    "mobile": "09124532833", ' +
    '                    "tell": "02433765432", ' +
    '                    "township_id": 128, ' +
    '                    "address": null, ' +
    '                    "postal_code": "1234567890", ' +
    '                    "image_url": null, ' +
    '                    "remember_token": "add0a5e800b77713d4c9abbf5fbebade", ' +
    '                    "token_expire": "2020-06-29T11:36:16.493897", ' +
    '                    "verify_code": "198461", ' +
    '                    "verify_code_expire_time": "2020-06-25T05:10:54.572126", ' +
    '                    "user_name": "driver1", ' +
    '                    "password": "1", ' +
    '                    "email": null, ' +
    '                    "status": 1, ' +
    '                    "create_time": "2020-06-27T08:22:37.136896" ' +
    '                } ' +
    '            ] ' +
    '        } ' +
    '    } ' +
    ']';

String driverChangePasssword = '[' +
    '    {' +
    '        "change_driver_password": {' +
    '            "status": "201",' +
    '            "msg": "successful",' +
    '            "data": {' +
    '                "New Password": 1' +
    '            }' +
    '        }' +
    '    }' +
    ']';

String messagesFromAdmin = '[' +
    '    {' +
    '        "get_messages": {' +
    '            "status": "200",' +
    '            "msg": "Get Messages",' +
    '            "data": [' +
    '                {' +
    '                    "create_time": "2020-06-27T08:23:19.044487",' +
    '                    "message_id": 7,' +
    '                    "ins_time_stamp": "2020-06-22T12:18:44.72973",' +
    '                    "message_text": "سلام",' +
    '                    "sender_id": 4,' +
    '                    "sender_type_id": 5,' +
    '                    "is_read": false' +
    '                },' +
    '                {' +
    '                    "create_time": "2020-06-27T08:23:19.044487",' +
    '                    "message_id": 7,' +
    '                    "ins_time_stamp": "2020-06-23T12:18:44.72973",' +
    '                    "message_text": "سفر 22012 لغو شده است!",' +
    '                    "sender_id": 4,' +
    '                    "sender_type_id": 5,' +
    '                    "is_read": false' +
    '                }' +
    '            ]' +
    '        }' +
    '    }' +
    ']';

String correctGetDriverTrips = '[' +
    '{' +
    '"get_driver_trips": {' +
    '"status": "200",' +
    '"msg": "Active Travel",' +
    '"data": [' +
    '{' +
    '"id": 1,' +
    '"departure_datetime": "2020-05-09T15:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '},' +
    '{' +
    '"id": 3,' +
    '"departure_datetime": "2020-05-09T00:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '},' +
    '{' +
    '"id": 5,' +
    '"departure_datetime": "2020-05-09T00:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '}' +
    ']' +
    '}' +
    '}' +
    ']';

String wrongGetDriverTrips = '[' +
    '{' +
    '"get_driver_trips": {' +
    '"status": "404",' +
    '"msg": "Active Travel",' +
    '"data": [' +
    '{' +
    '"id": 1,' +
    '"departure_datetime": "2020-05-09T15:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '},' +
    '{' +
    '"id": 3,' +
    '"departure_datetime": "2020-05-09T00:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '},' +
    '{' +
    '"id": 5,' +
    '"departure_datetime": "2020-05-09T00:00:00",' +
    '"direction_id": 1,' +
    '"direction_title": "زنجان - تهران",' +
    '"distance": 330' +
    '}' +
    ']' +
    '}' +
    '}' +
    ']';

String readyToCheckInResponse = '{' +
    '    "status": "200",' +
    '    "msg": "Status Updat Successfully ",' +
    '    "data": {' +
    '        "travel_id": 5,' +
    '        "travel_status_id": 2' +
    '    }' +
    '}';

String getFestivalsResponse = '[' +
    '    {' +
    '        "get_festivals": {' +
    '            "status": "200",' +
    '            "msg": "All Festivals",' +
    '            "data": [' +
    '                {' +
    '                    "id": 1,' +
    '                    "status": true,' +
    '                    "festival_township_id": 128,' +
    '                    "festival_title": "سفر به هر کجا",' +
    '                    "festival_description": "ارزانتر از همیشه",' +
    '                    "start_date": "2020-09-06T00:00:00",' +
    '                    "end_date": "2020-10-06T00:00:00",' +
    '                    "title": "زنجان",' +
    '                    "images": ["images/localizacao.png"],' +
    '                    "discount_value": 5' +
    '                },' +
    '                {' +
    '                    "id": 2,' +
    '                    "status": true,' +
    '                    "festival_township_id": 128,' +
    '                    "festival_title": "سفر به سلامت",' +
    '                    "festival_description": "توصیه های بهداشتی برای سفری سالم",' +
    '                    "start_date": "2020-09-06T00:00:00",' +
    '                    "end_date": "2020-10-06T00:00:00",' +
    '                    "title": "زنجان",' +
    '                    "images": ["images/Mask.png"],' +
    '                    "discount_value": 5' +
    '                },' +
    '                {' +
    '                    "id": 3,' +
    '                    "status": true,' +
    '                    "festival_township_id": 806,' +
    '                    "festival_title": "اولین سفرت تخفیف بگیر",' +
    '                    "festival_description": "تخفیف های متنوع و ویژه برای اولین سفرتان",' +
    '                    "start_date": "2020-09-01T00:00:00",' +
    '                    "end_date": "2020-10-29T00:00:00",' +
    '                    "title": "کاشان",' +
    '                    "images": ["images/3d-off.png"],' +
    '                    "discount_value": 10' +
    '                }' +
    '            ]' +
    '        }' +
    '    }' +
    ']';

String getFestivalTownsResponse = '[' +
    '    {' +
    '        "get_festival_travels": {' +
    '            "status": "200",' +
    '            "msg": "All Festival Travels",' +
    '            "data": [' +
    '                {' +
    '                    "id": 1,' +
    '                    "title": true,' +
    '                    "count_of_travel": 5' +
    '                },' +
    '                {' +
    '                    "id": 15,' +
    '                    "title": "زنجان",' +
    '                    "count_of_travel": 6' +
    '                }' +
    '            ]' +
    '        }' +
    '    }' +
    ']';

String getCreditResponse = '''{
    "credit": 9696000
}''';
