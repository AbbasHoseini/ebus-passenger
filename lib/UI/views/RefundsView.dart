import 'package:ebus/UI/widgets/RefundCancelDialog.dart';
import 'package:ebus/UI/widgets/RefundInfoDialog.dart';
import 'package:ebus/core/models/Refund.dart';
import 'package:ebus/core/viewmodels/RefundsViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefundsView extends StatefulWidget {
  const RefundsView({Key? key}) : super(key: key);

  @override
  _RefundsViewState createState() => _RefundsViewState();
}

class _RefundsViewState extends State<RefundsView> {
  RefundsViewModel? refundsViewModel;
  @override
  void initState() {
    super.initState();
    refundsViewModel = Provider.of<RefundsViewModel>(context, listen: false);
    refundsViewModel!.getRefunds(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorTextTitle),
        title: Text(
          'استردادها',
          style: TextStyle(
            color: colorTextTitle,
            fontSize: fontSizeTitle + 6,
          ),
        ),
      ),
      body: Consumer<RefundsViewModel>(
        builder: (_, viewModel, __) => viewModel.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : viewModel.refunds.length > 0
                ? ListView.builder(
                    itemCount: viewModel.refunds.length,
                    itemBuilder: (context, index) {
                      Refund refund = viewModel.refunds[index];
                      return _refundItem(context, index, refund);
                    },
                  )
                : Center(
                    child: Text('شما بلیطی را استرداد نکرده‌اید', style: TextStyle(fontSize: 20),),
                  ),
      ),
    );
  }

  Widget _refundItem(BuildContext context, int index, Refund refund) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بلیط شماره ${refund.travelTicketId}',
                style: TextStyle(
                    color: colorTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle + 3),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _getStatusColor(refund.status!),
                      shape: BoxShape.circle,
                    ),
                    height: 8,
                    width: 8,
                  ),
                  SizedBox(width: 4),
                  Text(
                    _getStatusString(refund.status!),
                    style: TextStyle(
                        color: _getStatusColor(refund.status!),
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeSubTitle),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => RefundInfoDialog(refund));
            },
            child: Container(
              child: Icon(
                Icons.info,
                size: 25,
                color: colorTextSub2,
              ),
            ),
          ),
          SizedBox(width: 16),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => RefundCancelDialog(refund));
            },
            child: Container(
              child: Icon(
                Icons.delete,
                size: 25,
                color: colorDanger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case -1:
        return colorApocalypse;
        break;
      case 0:
        return colorAwaiting;
        break;
      case 1:
        return colorSeen;
        break;
      case 2:
        return colorCorrect;
        break;
      case 3:
        return colorApocalypse;
        break;
      default:
        return colorAwaiting;
        break;
    }
  }

  String _getStatusString(int status) {
    switch (status) {
      case -1:
        return 'لغو شده';
        break;
      case 0:
        return 'در انتظار تأیید';
        break;
      case 1:
        return 'مشاهده شده';
        break;
      case 2:
        return 'تأیید شده';
        break;
      case 3:
        return 'عدم تأیید';
        break;
      default:
        return 'در انتظار تأیید';
    }
  }
}
