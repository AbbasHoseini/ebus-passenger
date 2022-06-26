import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebus/UI/widgets/showForgetPass3.dart';
import 'package:ebus/core/viewmodels/ForgetVerifyCodeViewModel.dart';
import 'package:ebus/helpers/constants.dart';
import 'package:ebus/core/viewmodels/ForgetSelectedOptionViewModel.dart';




Future<Future> dialogForgetPass2 (BuildContext context, int id, List<String> list)  async {


  List<String> options;
  if(list==null){
    options= <String>[];
    options.add("gozine1");
    options.add("gozine2");
    print("here");
  }else{options=list;}

  String? selectedOption;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final forgetSelectedOptionVM = Provider.of<ForgetSelectedOptionViewModel>(context);

  return showDialog(context: context, builder: (context){
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Wrap(
            children: <Widget>[
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                title: Text(forgetPass1STR,
                textDirection: TextDirection.rtl,),
                content: Column(
                  children: <Widget>[
                    options[0]==null && options[0]==null ? Text(dialogErrorSTR, textDirection: TextDirection.rtl,):
                    options[0]==null ? SizedBox(): RadioListTile(
                      title: Text(options[0], textDirection: TextDirection.rtl,),
                      activeColor: Colors.green,
                      selected:selectedOption == options[0],
                      value: options[0],
                      groupValue: selectedOption,
                      onChanged: (value) {
                        selectedOption = value as String?;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                    (options.length > 1 && options[1]!=null) ? RadioListTile(
                      title: Text(options[1], textDirection: TextDirection.rtl,),
                      activeColor: Colors.green,
                      selected:selectedOption == options[1],
                      value: options[1],
                      groupValue: selectedOption,
                      onChanged: (value) {
                        selectedOption = value as String?;
                        (context as Element).markNeedsBuild();
                      },
                    ): SizedBox(),
                  ],
                ),
                actions: <Widget>[
                  MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (context) => ForgetVerifyCodeViewModel()),
                    ],
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        dialogBtnNextSTR,
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: ()async {
                        if(selectedOption!.isNotEmpty){
                          await forgetSelectedOptionVM.getForgetSelectedOption(id, selectedOption=="phone" ? true: false, selectedOption=="mail" ? true: false);
                          if(forgetSelectedOptionVM.success!){
                            print("code sent to phone/mail. now open 3rd dialog to confirrm it ${forgetSelectedOptionVM.id}");
                            dialogForgetPass3(context, forgetSelectedOptionVM.id!);
                          }
                        }
                        print(selectedOption);
                      },
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      dialogBtnPrevSTR,
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    onPressed: ()async {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  });


}
