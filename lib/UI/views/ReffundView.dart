import 'package:ebus/core/viewmodels/RefundViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefundView extends StatefulWidget {
  final int? id;

  const RefundView({Key? key, this.id}) : super(key: key);
  @override
  _RefundViewState createState() => _RefundViewState();
}

class _RefundViewState extends State<RefundView> {
  RefundViewModel? refundViewModel;
  String greetingsText = '        همسفر گرامی';
  String refundText =
      '        با تشکر از همراهی شما، لطفا جهت استرداد تمام هزینه بلیط خود، با همکاران پشتیبانی ما تماس حاصل فرمایید. و شماره خرید و شماره کارت پرداخت خود را اعلام فرمایید. با تشکر';
  String callText = 'شماره تماس پشتیبانی: ۰۲۴۳۳۴۵۰۱۷۱';

  @override
  void initState() {
    super.initState();
    refundViewModel = Provider.of<RefundViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorTextTitle),
        title: Text(
          'استرداد',
          style: TextStyle(
            color: colorTextTitle,
            fontSize: fontSizeTitle + 6,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, spreadRadius: 0.5)
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'بلیط شماره ${widget.id}',
                style: TextStyle(
                    color: colorTextTitle,
                    fontSize: fontSizeTitle + 10,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: refundViewModel?.subjectController,
                keyboardType: TextInputType.text,
                style:
                    TextStyle(fontSize: fontSizeTitle - 1, color: colorTextSub),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorPrimary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.title,
                      color: colorTextWhite,
                      size: 22.0,
                    ),
                  ),
                  labelText: "موضوع (اختیاری)",
                  labelStyle:
                      TextStyle(fontSize: fontSizeTitle, color: colorTextSub2),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: refundViewModel?.descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style:
                    TextStyle(fontSize: fontSizeTitle - 1, color: colorTextSub),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorPrimary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.description,
                      color: colorTextWhite,
                      size: 22.0,
                    ),
                  ),
                  labelText: "توضیحات (اختیاری)",
                  labelStyle:
                      TextStyle(fontSize: fontSizeTitle, color: colorTextSub2),
                ),
              ),
              SizedBox(height: 32),
              !refundViewModel!.isSubmiting
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            refundViewModel!.submitRefund(context, widget.id!);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            child: Row(
                              children: [
                                Text(
                                  'ثبت استرداد',
                                  style: TextStyle(
                                      color: colorTextWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSizeTitle),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_left,
                                  color: colorTextWhite,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
