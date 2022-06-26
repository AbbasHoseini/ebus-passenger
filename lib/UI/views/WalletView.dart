import 'package:ebus/core/viewmodels/WalletViewModel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/CurrencyInputFormatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  WalletViewModel? walletViewModel;

  @override
  void initState() {
    super.initState();
    walletViewModel = Provider.of<WalletViewModel>(context, listen: false);
    walletViewModel!.getWalletCredit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colorTextTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'کیف پول',
          style: TextStyle(
              color: colorTextTitle,
              fontSize: fontSizeTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<WalletViewModel>(
        builder: (_, viewModel, __) => Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              viewModel.isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        viewModel.formatter
                                .format(viewModel.credit),
                        style: const TextStyle(
                          color: colorTextPrimary,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'ریال',
                  style: TextStyle(
                    color: colorTextSub2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(height: 16),
              Divider(indent: 64, endIndent: 64),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'افزایش موجودی',
                  style: TextStyle(
                    color: colorTextPrimary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    _fixedAmountWidget(walletViewModel!.firstFixAmount),
                    _fixedAmountWidget(walletViewModel!.secondFixAmount),
                    _fixedAmountWidget(walletViewModel!.thirdFixAmount),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    InkWell(
                      key: Key('moneyMinusButton'),
                      onTap: () {
                        if (viewModel.amountController.text != null &&
                            viewModel.amountController.text != '') {
                          if (viewModel.addAmountFormatter.getUnmaskedInt() <
                              walletViewModel!.fixAddOrSubsctractAmount) {
                            viewModel.amountController.text = (0).toString();
                            viewModel.amountController.value =
                                viewModel.addAmountFormatter.formatEditUpdate(
                                    viewModel.amountController.value,
                                    viewModel.amountController.value);
                          } else {
                            viewModel.amountController.text = (viewModel
                                        .addAmountFormatter
                                        .getUnmaskedInt() -
                                    walletViewModel!.fixAddOrSubsctractAmount)
                                .toString();
                            viewModel.amountController.value =
                                viewModel.addAmountFormatter.formatEditUpdate(
                                    viewModel.amountController.value,
                                    viewModel.amountController.value);
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorTextSub),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.remove,
                          color: colorTextSub,
                          size: 35,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: viewModel.amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            viewModel.addAmountFormatter,
                          ],
                          onChanged: (string) {
                            String _digits =
                                string.replaceAll(RegExp('[^0-9]'), "");
                            print('String = $string');
                            // viewModel.amountController.value = TextEditingValue(
                            //   text: string,
                            //   selection: TextSelection.collapsed(
                            //       offset: string.length),
                            // );
                            // viewModel.addAmountFormatter.formatEditUpdate(string, _digits);
                          },
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'مبلغ دلخواه',
                            hintStyle: TextStyle(color: colorTextSub2),
                            // suffixText: 'ریال',
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                              color: colorTextPrimary,
                              fontSize: fontSizeTitle + 4,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      key: Key('moneyPlusButton'),
                      onTap: () {
                        if (viewModel.amountController.text == null ||
                            viewModel.amountController.text == '') {
                          viewModel.amountController.text =
                              (walletViewModel!.fixAddOrSubsctractAmount)
                                  .toString();
                          viewModel.amountController.value =
                              viewModel.addAmountFormatter.formatEditUpdate(
                                  viewModel.amountController.value,
                                  viewModel.amountController.value);
                        } else {
                          viewModel.amountController.text =
                              (viewModel.addAmountFormatter.getUnmaskedInt() +
                                      walletViewModel!.fixAddOrSubsctractAmount)
                                  .toString();
                          viewModel.amountController.value =
                              viewModel.addAmountFormatter.formatEditUpdate(
                                  viewModel.amountController.value,
                                  viewModel.amountController.value);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorTextSub),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.add,
                          color: colorTextSub,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  walletViewModel!.addToCredit(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  margin:
                      EdgeInsets.only(right: 12, left: 12, bottom: 12, top: 12),
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'پرداخت',
                    style: TextStyle(
                      color: colorTextWhite,
                      fontSize: fontSizeTitle + 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fixedAmountWidget(int amount) {
    return Expanded(
        child: InkWell(
      onTap: () {
        walletViewModel!.amountController.text = (amount).toString();
        walletViewModel!.amountController.value =
            walletViewModel!.addAmountFormatter.formatEditUpdate(
                walletViewModel!.amountController.value,
                walletViewModel!.amountController.value);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorTextSub,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          walletViewModel!.formatter.format(amount).toString(),
          style: TextStyle(
            color: colorTextSub,
            fontSize: fontSizeTitle + 3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
