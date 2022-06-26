import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ebus/UI/views/AboutUsView.dart';
import 'package:ebus/UI/views/AssignPassengersView.dart';
import 'package:ebus/UI/views/FestivalTownView.dart';
import 'package:ebus/UI/views/FestivalsView.dart';
import 'package:ebus/UI/views/FilterView.dart';
import 'package:ebus/UI/views/GeneratedTicketsView.dart';
import 'package:ebus/UI/views/InvoiceView.dart';
import 'package:ebus/UI/views/OldLoginView.dart';
import 'package:ebus/UI/views/PassengersView.dart';
import 'package:ebus/UI/views/ReportsView.dart';
import 'package:ebus/UI/views/ResultView.dart';
import 'package:ebus/UI/views/TicketDetailView.dart';
import 'package:ebus/UI/views/TransactionView.dart';
import 'package:ebus/UI/views/TravelDetailView.dart';
import 'package:ebus/UI/views/TravelDetailViewNew.dart';
import 'package:ebus/UI/views/TravelsHistoryView.dart';
import 'package:ebus/UI/views/UserStaticsView.dart';
import 'package:ebus/UI/views/WalletView.dart';
import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/models/ResultArgs.dart';
import 'package:ebus/core/models/TransactionArgs.dart';
import 'package:ebus/core/models/TravelDetailArgsNew.dart';
import 'package:ebus/core/models/TravelDetailsArgs.dart';
import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/core/viewmodels/AboutUsViewModel.dart';
import 'package:ebus/core/viewmodels/CurrentTravelViewModel.dart';
import 'package:ebus/core/viewmodels/FestivalDetailViewModel.dart';
import 'package:ebus/core/viewmodels/FestivalTownViewModel.dart';
import 'package:ebus/core/viewmodels/FestivalsViewModel.dart';
import 'package:ebus/core/viewmodels/FilterViewModel.dart';
import 'package:ebus/core/viewmodels/GeneratedTicketViewModel.dart';
import 'package:ebus/core/viewmodels/InvoiceViewModel.dart';
import 'package:ebus/core/viewmodels/LoginViewModel.dart';
import 'package:ebus/core/viewmodels/MyTravelDashboardViewModel.dart';
import 'package:ebus/core/viewmodels/OldLoginViewModel.dart';
import 'package:ebus/core/viewmodels/PassengersViewModel.dart';
import 'package:ebus/core/viewmodels/ReportViewModel.dart';
import 'package:ebus/core/viewmodels/ReportsViewModel.dart';
import 'package:ebus/core/viewmodels/ResultViewModel.dart';
import 'package:ebus/core/viewmodels/TransactionViewModel.dart';
import 'package:ebus/core/viewmodels/TravelDetailVieModelNew.dart';
import 'package:ebus/core/viewmodels/TravelDetailViewModel.dart';
import 'package:ebus/core/viewmodels/UserStaticsViewModel.dart';
import 'package:ebus/core/viewmodels/WalletViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ebus/UI/views/MainView.dart';
import 'package:ebus/UI/views/ProfileView.dart';
import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:ebus/UI/views/SplashView.dart';
import 'package:ebus/core/viewmodels/ProfileViewModel.dart';
import 'package:ebus/core/viewmodels/SplashViewmodel.dart';
import 'package:ebus/UI/views/LoginView.dart';
import 'package:ebus/core/viewmodels/ForgetNewPassViewModel.dart';
import 'package:ebus/core/viewmodels/ForgetVerifyCodeViewModel.dart';
import 'package:ebus/core/viewmodels/ForgetListOptionViewModel.dart';
import 'UI/views/CurrentTravelView.dart';
import 'UI/views/FestivalDetailView.dart';
import 'UI/views/ForgetPassView.dart';
import 'UI/views/MyTravelDashboardView.dart';
import 'UI/views/ReffundView.dart';
import 'UI/views/RefundsView.dart';
import 'UI/views/SubmitReportView.dart';
import 'UI/views/TicketDetailPdf.dart';
import 'core/models/Festival.dart';
import 'core/viewmodels/ForgetPassViewmodel.dart';
import 'core/viewmodels/ForgetSelectedOptionViewModel.dart';
import 'package:ebus/core/viewmodels/SignUpViewmodel.dart';

import 'UI/views/SignUpView.dart';
import 'core/viewmodels/RefundViewModel.dart';
import 'core/viewmodels/RefundsViewModel.dart';
// import 'package:device_preview/device_preview.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  // DevicePreview()
  runApp(
    MyApp(initialAuthServiceType: AuthServiceType.real),
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({this.initialAuthServiceType = AuthServiceType.real});
  final AuthServiceType initialAuthServiceType;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FilterViewModel()),
        ChangeNotifierProvider(create: (context) => TravelDetailViewModel()),
        ChangeNotifierProvider(
            create: (context) =>
                ResultViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                PassengersViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                InvoiceViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                MainViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(create: (context) => SplashViewmodel()),
        ChangeNotifierProvider(
          create: (context) =>
              LoginViewModel(authServiceType: initialAuthServiceType),
        ),
        ChangeNotifierProvider(
            create: (context) => ForgetListOptionViewModel()),
        ChangeNotifierProvider(
            create: (context) => ForgetVerifyCodeViewModel()),
        ChangeNotifierProvider(
            create: (context) => ForgetSelectedOptionViewModel()),
        ChangeNotifierProvider(create: (context) => ForgetNewPassViewModel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ChangeNotifierProvider(
            create: (context) =>
                SignUpViewmodel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                ReportViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                UserStaticsViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) => GeneratedTicketViewModel(
                authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(create: (context) => OldLoginViewModel()),
        ChangeNotifierProvider(create: (context) => FestivalDetailViewModel()),
        ChangeNotifierProvider(
            create: (context) => TravelDetailViewModelNew(
                authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                FestivalsViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                ForgetPassViewmodel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                FestivalTownViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) => MyTravelDashboardViewModel(
                authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) => CurrentTravelViewModel(
                authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                ReportsViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                WalletViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                TransactionViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                AboutUsViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                RefundViewModel(authServiceType: initialAuthServiceType)),
        ChangeNotifierProvider(
            create: (context) =>
                RefundsViewModel(authServiceType: initialAuthServiceType)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Sans',
          canvasColor: Colors.white,
          cursorColor: colorTextSub2,
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/MainView':
              // TravelDetailsArgs travelDetailsArgs = settings.arguments;
              return MaterialPageRoute(
                settings: const RouteSettings(name: '/MainView'),
                builder: (context) => const Directionality(
                    textDirection: TextDirection.rtl, child: MainView()),
              );
              // return FadeRoute(
              //   widget: Directionality(
              //     textDirection: TextDirection.rtl,
              //     child: Builder(
              //       builder: (BuildContext context) {
              //         return MediaQuery(
              //           data: MediaQuery.of(context).copyWith(
              //             textScaleFactor: 1.0,
              //           ),
              //           child: MainView(),
              //         );
              //       },
              //     ),
              //   ),
              // );
              break;
            case '/TravelDetailView':
              TravelDetailsArgs travelDetailsArgs =
                  settings.arguments as TravelDetailsArgs;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: TravelDetailView(
                          travelDetailsArgs: travelDetailsArgs,
                        ),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/ForgetPassView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: ForgetPassView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/RefundView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: RefundView(id: settings.arguments as int),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/ResultView':
              ResultArgs resultArgs = settings.arguments as ResultArgs;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      print('reeeeeeeesult args::: ${resultArgs.comingDate}');
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: ResultView(resultArgs: resultArgs),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/InvoiceView': //
              InvoiceArgs invoiceArgs = settings.arguments as InvoiceArgs;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: InvoiceView(
                          invoiceArgs: invoiceArgs,
                        ),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/PassengersView':
            /* this should be remove */
              // List<PassengerArgs> passengersArgs =
              //     settings.arguments as List<PassengerArgs>;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      // print('************************* $passengersArgs');
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: PassengersView(
                          // passengersArgs: passengersArgs,
                        ),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/AssignPassengersView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: AssignPassengersView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/FilterView':
              ResultArgs resultArgs = settings.arguments as ResultArgs;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: FilterView(resultArgs: resultArgs),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/ReportsView':
              List<ReportArgs> reportArgs =
                  settings.arguments as List<ReportArgs>;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: ReportsView(),
                      );
                    },
                  ),
                ),
              );
              break;

            case '/TransactionView':
            /* should be remove */
              // List<TransactionArgs> transactions =
              //     settings.arguments as List<TransactionArgs>;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: TransactionView(),
                      );
                    },
                  ),
                ),
              );
            //   break;
            // case '/TravelsHistoryView':
            //   List<TravelHistoryArgs> travels = settings.arguments;
            //   return FadeRoute(
            //     widget: Directionality(
            //       textDirection: TextDirection.rtl,
            //       child: Builder(
            //         builder: (BuildContext context) {
            //           return MediaQuery(
            //             data: MediaQuery.of(context).copyWith(
            //               textScaleFactor: 1.0,
            //             ),
            //             child: TravelsHistoryView(travels: travels),
            //           );
            //         },
            //       ),
            //     ),
            //   );
            //   break;
            case '/FestivalDetailView':
              Festival festival = settings.arguments as Festival;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: FestivalDetailView(festival: festival),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/TravelDetailViewNew':
              TravelDetailArgsNew travelDetailsArgs =
                  settings.arguments as TravelDetailArgsNew;
              return MaterialPageRoute(
                builder: (context) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Builder(
                      builder: (BuildContext context) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            textScaleFactor: 1.0,
                          ),
                          child: TravelDetailViewNew(
                            travelDetailArgs: travelDetailsArgs,
                          ),
                        );
                      },
                    ),
                  );
                },
              );
              break;
            // case '/TravelDetailViewNew':
            //   TravelDetailArgsNew travelDetailsArgs = settings.arguments;
            //   return MaterialPageRoute(
            //     builder: (BuildContext context) {
            //       return Directionality(
            //         textDirection: TextDirection.rtl,
            //         child: MediaQuery(
            //           data: MediaQuery.of(context).copyWith(
            //             textScaleFactor: 1.0,
            //           ),
            //           child: TravelDetailViewNew(
            //             travelDetailArgs: travelDetailsArgs,
            //           ),
            //         ),
            //       );
            //     },
            //   );
            //   break;
            case '/LoginView':
              return FadeRoute(
                widget: LoginView(),
              );
              break;
            case '/ProfileView':
              return FadeRoute(
                widget: Directionality(
                    textDirection: TextDirection.rtl, child: ProfileView()),
              );
              break;
            case '/SignUpView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: SignUpView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/UserStaticsView':
              return FadeRoute(
                widget: Directionality(
                    textDirection: TextDirection.rtl, child: UserStaticsView()),
              );
              break;
            case '/GeneratedTicketsView':
              return FadeRoute(
                widget: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GeneratedTicketsView()),
              );
              break;
            case '/SubmitReportView':
              // List<ReportArgs> reportArgs =
              //     settings.arguments as List<ReportArgs>;

              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: SubmitReportView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/OldLoginView':
              return FadeRoute(
                widget: OldLoginView(),
              );
              break;
            case '/ProfileView':
              return FadeRoute(
                widget: Directionality(
                    textDirection: TextDirection.rtl, child: ProfileView()),
              );
              break;
            case '/TicketDetailView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: TicketDetailView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/FestivalsView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: FestivalsView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/FestivalTownView':
              Festival festival = settings.arguments as Festival;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: FestivalTownView(festival: festival),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/MyTravelDashboardView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: MyTravelDashboardView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/TicketDetailPdf':
              List<int> list = settings.arguments as List<int>;
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: TicketDetailPdf(pdf: list),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/CurrentTravelView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: CurrentTravelView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/WalletView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: WalletView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/AboutUsView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: AboutUsView(),
                      );
                    },
                  ),
                ),
              );
              break;
            case '/RefundsView':
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: RefundsView(),
                      );
                    },
                  ),
                ),
              );
              break;

            default:
              return FadeRoute(
                widget: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Builder(
                    builder: (BuildContext context) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: 1.0,
                        ),
                        child: MainView(),
                      );
                    },
                  ),
                ),
              );
          }
        },
        home: SplashView(),
        builder: EasyLoading.init(),
        /*
        Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (BuildContext context) {
              List<PassengerArgs> passengersArgs = List<PassengerArgs>();
              passengersArgs.add(PassengerArgs(id: 1, nationalCode: 25484, name: "مسافر"));
              passengersArgs.add(PassengerArgs(id: 2, nationalCode: 745184, name: "مسافر"));
              passengersArgs.add(PassengerArgs(id: 3, nationalCode: 19594, name: "مسافر"));
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: PassengersView(passengersArgs: passengersArgs,),
              );
            },
          ),
        ),
        */
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? widget;
  FadeRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget!;
          },
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var curve = Curves.ease;
            var tween = Tween(begin: 0.0, end: 1.0);
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return Align(
              child: FadeTransition(
                opacity: tween.animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
}
//just a connection test commit
