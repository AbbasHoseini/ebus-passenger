import 'package:ebus/core/viewmodels/AboutUsViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  AboutUsViewModel? aboutUsViewModel;

  @override
  void initState() {
    super.initState();
    aboutUsViewModel = Provider.of<AboutUsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('aboutUsAppBar'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'درباره ما',
          style: TextStyle(
              color: colorTextPrimary,
              fontSize: fontSizeTitle + 5,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: colorTextPrimary),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aboutUsViewModel!.aboutUsText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
                Text(
                  'ارزش‌های مجموعه',
                  style: TextStyle(
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                      color: colorTextPrimary),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  aboutUsViewModel!.arzeshText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
                Text(
                  'حرمت کلام',
                  style: TextStyle(
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                      color: colorTextPrimary),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  aboutUsViewModel!.hormatText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
                SizedBox(height: 8),
                Text(
                  'توسعه و تعالی',
                  style: TextStyle(
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                      color: colorTextPrimary),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  aboutUsViewModel!.toseeText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
                SizedBox(height: 8),
                Text(
                  'ایده و خلق راه‌کار',
                  style: TextStyle(
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                      color: colorTextPrimary),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  aboutUsViewModel!.ideText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
                SizedBox(height: 8),
                Text(
                  'پاسخگویی به نیاز مشتریان',
                  style: TextStyle(
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                      color: colorTextPrimary),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(
                  aboutUsViewModel!.pasokhText,
                  style: TextStyle(
                      fontSize: fontSizeSubTitle + 4, color: colorTextSub),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Divider(endIndent: 64),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
