import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/viewmodels/ForgetPassViewmodel.dart';
import '../../helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassView extends StatefulWidget {
  @override
  _ForgetPassViewState createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: myWidth,
        height: myHeight,
        //padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                height: myHeight * 0.3,
                width: myWidth,
                alignment: Alignment.center,
                color: Colors.white,
                child: Hero(
                  tag: 'ebusLogo',
                  child: Image(
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                    color: colorPrimary,
                    image: AssetImage('images/icon.png'),
                  ),
                ),
              ),
            ),
            Consumer<ForgetPassViewmodel>(
              builder: (_, forgetPass, __) => Positioned(
                top: 0,
                child: SingleChildScrollView(
                  child: Container(
                    height: myHeight * 0.82,
                    width: myWidth,
                    padding: EdgeInsets.only(
                        left: 30, right: 30, bottom: 70, top: 40),
                    margin: EdgeInsets.only(top: myHeight * 0.3),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: colorPrimaryGrey,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: _buildWidgetsByStep(forgetPass, context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWidgetsByStep(
      ForgetPassViewmodel forgetPass, BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    switch (forgetPass.step) {
      case 0:
        return [
          Text('لطفا شماره تلفن همراه خود را جهت تغییر رمز خود وارد نمایید'),
          SizedBox(height: 16),
          TextField(
            key: Key('txtMobile'),
            controller: forgetPass.mobileController,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style:
                TextStyle(fontSize: fontSizeTitle - 2, color: colorTextPrimary),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40)),
              filled: true,
              prefixIcon: Icon(
                Icons.phone,
                color: colorPrimary,
                size: 22.0,
              ),
              hintText: "تلفن همراه",
              hintStyle: TextStyle(fontSize: fontSizeTitle - 2),
            ),
          ),
          SizedBox(height: myHeight*0.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: myWidth/2 -55,
                child: RaisedButton.icon(
                  key: Key('btnContinueMobile'),
                  icon: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,),
                  color: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    forgetPass.nextStep(context);
                    },
                  label: Text('ادامه',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: fontSizeTitle,
                          height: 1.8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ];
        break;
      case 1:
        return [
          Text('لطفا کد ارسال شده به تلفن همراه خود را وارد نمایید'),
          SizedBox(height: 16),
          TextField(
            key: Key('txtVerification'),
            controller: forgetPass.verificationController,
            keyboardType: TextInputType.number,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style:
                TextStyle(fontSize: fontSizeTitle - 2, color: colorTextPrimary),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40)),
              filled: true,
              prefixIcon: Icon(
                MdiIcons.numeric,
                color: colorPrimary,
                size: 22.0,
              ),
              hintText: "کد تأیید",
              hintStyle: TextStyle(fontSize: fontSizeTitle - 2),
            ),
          ),
          SizedBox(height: myHeight*0.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: myWidth/2 -55,
                child: RaisedButton.icon(
                  key: Key('btnContinueVerification'),
                  icon: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,),
                  color: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    forgetPass.nextStep(context);
                  },
                  label: Text('ادامه',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: fontSizeTitle,
                          height: 1.8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(child: Container()),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  height: 40,
                  width: myWidth/2 -55,
                  child: RaisedButton.icon(
                    key: Key('btnReturnVerification'),
                    icon: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,),
                    color: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      forgetPass.previousStep();
                    },
                    label: Text('بازگشت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontSizeTitle,
                            height: 1.8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ];
        break;
      case 2:
        return [
          Text('رمز جدید را وارد نمایید'),
          SizedBox(height: 16),
          TextField(
            key: Key('txtNewPass'),
            controller: forgetPass.newPassController,
            keyboardType: TextInputType.visiblePassword,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            obscureText: true,
            style:
                TextStyle(fontSize: fontSizeTitle - 2, color: colorTextPrimary),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40)),
              filled: true,
              prefixIcon: Icon(
                MdiIcons.accountKey,
                color: colorPrimary,
                size: 22.0,
              ),
              hintText: "رمز جدید",
              hintStyle: TextStyle(fontSize: fontSizeTitle - 2),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            key: Key('txtNewPassConfirm'),
            controller: forgetPass.confirmNewPassController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style:
                TextStyle(fontSize: fontSizeTitle - 2, color: colorTextPrimary),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40)),
              filled: true,
              prefixIcon: Icon(
                MdiIcons.accountKey,
                color: colorPrimary,
                size: 22.0,
              ),
              hintText: "تکرار رمز جدید",
              hintStyle: TextStyle(fontSize: fontSizeTitle - 2),
            ),
          ),
          SizedBox(height: myHeight*0.32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: myWidth/2 -55,
                child: RaisedButton.icon(
                  key: Key('btnContinueVerification'),
                  icon: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,),
                  color: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(40.0),
                  ),
                  onPressed: () {
                    forgetPass.nextStep(context);
                  },
                  label: Text('ادامه',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: fontSizeTitle,
                          height: 1.8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(child: Container()),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  height: 40,
                  width: myWidth/2 -55,
                  child: RaisedButton.icon(
                    key: Key('btnContinueNewPass'),
                    icon: Icon(Icons.arrow_back_ios, size: 20,color: Colors.white,),
                    color: colorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(40.0),
                    ),
                    onPressed: () {
                      forgetPass.previousStep();
                    },
                    label: Text('بازگشت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontSizeTitle,
                            height: 1.8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ];
        break;
      default:
        return [];
    }
  }
}
