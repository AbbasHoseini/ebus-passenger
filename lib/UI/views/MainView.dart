import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebus/UI/widgets/NoInternetWidget.dart';
import 'package:ebus/core/models/FestivalSearch.dart';
import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/models/ResultArgs.dart';
import 'package:ebus/core/viewmodels/CurrentTravelViewModel.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:ebus/UI/widgets/DrawerItem.dart';
import 'package:ebus/UI/widgets/ExitDialog.dart';
import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:dropdownsearch/dropdownsearch.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/Constants.dart';

class MainView extends StatefulWidget {
  final FestivalSearch? festivalSearch;

  const MainView({this.festivalSearch});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainViewModel? mainViewModel;
  GlobalKey<AutoCompleteTextFieldState<String>>? keySource;
  GlobalKey<AutoCompleteTextFieldState<String>>? keyDestination;
  CurrentTravelViewModel? currentTravelViewModel;

  TextEditingController? selectedSearchItem;

  @override
  void initState() {
    mainViewModel = Provider.of<MainViewModel>(context, listen: false);

    // mainViewModel.getData();
    currentTravelViewModel =
        Provider.of<CurrentTravelViewModel>(context, listen: false);

    // final DropDownProvider

    keySource = GlobalKey();
    keyDestination = GlobalKey();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      mainViewModel!.init(context);
      mainViewModel!.getUserCurrentTravel(context);
    });

    super.initState();
  }

  final List<String> _options = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];
  // final Map<String, String> _options = {
  //     'one' : '1',
  //     'tow' : '2',
  //     'three': '3'
  // };پ

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    final mainVMdl = Provider.of<MainViewModel>(context, listen: false);

    return Sizer(builder: (context, orientaion, deviceType) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            key: const Key('mainAppBar'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'ایباس',
              style: TextStyle(
                color: colorTextPrimary,
                fontSize: fontSizeTitle + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: colorTextPrimary),
          ),
          drawer: Drawer(
            key: const Key('drawerButton'),
            child: ListView(
              // Important: Remove any padding from the ListView.
              key: const Key('drawer'),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Consumer<MainViewModel>(
                  builder: (_, user, __) => Container(
                    alignment: Alignment.bottomRight,
                    height: 125,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        // make sure we apply clip it properly
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 8, right: 8),
                            alignment: Alignment.bottomRight,
                            color: Colors.green.withOpacity(0.1),
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                  color: colorTextTitle,
                                  fontSize: fontSizeTitle + 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("images/bus.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      '/WalletView',
                    );
                  },
                  child: drawerItem(
                    title: 'کیف پول',
                    icon: Icons.wallet_travel_rounded,
                  ),
                ),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    key: const Key('myTravelBtn'),
                    child: drawerItem(
                      title: myTravelsTitle,
                      icon: MdiIcons.viewDashboard,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(
                        _,
                        '/MyTravelDashboardView',
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (currentTravelViewModel!.isLoaded &&
                        !currentTravelViewModel!.isInternetOff &&
                        currentTravelViewModel!.currentTravel != null &&
                        currentTravelViewModel!
                                .currentTravel.departureDatetime !=
                            null) {
                      Navigator.of(context).pushNamed("/CurrentTravelView");
                    } else {
                      mainViewModel!.getUserCurrentTravel(context, true);
                      showInfoFlushbar(context, 'شما سفر فعلی ندارید',
                          "لطفا بلیط تهیه فرمایید", false);
                    }
                  },
                  child: drawerItem(
                    title: 'سفر فعلی',
                    icon: Icons.credit_card,
                  ),
                ),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    key: const Key('transactions'),
                    child: drawerItem(
                      title: 'تراکنش‌ها',
                      icon: Icons.restore,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(_, '/TransactionView');
                    },
                  ),
                ),
                const Divider(endIndent: 64),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    key: const Key('faveBtn'),
                    child: drawerItem(
                      title: 'مسافران منتخب',
                      icon: Icons.star_border,
                    ),
                    onTap: () async {
                      Navigator.pushNamed(
                        _,
                        '/PassengersView',
                      );
                    },
                  ),
                ),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    onTap: () async {
                      Navigator.pushNamed(
                        _,
                        '/ProfileView',
                      );
                    },
                    child: drawerItem(
                      title: 'تنظیمات پروفایل',
                      icon: Icons.apps,
                    ),
                  ),
                ),
                const Divider(endIndent: 64),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    key: const Key('reportBtn'),
                    child: drawerItem(
                      title: 'پشتیبانی',
                      icon: Icons.report,
                    ),
                    onTap: () async {
                      List<ReportArgs> reportsArgs;

                      Navigator.pushNamed(_, '/SubmitReportView');
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/AboutUsView');
                  },
                  child: drawerItem(
                    title: 'درباره‌ی ما',
                    icon: Icons.error_outline,
                  ),
                ),
                /*drawerItem(
                  title: 'نمایش دوباره راهنما',
                  icon: Icons.help_outline,
                ),*/
                InkWell(
                  child: drawerItem(
                    title: 'خروج',
                    icon: Icons.exit_to_app,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => ExitDialog()),
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  child: Align(
                    heightFactor: 1,
                    child: Image.asset(
                      'images/bus_schema.png',
                      key: const Key('busSchemaImage'),
                      height: 100,
                      width: myWidth - 32,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height -
                        (AppBar().preferredSize.height),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Consumer<MainViewModel>(
                          builder: (_, mainContainerVM, __) {
                        return mainContainerVM.noInternet
                            ? Container(
                                child: NoInternetWidget(
                                    function: mainViewModel!.init,
                                    context: context),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 0.0, top: 5.0),
                                child: SingleChildScrollView(
                                  key: const Key('mainViewKey'),
                                  child: Consumer<MainViewModel>(
                                    builder: (_, wholeMinVConsumer, __) =>
                                        Container(
                                      // padding: EdgeInsets.symmetric(horizontal: 32),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            height: 180,
                                            child: Consumer<MainViewModel>(
                                              builder: (_, carouselConsumer,
                                                      __) =>
                                                  carouselConsumer.noFestival ||
                                                          carouselConsumer
                                                              .noInternetFestival
                                                      ? Container()
                                                      : carouselConsumer
                                                              .isFestivalsLoaded
                                                          ? carouselConsumer
                                                                  .isFestivalSearch
                                                              ? Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Positioned(
                                                                      top: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            180,
                                                                        width:
                                                                            myWidth,
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            Stack(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          fit: StackFit
                                                                              .expand,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              child: Hero(
                                                                                tag: carouselConsumer.festivalSearch!.festival!.id.toString() + "image",
                                                                                child: Image(
                                                                                  fit: BoxFit.cover,
                                                                                  image: NetworkImage(
                                                                                    carouselConsumer.festivalSearch!.festival!.images == null ? "no image" : carouselConsumer.festivalSearch!.festival!.images[0],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                              bottom: 50,
                                                                              right: 20,
                                                                              child: Container(
                                                                                decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(50)),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                                                child: Hero(
                                                                                  tag: carouselConsumer.festivalSearch!.festival!.id.toString() + "title",
                                                                                  child: Material(
                                                                                    color: Colors.transparent,
                                                                                    child: Text(
                                                                                      carouselConsumer.festivalSearch!.festival!.festivalTitle!,
                                                                                      style: const TextStyle(color: colorTextWhite),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            myWidth,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(40),
                                                                              topLeft: Radius.circular(40)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Positioned(
                                                                      top: 0,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            180,
                                                                        width:
                                                                            myWidth,
                                                                        child: CarouselSlider(
                                                                            key: const Key('carouselSlider'),
                                                                            items: carouselConsumer.carouselImages,
                                                                            options: CarouselOptions(
                                                                              height: 180,
                                                                              aspectRatio: 16 / 9,
                                                                              viewportFraction: 0.8,
                                                                              initialPage: 0,
                                                                              enableInfiniteScroll: false,
                                                                              reverse: false,
                                                                              autoPlay: true,
                                                                              autoPlayInterval: const Duration(seconds: 5),
                                                                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                                                              autoPlayCurve: Curves.fastOutSlowIn,
                                                                              enlargeCenterPage: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                          : Container(
                                                              child:
                                                                  const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Divider(
                                                indent: 64, endIndent: 64),
                                          ),
                                          Container(
                                            width: myWidth,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 5,
                                                      spreadRadius: 1)
                                                ]),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16,
                                                          right: 16,
                                                          top: 24,
                                                          bottom: 16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 32,
                                                                bottom: 12),
                                                        child: const Text(
                                                          'جستجوی اتوبوس',
                                                          style: TextStyle(
                                                              color:
                                                                  colorTextTitle,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  fontSizeTitle),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 0,
                                                                  vertical: 6),
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 0),
                                                              child: Consumer<
                                                                  MainViewModel>(
                                                                builder: (_,
                                                                        sourceViewModel,
                                                                        __) =>
                                                                    Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  key: const Key(
                                                                      'sourceInput'),
                                                                  child: sourceViewModel
                                                                          .isFestivalSearch
                                                                      ? Container()
                                                                      : sourceViewModel.loading ==
                                                                              true
                                                                          ? const Center(
                                                                              child: SpinKitThreeBounce(
                                                                                size: 25,
                                                                                color: colorTextSub2,
                                                                              ),
                                                                            )
                                                                          : Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: Stack(children: [
                                                                                Stack(
                                                                                  children: [
                                                                                    DropDownSearch(
                                                                                      required: true,
                                                                                      strict: true,
                                                                                      labelText: 'مبدا',
                                                                                      textStyle: TextStyle(fontSize: 15.0.sp),
                                                                                      icon: Icon(
                                                                                        Icons.location_on,
                                                                                        color: colorPrimary,
                                                                                        size: 20.0.sp,
                                                                                      ),
                                                                                      iconSize: 25.0.sp,
                                                                                      items: mainVMdl.result,
                                                                                      controller: sourceViewModel.sourceController,
                                                                                      textSubmitted: (text) {
                                                                                        print('############# text submited مبدا ##############');
                                                                                        sourceViewModel.onSourceTextChanged(text, mainVMdl.result, context);
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 0,
                                                                vertical: 6),
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 0),
                                                        child: Consumer<
                                                            MainViewModel>(
                                                          builder: (_,
                                                                  destViewModel,
                                                                  __) =>
                                                              Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            key: const Key(
                                                                'destinationInput'),
                                                            child: destViewModel
                                                                    .isFestivalSearch
                                                                ? Container()
                                                                : destViewModel
                                                                            .loading ==
                                                                        true
                                                                    ? const Center(
                                                                        child:
                                                                            SpinKitThreeBounce(
                                                                          size:
                                                                              25,
                                                                          color:
                                                                              colorPrimary,
                                                                        ),
                                                                      )
                                                                    : Stack(
                                                                        children: [
                                                                          DropDownSearch(
                                                                            required:
                                                                                true,
                                                                            strict:
                                                                                true,
                                                                            labelText:
                                                                                'مقصد',
                                                                            icon:
                                                                                Icon(
                                                                              Icons.location_on,
                                                                              color: colorPrimary,
                                                                              size: 20.0.sp,
                                                                            ),
                                                                            textStyle:
                                                                                TextStyle(fontSize: 15.0.sp),
                                                                            iconSize:
                                                                                25.0.sp,
                                                                            items:
                                                                                mainVMdl.result,
                                                                            controller:
                                                                                destViewModel.destinationController,
                                                                            textSubmitted:
                                                                                (text) {
                                                                              print('############# text submited  مقصد ##############');
                                                                              destViewModel.onDestTextChanged(text, mainVMdl.result, context);
                                                                            },
                                                                          ),

                                                                          // Align(
                                                                          //   alignment:
                                                                          //       Alignment.centerLeft,
                                                                          //   child:
                                                                          //       Container(
                                                                          //     margin:
                                                                          //         EdgeInsets.only(left: 8),
                                                                          //     child:
                                                                          //         Icon(
                                                                          //       Icons.check,
                                                                          //       color: destViewModel.currentDestination == null ? colorDeactivated : colorPrimary,
                                                                          //       size: 20,
                                                                          //     ),
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                          ),
                                                        ),
                                                      ),
                                                      Consumer<MainViewModel>(
                                                        builder: (_,
                                                                sorceDestConsumer,
                                                                __) =>
                                                            sorceDestConsumer
                                                                    .isFestivalSearch
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            6),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        const SizedBox(
                                                                            width:
                                                                                32),
                                                                        const SizedBox(
                                                                            width:
                                                                                12),
                                                                        AutoSizeText(
                                                                          sorceDestConsumer
                                                                              .festivalSearch!
                                                                              .festival!
                                                                              .title!,
                                                                          maxLines:
                                                                              2,
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          style: const TextStyle(
                                                                              color: colorTextSub,
                                                                              fontSize: fontSizeTitle + 3,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                12),
                                                                        const Icon(
                                                                          Icons
                                                                              .arrow_back_ios,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              colorTextSub,
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                12),
                                                                        const Expanded(
                                                                            child:
                                                                                Divider(thickness: 2)),
                                                                        const SizedBox(
                                                                            width:
                                                                                12),
                                                                        AutoSizeText(
                                                                          sorceDestConsumer
                                                                              .festivalSearch!
                                                                              .festivalTown!
                                                                              .name!,
                                                                          maxLines:
                                                                              2,
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          style: const TextStyle(
                                                                              color: colorTextSub,
                                                                              fontSize: fontSizeTitle + 3,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                32),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Container(
                                                        width: myWidth,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            AnimatedContainer(
                                                                // If the widget is visible, animate to 0.0 (invisible).
                                                                // If the widget is hidden, animate to 1.0 (fully visible).
                                                                width: wholeMinVConsumer
                                                                        .isRoundTrip
                                                                    ? (myWidth /
                                                                            2.0) -
                                                                        15
                                                                    : 0.0,
                                                                // opacity: wholeMinVConsumer.isRoundTrip ? 1.0 : 0.0,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                // The green box must be a child of the AnimatedOpacity widget.
                                                                child: wholeMinVConsumer
                                                                            .isRoundTrip ==
                                                                        true
                                                                    ? GestureDetector(
                                                                        child:
                                                                            AbsorbPointer(
                                                                          child:
                                                                              Consumer<MainViewModel>(
                                                                            builder: (_, roundDateMainVM, __) =>
                                                                                Container(
                                                                              margin: const EdgeInsets.only(left: 0, right: 0),
                                                                              child: Directionality(
                                                                                textDirection: TextDirection.rtl,
                                                                                child: TextField(
                                                                                  controller: roundDateMainVM.roundTripDateController,
                                                                                  key: const Key('dateRoundKey'),
                                                                                  style: const TextStyle(
                                                                                    color: colorTextTitle,
                                                                                    fontSize: textFontSizeTitle,
                                                                                  ),
                                                                                  decoration: InputDecoration(
                                                                                    fillColor: colorPrimaryGrey,
                                                                                    focusColor: Colors.white,
                                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40)),
                                                                                    filled: true,
                                                                                    labelText: 'تاریخ برگشت',
                                                                                    prefixIcon: const Icon(
                                                                                      Icons.date_range,
                                                                                      color: colorPrimary,
                                                                                    ),
                                                                                    labelStyle: const TextStyle(color: colorTextSub2, fontSize: 17, height: 1.5),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(40),
                                                                                        borderSide: const BorderSide(
                                                                                          color: colorPrimary,
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        key: const Key(
                                                                            'dateRoundPicker'),
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              'hey');
                                                                          FocusScope.of(context)
                                                                              .requestFocus(FocusNode()); // to prevent opening default keyboard
                                                                          showModalBottomSheet(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return mainViewModel!.persianDatePickerRound!;
                                                                              });
                                                                        },
                                                                      )
                                                                    : Container()),
                                                            Container(
                                                              // opacity: wholeMinVConsumer.isRoundTrip ? 1.0 : 0.0,
                                                              key: const Key(
                                                                  'dateInput'),
                                                              alignment:
                                                                  Alignment
                                                                      .center,

                                                              child: Consumer<
                                                                  MainViewModel>(
                                                                builder: (_,
                                                                        rowDateMainVM,
                                                                        __) =>
                                                                    GestureDetector(
                                                                  child:
                                                                      AbsorbPointer(
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              0),
                                                                      child:
                                                                          Directionality(
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            TextField(
                                                                              controller: rowDateMainVM.currentDateController,
                                                                              focusNode: rowDateMainVM.focusNodeDate,
                                                                              style: const TextStyle(
                                                                                color: colorTextTitle,
                                                                                fontSize: textFontSizeTitle,
                                                                              ),
                                                                              decoration: InputDecoration(
                                                                                fillColor: colorPrimaryGrey,
                                                                                focusColor: Colors.white,
                                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: BorderSide.none,
                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                ),
                                                                                filled: false,
                                                                                labelText: 'تاریخ رفت',
                                                                                icon: Container(
                                                                                  padding: const EdgeInsets.all(8),
                                                                                  decoration: BoxDecoration(color: colorPrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                                                                  child: const Icon(
                                                                                    Icons.flag,
                                                                                    color: colorPrimary,
                                                                                  ),
                                                                                ),
                                                                                labelStyle: TextStyle(color: colorTextSub2, fontSize: rowDateMainVM.focusNodeDate.hasFocus ? 21 : 17, height: 1.5),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(left: 8),
                                                                                child: Icon(
                                                                                  Icons.check,
                                                                                  color: (rowDateMainVM.currentDateController.text == null || rowDateMainVM.currentDateController.text == '') ? colorDeactivated : colorPrimary,
                                                                                  size: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  key: const Key(
                                                                      'datePicker'),
                                                                  onTap:
                                                                      () async {
                                                                    print(
                                                                        'hey');
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            FocusNode()); // to prevent opening default keyboard
                                                                    showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          print(rowDateMainVM
                                                                              .persianDatePicker!
                                                                              .options);
                                                                          return rowDateMainVM
                                                                              .persianDatePicker!;
                                                                        });
                                                                    //   Jalali? picked = await showPersianDatePicker(
                                                                    //     context: context,

                                                                    //     initialDate: Jalali.now(),
                                                                    //     firstDate: Jalali(1385, 8),
                                                                    //     lastDate: Jalali(1450, 9),
                                                                    // );
                                                                    // var label = picked!.formatFullDate();
                                                                    //  showPersianDatePicker(context: context,
                                                                    //   initialDate: initialDate,
                                                                    //    firstDate: firstDate,
                                                                    //     lastDate: lastDate);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Container(
                                                        // width: (myWidth - 30) / 2.0 - 20,
                                                        key: const Key(
                                                            'adultQuantity'),
                                                        alignment:
                                                            Alignment.center,

                                                        child: Consumer<
                                                            MainViewModel>(
                                                          builder: (_,
                                                                  qntyViewModel,
                                                                  __) =>
                                                              Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              const Spacer(),
                                                              InkWell(
                                                                  key: const Key(
                                                                      'adultMinusButton'),
                                                                  onTap: () {
                                                                    qntyViewModel
                                                                        .minusOrPlusQnty(
                                                                            false);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: colorPrimary.withOpacity(
                                                                            0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          colorPrimary,
                                                                    ),
                                                                  )),
                                                              const SizedBox(
                                                                  width: 16),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      const Text(
                                                                        "بزرگسال",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              colorTextSub2,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      Text(
                                                                        "${qntyViewModel.getCurrentQuantity == 0 ? 'بدون' : qntyViewModel.getCurrentQuantity}",
                                                                        key: const Key(
                                                                            'adultQuantityText'),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              colorTextPrimary,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              InkWell(
                                                                  key: const Key(
                                                                      'adultPlusButton'),
                                                                  onTap: () {
                                                                    qntyViewModel
                                                                        .minusOrPlusQnty(
                                                                            true);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: colorPrimary.withOpacity(
                                                                            0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color:
                                                                          colorPrimary,
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Container(
                                                        key: const Key(
                                                            'childQuantity'),
                                                        // width: (myWidth - 30) / 2.0 - 20,
                                                        alignment:
                                                            Alignment.center,

                                                        child: Consumer<
                                                            MainViewModel>(
                                                          builder: (_,
                                                                  qntyViewModel,
                                                                  __) =>
                                                              Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              const Spacer(),
                                                              InkWell(
                                                                  key: const Key(
                                                                      'childMinusButton'),
                                                                  onTap: () {
                                                                    qntyViewModel
                                                                        .minusOrPlusChildQnty(
                                                                            false);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: colorPrimary.withOpacity(
                                                                            0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color:
                                                                          colorPrimary,
                                                                    ),
                                                                  )),
                                                              const SizedBox(
                                                                  width: 16),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      const Text(
                                                                        "کودک",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              colorTextSub2,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      Text(
                                                                        "${qntyViewModel.childCurrentQuantity == 0 ? 'بدون' : qntyViewModel.childCurrentQuantity}",
                                                                        key: const Key(
                                                                            'childQuantityText'),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              colorTextPrimary,
                                                                          fontSize:
                                                                              fontSizeTitle,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 16),
                                                              InkWell(
                                                                  key: const Key(
                                                                      'childPlusButton'),
                                                                  onTap: () {
                                                                    qntyViewModel
                                                                        .minusOrPlusChildQnty(
                                                                            true);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(8),
                                                                    decoration: BoxDecoration(
                                                                        color: colorPrimary.withOpacity(
                                                                            0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
                                                                      color:
                                                                          colorPrimary,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Consumer<MainViewModel>(
                                                  builder: (_, mainVM, __) =>
                                                      InkWell(
                                                    key: const Key(
                                                        'searchButton'),
                                                    onTap: () async {
                                                      //check sources when user selects  source and destination by **ITEM lists***
                                                      print(
                                                          'mainVM.sourceController[0].text :: ${mainVM.sourceController.text} length: ${mainVM.sourceController.text.length} after change: ${mainVM.sourceController.text.trimRight().length}');
                                                      print(
                                                          'mainVM.onDestTextChanged[0].text :: ${mainVM.destinationController.text} length: ${mainVM.destinationController.text.length}');

                                                      mainVM.onSourceTextChanged(
                                                          mainVM
                                                              .sourceController
                                                              .text
                                                              .trimRight()
                                                              .trimLeft(),
                                                          mainVMdl.result,
                                                          context);
                                                      mainVMdl.onDestTextChanged(
                                                          mainVM
                                                              .destinationController
                                                              .text
                                                              .trimRight()
                                                              .trimLeft(),
                                                          mainVMdl.result,
                                                          context);
                                                      //------------------

                                                      bool empty = mainVM
                                                          .getTotalQuantity(
                                                              context);
                                                      if (!empty) {
                                                        return;
                                                      }
                                                      bool go, go2 = false;
                                                      go = await mainVM
                                                          .getResults(context);
                                                      mainVM
                                                          .hideProgressDialog();
                                                      if (go) {
                                                        await setCityNames(
                                                            mainVM
                                                                .getCurrentSource,
                                                            mainVM
                                                                .getCurrentDestination);
                                                        await setTicketDate(mainVM
                                                            .currentDateController
                                                            .text);
                                                        if (mainVM
                                                            .isRoundTrip) {
                                                          await setTwoWay(true);
                                                        } else {
                                                          await setTwoWay(
                                                              false);
                                                        }
                                                        print(
                                                            "fcvc ${mainVM.getCurrentSource} ${mainVM.getCurrentDestination} ${mainVM.currentDateController.text}");
                                                        print(
                                                            "********************************");
                                                        // print(mainVM.busListReturn[0].basePrice);
                                                        // print(mainVM.busListReturn[0].durationMinute);
                                                        ResultArgs resultArgs =
                                                            ResultArgs(
                                                                // widget
                                                                mainVM.busList,
                                                                mainVM
                                                                    .getCurrentSource,
                                                                mainVM
                                                                    .currentSourceId,
                                                                mainVM
                                                                    .getCurrentDestination,
                                                                mainVM
                                                                    .currentDestinationId,
                                                                mainVM
                                                                    .currentSourceCode,
                                                                mainVM
                                                                    .currentDestinationCode,
                                                                mainVM
                                                                    .isRoundTrip,
                                                                mainVM.setGregorianDate2(
                                                                    mainVM
                                                                        .currentDateController
                                                                        .text),
                                                                mainVM.setGregorianDate2(
                                                                    mainVM
                                                                        .roundTripDateController
                                                                        .text),
                                                                busListReturn:
                                                                    mainVM
                                                                        .busListReturn);

                                                        print(
                                                            'wwwwwwwwwwwwwwwwwwww ${mainVM.roundTripDateController.text}');

                                                        Navigator.pushNamed(
                                                          context,
                                                          '/ResultView',
                                                          arguments: resultArgs,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      // width: (12 + 35 + 12) * 1.0,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12,
                                                              top: 8,
                                                              bottom: 8,
                                                              right: 12),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  colorPrimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                              boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black12,
                                                                blurRadius: 5,
                                                                spreadRadius: 1)
                                                          ]),
                                                      child: mainVM.isSearching
                                                          ? const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(7.5),
                                                              child:
                                                                  SpinKitThreeBounce(
                                                                size: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const Icon(
                                                              Icons.search,
                                                              color:
                                                                  Colors.white,
                                                              size: 35,
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
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
