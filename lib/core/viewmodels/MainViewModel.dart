import 'dart:convert';

import 'package:ebus/UI/widgets/CurrentTravelDialog.dart';
import 'package:ebus/core/models/Bus.dart';
import 'package:ebus/core/models/CurrentTravel.dart';
import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/models/FestivalSearch.dart';
import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/models/TransactionArgs.dart';
import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/core/models/search/GetSearch.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/ShadowText.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ebus/core/models/User.dart';
// import 'package:persian_date/persian_date.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
// import 'package:persian_datepicker/persian_datepicker.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'CurrentTravelViewModel.dart';

class MainViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;

  MainViewModel({this.authServiceType});

  FestivalSearch? _festivalSearch;
  bool _isFestivalSearch = false;

  bool _noFestival = false;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  PersianDatePickerWidget? persianDatePicker;
  PersianDatePickerWidget? persianDatePickerRound;

  User _user = User(name: "", balance: 0);
  bool _loading = false;
  bool _isFestivalsLoaded = false;
  bool _noInternetFestival = false;
  List<Widget> _carouselImages = [];
  var selectedRange = RangeValues(0.0, 24.0);
  var capitalCitiesJson;
  TextEditingController _currentDateController = TextEditingController();
  final TextEditingController _roundTripDateController =
      TextEditingController();

  FocusNode _focusNodeSource = FocusNode();
  FocusNode _focusNodeDestination = FocusNode();
  FocusNode _focusNodeDate = FocusNode();

  FocusNode get focusNodeSource => _focusNodeSource;
  FocusNode get focusNodeDestination => _focusNodeDestination;
  FocusNode get focusNodeDate => _focusNodeDate;

  TextEditingController _sourceController = TextEditingController();

  TextEditingController _destinationController = TextEditingController();
  int _currentQuantity = 1;
  int _childCurrentQuantity = 0;
  int currentYear = 1399;
  int currentMonth = 1;
  int currentDay = 1;
  int currentGregorianYear = 2020;
  int currentGregorianMonth = 1;
  int currentGregorianDay = 1;

  int roundTripYear = 1399;
  int roundTripMonth = 1;
  int roundTripDay = 1;

  String? currentSource;
  String? currentDestination;
  int? currentSourceCode,
      currentDestinationCode,
      currentSourceId,
      currentDestinationId = 0;
  String? _currentDate, _roundTripDate;
  bool _isRoundTrip = false;
  bool _noInternet = false;
  bool get noInternet => _noInternet;
  bool _isFirst = true;
  bool get isFirst => _isFirst;
  set isFirst(bool value) {
    _isFirst = value;
  }

  FestivalSearch? get festivalSearch => _festivalSearch;
  bool get isFestivalSearch => _isFestivalSearch;

  TextEditingController get sourceController => _sourceController;
  TextEditingController get destinationController => _destinationController;

  TextEditingController get currentDateController => _currentDateController;
  TextEditingController get roundTripDateController => _roundTripDateController;

  List<Widget> get carouselImages => _carouselImages;

  bool get isRoundTrip => _isRoundTrip;
  bool get noFestival => _noFestival;

  String get roundTripDate => _roundTripDate!;

  // FestivalSearch get festivalSearch => _festivalSearch;

  List<Bus> busList = <Bus>[];
  List<Bus> busListReturn = <Bus>[];
  List<PassengerArgs>? _passengersArgs;
  List<ReportArgs>? _reportsArgs;
  List<TransactionArgs> _transactionsArgs = <TransactionArgs>[];
  List<TravelHistoryArgs>? _travelHistoryArgs;

  bool get loading => _loading;
  bool get isFestivalsLoaded => _isFestivalsLoaded;
  bool get noInternetFestival => _noInternetFestival;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  CurrentTravelViewModel? currentTravelViewModel;

  Future<bool> getUserCurrentTravel(
      [BuildContext? context, bool? isDrawer]) async {
    currentTravelViewModel = Provider.of<CurrentTravelViewModel>(
        context ?? mainContext!,
        listen: false);
    CurrentTravel? currentTravel =
        await currentTravelViewModel!.getUserCurrentTravel(true);
    print(
        'currentTravelViewModel.isInternetOff = ${currentTravelViewModel!.isInternetOff}');
    if (currentTravelViewModel!.isLoaded &&
        !currentTravelViewModel!.isInternetOff &&
        currentTravel != null &&
        currentTravel.departureDatetime != null) {
      if (isDrawer != null && isDrawer) {
        return true;
      }
      showDialog(
          context: context ?? mainContext!,
          builder: (BuildContext context) => CurrentTravelDialog());
      return true;
    }
    return false;
  }

  setFestivalSearch(FestivalSearch festivalSearch) {
    _festivalSearch = festivalSearch;
    if (_festivalSearch == null) {
      // currentSource = null;
      currentSource = '';
      currentSourceId = 0;
      // currentDestination = null;
      currentDestination = '';
      currentDestinationId = 0;

      print('festivalSearch is null');
      _isFestivalSearch = false;

      persianDatePicker!.update(
        minDatetime: convertTojalali(DateTime.now().toString()),
        maxDatetime:
            convertTojalali(DateTime.now().add(Duration(days: 700)).toString()),
      );
      persianDatePickerRound!.update(
        minDatetime: convertTojalali(DateTime.now().toString()),
        maxDatetime:
            convertTojalali(DateTime.now().add(Duration(days: 700)).toString()),
      );
    } else {
      currentDestination = festivalSearch.festival!.title!;
      currentDestinationCode = festivalSearch.festival!.festivalTownshipId!;
      currentSource = festivalSearch.festivalTown!.name!;
      currentSourceId = festivalSearch.festivalTown!.id!;
      _isFestivalSearch = true;
      print(
          'start date = ${convertTojalali(festivalSearch.festival!.startDate!).toString()}');
      print(
          'end date = ${convertTojalali(festivalSearch.festival!.endDate!).toString()}');
      print('now date = ${convertTojalali(DateTime.now().toString())}');
      persianDatePicker!.update(
        minDatetime:
            convertTojalali(festivalSearch.festival!.startDate!).toString(),
        maxDatetime:
            convertTojalali(festivalSearch.festival!.endDate!).toString(),
      );
      persianDatePickerRound!.update(
        minDatetime:
            convertTojalali(festivalSearch.festival!.startDate!).toString(),
        maxDatetime:
            convertTojalali(festivalSearch.festival!.endDate!).toString(),
      );
    }

    notifyListeners();
  }

  List<TravelHistoryArgs> get travelHistoryArgs => _travelHistoryArgs!;

  set travelHistoryArgs(List<TravelHistoryArgs> value) {
    _travelHistoryArgs = value;
    notifyListeners();
  }

  List<TransactionArgs> get transactionsArgs => _transactionsArgs;

  set transactionsArgs(List<TransactionArgs> value) {
    _transactionsArgs = value;
    notifyListeners();
  }

  String? dateString, dateStringRound;

  BuildContext? mainContext;

  List<int> quantity = <int>[];
  List<String> sourceList = <String>[];
  List<String> destinationList = <String>[];

  List<String> _capitalSourceTownsList = <String>[];
  List<String> _capitalDestinationTownsList = <String>[];
  final List<int> _capitalSourceTownsListID = <int>[];
  final List<int> _capitalDestinationTownsListID = <int>[];
  List<Festival> _festivals = [];

  User get user => _user;

  // set festivalSearch(FestivalSearch festivalSearch) =>
  //     _festivalSearch = festivalSearch;

  set user(User value) {
    _user = value;
  }

  List<String> get getSourceList {
    return sourceList;
  }

  List<String> get getDestinationList {
    return destinationList;
  }

  int getCityIdByName(String name) {
    print('sourceList length:::: ${sourceList.length}');
    for (int i = 0; i < sourceList.length; i++) {
      if (sourceList[i] == name) return i;
    }
    return 0;
  }

  void setCurrentSourceCode(int code) {
    currentSourceCode = code;
    print('check currentSourceCode:: $currentSourceCode');
    notifyListeners();
  }

  void setCurrentDestinationCode(int code) {
    currentDestinationCode = code;
    print('check currentDestinationCode:: $currentDestinationCode');
    notifyListeners();
  }

  setCurrentSourceId(int id) {
    currentSourceId = id;
    notifyListeners();
  }

  setCurrentDestinationId(int id) {
    currentDestinationId = id;
    notifyListeners();
  }

  RangeValues get getRangeValues {
    return selectedRange;
  }

  void setRangeValues(RangeValues rangeValues) {
    selectedRange = rangeValues;
    notifyListeners();
  }

  int get getCurrentQuantity {
    return _currentQuantity;
  }

  void minusOrPlusQnty(bool plus) {
    plus == true ? _currentQuantity++ : _currentQuantity--;
    if (_currentQuantity.isNegative) _currentQuantity = 0;
    notifyListeners();
  }

  void minusOrPlusChildQnty(bool plus) {
    plus == true ? _childCurrentQuantity++ : _childCurrentQuantity--;
    if (_childCurrentQuantity.isNegative) _childCurrentQuantity = 0;
    notifyListeners();
  }

  void setCurrentQuantity(int q) {
    _currentQuantity = q;
    print('currentQuantity = $_currentQuantity');
    notifyListeners();
  }

  int get getCurrentDay {
    return currentDay;
  }

  void setCurrentDay(int day) {
    currentDay = day;
    notifyListeners();
  }

  int get getCurrentMonth {
    // notifyListeners();
    return currentMonth;
  }

  void setCurrentMonth(int month) {
    currentMonth = month;
    notifyListeners();
  }

  int? get getCurrentYear {
    return currentYear;
  }

  void setCurrentYear(int year) {
    currentYear = year;
    notifyListeners();
  }

  void setCurrentSource(String ss) {
    // setcurrentSourceCode(getCityIdByName(ss));
    currentSource = ss;
    notifyListeners();
  }

  void setCurrentDestination(String ss) {
    // setCurrentDestinationCode(getCityIdByName(ss));
    currentDestination = ss;
    notifyListeners();
  }

  String get getCurrentSource {
    return currentSource!;
  }

  String get getCurrentDestination {
    return currentDestination!;
  }

  String get name => _user.name!;
  int get blance => _user.balance!;
  List<Festival> get festivals => _festivals;

  void setBalance(int balance) {
    _user.balance = balance;
  }

  void setName(String name) {
    _user.name = name;
  }

  init(BuildContext context) {
    _noInternet = false;
    print('isFirst = $_isFirst');
    if (!_isFirst) {
      try {
        notifyListeners();
      } catch (e) {
        print('cant notify yet');
      }
    }
    mainContext = context;
    getUserInfo().then((value) {
      List<String> userInfo = value;
      String name = '';
      print('userInfo[0] = ${userInfo[0]}');
      print('userInfo[1] = ${userInfo[1]}');

      name = (userInfo[0] == null
              ? ''
              : userInfo[0] == 'null'
                  ? ''
                  : userInfo[0]) +
          ' ' +
          (userInfo[1] == null
              ? ''
              : userInfo[1] == 'null'
                  ? ''
                  : userInfo[1]);

      _user = User(name: name, balance: int.parse(userInfo[4]));
    });
    print(
        'sssssssssssssssssssssssssssssssssssssssss ${DateTime.now().toString()}');
    print('first ${_currentDateController.text} current${_currentDate} ');
    persianDatePicker = PersianDatePicker(
            onChange: (String oldText, String newText) {
              print('old text $oldText');
              print('new text: $newText');
              Navigator.pop(context);
            },

            // rangeDatePicker: mainViewModel.isRoundTrip,
            rangeDatePicker: false,
            farsiDigits: true,
            fontFamily: "Sans",
            controller: _currentDateController,
            datetime: _currentDate ?? '',
            minDatetime: convertTojalali(DateTime.now().toString()),
            maxDatetime: null)
        .init();
    persianDatePickerRound = PersianDatePicker(
      onChange: (String oldText, String newText) {
        print(oldText);
        print(newText);
        Navigator.pop(context);
      },
      // rangeDatePicker: mainViewModel.isRoundTrip,
      rangeDatePicker: false,
      farsiDigits: true,
      fontFamily: "Sans",
      controller: _roundTripDateController,
      datetime: _currentDate,
      minDatetime: convertTojalali(DateTime.now().toString()),
    ).init();
    // _currentDateController.text = 'انتخاب تاریخ';
    _loading = true;
    setTodayDate();

    getDestinationTownShip().then((result) {
      if (result) {
        _loading = false;
      } else {
        _loading = true;
        _noInternet = true;
      }
      notifyListeners();
    });

    if (_festivals == null || _festivals.length < 1) {
      getFestivals(context, 3);
    }
  }

  Future<bool> getFestivals(BuildContext context, int limit) async {
    var result;
    // if (authServiceType == AuthServiceType.mock) {
    //   result = await MockWebservice().getFestivals(limit);
    // } else {
    //   result = await Webservice().getFestivals(limit);
    // }
    result = await MockWebservice().getFestivals(limit);
    if (result == null) {
      _isFestivalsLoaded = true;
      _noInternetFestival = true;
      notifyListeners();
      return true;
    } else {
      final bodyResponse = jsonDecode(result);
      var statusCode;
      var data;

      try {
        statusCode = bodyResponse["status"];
        data = bodyResponse["data"];
      } catch (e) {
        statusCode = bodyResponse[0]['get_festivals']["status"];
        data = bodyResponse[0]['get_festivals']["data"];
      }

      final Iterable json = data;
      if (json == null) {
        _noFestival = true;
        notifyListeners();
        return false;
      }

      _festivals = json.map((item) => Festival.fromJson(item)).toList();

      _noFestival = false;
      _carouselImages = [];
      print("festivals length = ${_festivals.length}");
      for (Festival festival in _festivals) {
        // for (var image in festival.images) {
        //   _images.add(
        //     NetworkImage(image),
        //   );
        // }
        _carouselImages.add(
          InkWell(
            onTap: () {
              //goToFestivalDetail(context, festival);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        colorGradient2,
                        colorPrimary,
                        colorPrimary,
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: [0.1, 0.6, 0.9],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 5, spreadRadius: 1)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          festival.images == null
                              ? "no image"
                              : festival.images[0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //     // color: colorPrimary,
                            //     borderRadius: BorderRadius.circular(50)),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            child: Material(
                              color: Colors.transparent,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ShadowText(
                                  festival.festivalTitle!,
                                  style: TextStyle(
                                      color: colorTextWhite,
                                      fontSize: fontSizeTitle,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //     // color: colorPrimary,
                            //     borderRadius: BorderRadius.circular(50)),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: Material(
                              color: Colors.transparent,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ShadowText(
                                  festival.festivalDescription!,
                                  style: TextStyle(
                                      color: colorTextWhite,
                                      fontSize: fontSizeSubTitle,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      _isFestivalsLoaded = true;
      _noInternetFestival = false;
      notifyListeners();
      return true;
    }
  }

  void setGregorianDate() {
    print("setGregorianDate");
    print("_currentDateController test = ${_currentDateController.text}");
    try {
      // String s = _currentDateController.text.substring(0, 4);
      // print("s = $s");

      currentYear = int.parse(
          convertNumbers(_currentDateController.text.substring(0, 4)));
    } on Exception catch (e) {
      currentYear = int.parse(_currentDate!.substring(0, 4));
    }
    try {
      currentMonth = int.parse(
          convertNumbers(_currentDateController.text.substring(5, 7)));
    } on Exception catch (e) {
      currentMonth = int.parse(_currentDate!.substring(5, 7));
    }
    try {
      currentDay = int.parse(
          convertNumbers(_currentDateController.text.substring(8, 10)));
      print("day = $currentDay");
    } on Exception catch (e) {
      currentDay = int.parse(_currentDate!.substring(8, 10));
    }
    PersianDate persianDate = PersianDate();
    String month = "$currentMonth", day = "$currentDay";
    if (currentMonth.toString().length < 2) {
      month = "0$currentMonth";
    }
    if (currentDay.toString().length < 2) {
      day = "0$currentDay";
    }
    this.dateString = "$currentYear-$month-$day 19:54";
    print('dateString = $dateString');
    this.dateString = persianDate.jalaliToGregorian(
        currentYear, int.parse(month), int.parse(day), '-');

    this.dateString = convertToYYYYMMDD(dateString!);

    print('dateString YYYYMMDD = $dateString');

    this.dateStringRound = persianDate
        .jalaliToGregorian(currentYear, int.parse(month), int.parse(day), '-')
        .toString();
    // this.dateString = this.dateString.substring(0, 10);
    if (authServiceType == AuthServiceType.mock) {
      this.dateString = "2020-07-19"; //1399/04/29
    }
    print('dateString geregorian converted  = ${this.dateString}');
  }

  void setGregorianDateRound() {
    print("setGregorianDateRound");
    print("_roundTripDateController test = ${_roundTripDateController.text}");
    // var eng= convertNumbers(_roundTripDateController.text);
    // var converted =
    //     PersianDateTime(jalaaliDateTime: eng);
    // var convertedRoundtrip = converted.toGregorian();
    // print("mahmooood convertig = $convertedRoundtrip");

    try {
      // String s = _currentDateController.text.substring(0, 4);
      // print("s = $s");

      roundTripYear = int.parse(
          convertNumbers(_roundTripDateController.text.substring(0, 4)));
    } on Exception catch (e) {
      roundTripYear = int.parse(_roundTripDate!.substring(0, 4));
    }
    try {
      roundTripMonth = int.parse(
          convertNumbers(_roundTripDateController.text.substring(5, 7)));
    } on Exception catch (e) {
      roundTripMonth = int.parse(_roundTripDate!.substring(5, 7));
    }
    try {
      roundTripDay = int.parse(
          convertNumbers(_roundTripDateController.text.substring(8, 10)));
      print("roundTripday = $roundTripDay");
    } on Exception catch (e) {
      roundTripDay = int.parse(_roundTripDate!.substring(8, 10));
    }
    PersianDate persianDateRound = PersianDate();
    String month = "$roundTripMonth", day = "$roundTripDay";
    if (roundTripMonth.toString().length < 2) {
      month = "0$roundTripMonth";
    }
    if (roundTripDay.toString().length < 2) {
      day = "0$roundTripDay";
    }
    this.dateStringRound = "$roundTripYear-$month-$day 19:54";
    print('dateStringRound = $dateStringRound');
    // this.dateStringRound =
    //     persianDateRound.jalaliToGregorian(dateStringRound).toString();
    this.dateStringRound = persianDateRound
        .jalaliToGregorian(roundTripYear, int.parse(month), int.parse(day))
        .toString();

    this.dateStringRound = this.dateStringRound!.substring(0, 10);
    if (authServiceType == AuthServiceType.mock) {
      this.dateStringRound = "2020-07-19"; //1399/04/29
    }
  }

  Future<bool> getResults(BuildContext context) async {
    await setQnty(_currentQuantity + _childCurrentQuantity);

    print('currentSource in getResults ${currentSource}');
    print('current Destination in getResults ${currentDestination}');

    if (currentSource == null || currentDestination == null) {
      showInfoFlushbar(context, "مبدا و مقصد مورد نظر را انتخاب کنید",
          "مبدا و مقصد مورد نظر را انتخاب کنید", false,
          durationSec: 2);
      return false;
    }
    if (_currentDateController.text == null ||
        _currentDateController.text == '') {
      showInfoFlushbar(context, "تاریخ مورد نظر را انتخاب کنید",
          "تاریخ مورد نظر را انتخاب کنید", false,
          durationSec: 2);
      return false;
    }

    notifyListeners();
    // loading = true;
    String token = await getToken();
    setGregorianDate();
    // getCapitalCityID(currentSource, true); //128; //
    // getCapitalCityID(currentDestination, false); //1018; //

    print(
        "sourceAndDestinationIds ${_sourceController.text} $currentDestination $currentDestinationCode");

    print('date for search result = ${this.dateString}');
    var tempDate = getGeorgianDate(1, 1, 1);
    http.Response result;
    var resulRound;
    _isSearching = true;
    notifyListeners();
    print('current source code::: $currentSourceCode');
    print('current destination code::: $currentDestinationCode');
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getSearchResult(
            token, currentSourceCode, currentDestinationCode, this.dateString!);
      } else {
        result = await Webservice().getSearchResult(
            token,
            currentSourceCode,
            // _sourceonCtroller[1].text,
            currentDestinationCode,
            this.dateString!,
            // _festivalSearch == null ? null : _festivalSearch.festival!.id); //this is for old flutter
            _festivalSearch == null
                ? 0
                : _festivalSearch!.festival!
                    .id!); //this is for new flutter v 2.10 -- need to test
      }

      // Round date  resualt
      if (isRoundTrip) {
        await getRoundTrip(token, context);
      }
      _isSearching = false;
      notifyListeners();
    } on Exception catch (e) {
      showInfoFlushbar(context, 'عدم اتصال به سرور', "عدم اتصال به سرور", false,
          durationSec: 2);
      _noInternet = true;
      _isSearching = false;
      notifyListeners();
      return false;
    }

    final bodyResponse = json.decode(result.body);
    var statusCode;
    var data;

    statusCode = result.statusCode;
    data = bodyResponse["data"];

    print(statusCode);
    _loading = false;
    switch (statusCode) {
      case 404:
        showInfoFlushbar(
            context, 'عدم اتصال به سرور', "عدم اتصال به سرور", false,
            durationSec: 3);
        _noInternet = true;
        _isSearching = false;
        notifyListeners();
        return false;
        break;
      case 200:
        var dataList = data as List;
        // if (dataList == null || dataList.length < 1) {
        if (dataList.isEmpty) {
          showInfoFlushbar(context, "بلیطی برا نمایش وجود ندارد",
              "بلیطی برا نمایش وجود ندارد", false,
              durationSec: 3);
          return false;
        }

        busList = dataList.map((item) => Bus.fromJson(item)).toList();
        print("busList length ${busList.length}");
        return true;
        break;
      default:
        showInfoFlushbar(
            context, 'عدم اتصال به سرور', "عدم اتصال به سرور", false,
            durationSec: 3);
        _noInternet = true;
        _isSearching = false;
        notifyListeners();
        return false;
    }
  }

  ////////////////////////////////////
  Future<bool> getRoundTrip(String token, BuildContext context) async {
    setGregorianDateRound();

    setGregorianDateRound();
    print(
        "sourceAndDestinationIds for RoundTrip  $currentSourceCode $currentSource $currentDestinationCode $currentDestination");
    print("dateStringRound  $dateStringRound");

    var result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getSearchResult(token,
            currentDestinationCode, currentSourceCode, this.dateStringRound!);
      } else {
        result = await Webservice().getSearchResult(
            token,
            currentDestinationCode,
            currentSourceCode,
            this.dateStringRound!,
            // _festivalSearch == null ? null : _festivalSearch.festival.id); //old flutter
            _festivalSearch == null
                ? 0
                : _festivalSearch!
                    .festival!.id!); // new flutter -- need to test and check
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    print("getSearchResult for round trip $result ${this.dateStringRound}");

    final bodyResponse = json.decode(result);
    var statusCode;
    var data;

    try {
      statusCode = bodyResponse["status"];
      data = bodyResponse["data"];
    } catch (e) {
      statusCode = bodyResponse[0]['search_travel']["status"];
      data = bodyResponse[0]['search_travel']["data"];
    }
    print(statusCode);
    _loading = false;
    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "404", false, durationSec: 3);
        notifyListeners();
        return false;
        break;
      case "200":
        var dataList = data as List;
        if (dataList == null || dataList.length < 1) {
          showInfoFlushbar(context, "بلیطی برا نمایش وجود ندارد",
              "بلیطی برا نمایش وجود ندارد", false,
              durationSec: 3);
          return false;
        }

        busListReturn = dataList.map((item) => Bus.fromJson(item)).toList();
        print("busListReturn length ${busListReturn.length}");
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 3);
        notifyListeners();
        return false;
    }
  }

  List<PassengerArgs> get passengersArgs => _passengersArgs!;

  set passengersArgs(List<PassengerArgs> value) {
    _passengersArgs = value;
    notifyListeners();
  }

  List<ReportArgs> get reportsArgs => _reportsArgs!;

  set reportsArgs(List<ReportArgs> value) {
    _reportsArgs = value;
    notifyListeners();
  }

  void setCurrentDateController(TextEditingController value) {
    _currentDateController = value;
    notifyListeners();
  }

  void setTodayDate() {
    DateTime now = DateTime.now();
    _currentDate = getShamsiDate(now.toString().substring(0, 10));
    //notifyListeners();
  }

  String get currentDate => _currentDate!;

  void setCurrentDate(String value) {
    _currentDate = value;
    notifyListeners();
  }

  void hideProgressDialog() {
    notifyListeners();
  }

  int get childCurrentQuantity => _childCurrentQuantity;

  void setChildCurrentQuantity(int value) {
    _childCurrentQuantity = value;
    notifyListeners();
  }

  var data;
  Future<bool> getDestinationTownShip() async {
    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getAllTownShip();
      } else {
        result = await Webservice().getAllTShips();
      }
      print("getDestinationTownShip ${result.body}");


      _isFirst = false;
    } on Exception catch (e) {
      print("getDestinationTownShip Exception $e");
      _noInternet = true;
      _isFirst = false;
      notifyListeners();
      return false;
    }

    final bodyResponse = json.decode(result.body);
    var statusCode;

    statusCode = result.statusCode;
    // data = bodyResponse["data"] as List;

    switch (statusCode) {
      case 404:
        return false;
        break;
      case 500:
        return false;
        break;
      case 200:
        insertDataToList(bodyResponse["data"]);
        data = bodyResponse['data'];
        notifyListeners();

        return true;
        break;
      default:
        return false;
    }
  }

  List<Datum>? result;
  Future<List<Datum>> insertDataToList(dataList) async {
    String token = await getToken();
    print('token: $token');
    print('insertDataToList ranned');
    final t = dataList as List;
    result = t.map((json) => Datum.fromJson(json)).toList();
    return result!;
  }

  //   Future<bool> getTownShip() async {
  //   http.Response result;
  //   try {
  //     if (authServiceType == AuthServiceType.mock) {
  //       result = await MockWebservice().getAllTownShip();
  //     } else {
  //       result = await Webservice().getAllTShips();
  //     }
  //     print("getDestinationTownShip $result");

  //     _isFirst = false;
  //   } on Exception catch (e) {
  //     print("getDestinationTownShip Exception $e");
  //     _noInternet = true;
  //     _isFirst = false;
  //     notifyListeners();
  //     return false;
  //   }

  //   final bodyResponse = json.decode(result.body);
  //   var statusCode;
  //   var data;

  //   statusCode = result.statusCode;
  //   data = bodyResponse["data"] as List;

  //   switch (statusCode) {
  //     case 404:
  //       return false;
  //       break;
  //     case 500:
  //       return false;
  //       break;
  //     case 200:
  //       data.map((json) => Datum.fromJson(json)).toList();

  //       return true;
  //       break;
  //     default:
  //       return false;
  //   }
  // }

  // Datum getSearchList = Datum();

  // void getData() async {
  //   getSearchList = await Webservice().getAllTShips();
  //   notifyListeners();
  // }

  List<String> get capitalDestinationTownsList => _capitalDestinationTownsList;

  void setCapitalDestinationTownsList(List<String> value) {
    _capitalDestinationTownsList = value;
    notifyListeners();
  }

  List<String> get capitalSourceTownsList => _capitalSourceTownsList;

  void setCapitalSourceTownsList(List<String> value) {
    _capitalSourceTownsList = value;
    notifyListeners();
  }

  void onSourceTextChanged(String searchedText, items, context) {
    bool isValided = false;
    print(items.length);
    ti:
    for (var item in items) {
      twn:
      for (var i in item.townships) {
        if (searchedText.trimRight().trimLeft() ==
            i.title.trimRight().trimLeft()) {
          setCurrentCapitalSource(searchedText, i.code, i.id);
          isValided = true;
          FocusScope.of(context).requestFocus(FocusNode());
          break twn;
        } else {
          isValided = false;
          // currentSource = null; // old flutter
          currentSource = null; // new flutter - need to check
        }
      }
      if (isValided) break ti;
    }

    if (!isValided) validateSourceField(false, context);
    notifyListeners();
  }

  void validateSourceField(bool isValid, context) {
    if (isValid != true) {
      showInfoFlushbar(context, "خطا \n  مبدا به درستی انتخاب نشده ",
          " به درستی انتخاب نشده ", false,
          durationSec: 2);
      // return false;
    }
    notifyListeners();
  }

  //--------------- Destination ----------------------
  void onDestTextChanged(String searchedText, items, context) {
    bool isValided = false;
    ti:
    for (var item in items) {
      twn:
      for (var i in item.townships) {
        if (searchedText.trimRight() == i.title.trimRight()) {
          setCurrentCapitalDestination(searchedText, i.code, i.id);
          isValided = true;
          FocusScope.of(context).requestFocus(FocusNode());
          break twn;
        } else {
          isValided = false;
          // currentDestination = null; // old flutter
          currentDestination = null; //new flutter
        }
      }
      if (isValided) break ti;
    }
    if (!isValided) validateCapitalField(false, context);
    notifyListeners();
  }

  void validateCapitalField(bool isValid, context) {
    if (isValid != true) {
      showInfoFlushbar(context, "خطا \n  مقصد به درستی انتخاب نشده ",
          "مقصد به درستی انتخاب نشده ", false,
          durationSec: 2);
      // return false;
    }
    notifyListeners();
  }

  void setCurrentCapitalSource(String ss, int code, int id) {
    setCurrentSourceCode(code);
    setCurrentSourceId(id);
    currentSource = ss;
    notifyListeners();
  }

  void setCurrentCapitalDestination(String ss, int code, int id) {
    setCurrentDestinationCode(code);
    setCurrentDestinationId(id);
    currentDestination = ss;
    notifyListeners();
  }

  toggleRoundTrip(value) {
    _isRoundTrip = value;
    print('_isRoundTrip = $_isRoundTrip');
    notifyListeners();
  }

  void reload(BuildContext context) {
    init(context);
  }

  void goToFestivals(BuildContext context) {
    Navigator.of(context).pushNamed('/FestivalsView');
  }

  void goToFestivalDetail(BuildContext context, Festival festival) {
    Navigator.of(context).pushNamed('/FestivalDetailView', arguments: festival);
  }

  String? setGregorianDate2(String date) {
    print("setGregorianDate");
    print("_currentDateController test = $date");
    if (date == null || date == '') return null;

    int currentYear = int.parse(convertNumbers(date.substring(0, 4)));

    int currentMonth = int.parse(convertNumbers(date.substring(5, 7)));

    int currentDay = int.parse(convertNumbers(date.substring(8, 10)));
    print("day = $currentDay");

    PersianDate persianDate = PersianDate();
    String month = "$currentMonth", day = "$currentDay";
    if (currentMonth.toString().length < 2) {
      month = "0$currentMonth";
    }
    if (currentDay.toString().length < 2) {
      day = "0$currentDay";
    }
    String dateString = "$currentYear-$month-$day 19:54";
    print('dateString = $dateString');
    // dateString = persianDate.jalaliToGregorian(dateString).toString();
    dateString = persianDate
        .jalaliToGregorian(currentYear, int.parse(month), int.parse(day), '-')
        .toString();

    print('dateString is ---> $dateString');
    // dateString = dateString.substring(0, 10);
    print('dateString is  sub string---> $dateString');
    if (authServiceType == AuthServiceType.mock) {
      dateString = "2020-07-19"; //1399/04/29
    }

    return dateString;
  }

  bool getTotalQuantity(BuildContext context) {
    if (_currentQuantity < 1) {
      showInfoFlushbar(context, "حداقل یک نفر بزرگسال انتخاب کنید",
          "حداقل یک نفر بزرگسال انتخاب کنید", false,
          durationSec: 2);
      return false;
    } else
      return true;
  }

  String convertToYYYYMMDD(String date) {
    List<String> elements = date.split('-');
    if (elements[1].length < 2) {
      elements[1] = '0' + elements[1];
    }
    if (elements[2].length < 2) {
      elements[2] = '0' + elements[2];
    }

    return elements[0] + '-' + elements[1] + '-' + elements[2];
  }
}
