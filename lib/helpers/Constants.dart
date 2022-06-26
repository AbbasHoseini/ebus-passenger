import 'package:flutter/material.dart';

const String apiServer = 'ls.arian.co.ir:8081/api/1.0/arian/';
const String iframeServer = 'ls.arian.co.ir:8081/sysarian/fa/modern/';

enum AuthServiceType { real, mock }

const double fontSizeTitle = 17;
const double fontSizeMedTitle = 15.5;
const double fontSizeSubTitle = 14;

const Color colorTextPrimary = Colors.black87;
const Color colorTextWhite = Colors.white;
const Color colorFlatButton = Colors.blue;
const Color colorDivider = Colors.black45;
const Color colorPrimaryOld = Color(0xFF689f38);
const Color colorPrimary =
    Color.fromRGBO(78, 218, 146, 1); /*Color(0xFF73d700)*/
const Color colorPrimaryGrey = Color.fromRGBO(238, 237, 237, 1);
const Color colorGradient1 = Color(0xFF5dfe60);
const Color colorGradient2 = Color(0xFF28d1ab);
const Color colorAccentOld = Color(0xFF4caf50);
const Color colorAccent = Color(0xFF5cac00);
const Color colorSecondOld = Colors.green;
const Color colorSecond = Color(0xFF13EBA2);
const Color colorTextTitle = Colors.black;
const Color colorTextSub = Colors.black54;
const Color colorTextSub2 = Colors.black38;
const Color colorCorrect = Colors.green;
const Color colorWrong = Colors.red;
const Color colorApocalypse = Colors.red;
const Color colorDanger = Colors.deepOrange;
const Color colorAwaiting = Colors.orange;
const Color colorSeen = Colors.blue;
const Color colorCaution = Colors.yellow;
final Color colorDeactivated = Colors.grey.withOpacity(0.15);
const Color colorDeactiva = Colors.grey;
const Color colorLineChart = Colors.blue;
const Color colorLoginStart = Colors.white;
const Color colorLoginEnd = Colors.white;
const double textFontSizeTitle = 17;
const double textFontSizeSub = 13;
const double textFontSizeSplash = 17;
const Color colorBackground = Color(0xFFeef0f8);
const Color colorBubbles = Colors.amber;
const Color colorSeatAvailable = colorPrimary;
const Color colorSeatDisabled = Color(0xFFeeeeee);
const Color colorSeatChoosen = Color(0xFFe57373);

/* Choose seats */
const classAColor = Color(0xffFFB329);
const insideClassAColor = Colors.white;

const classBColor = Color(0xff00bcd4);

const classCColor = Color(0xffa1887f);

const selectedSeatBorderColor = Color(0xff06D433);
const selectedInsideColor = Color(0xffA7FFA7);

const unableToSelectSeatBorderColor = Color(0xffA9A9A9);
const unableToSelectSeatInsideColor = Color(0xffCECACA);

const defaultColor = Color(0xff388e3c);
/* -- */

const List<Color> splashGradient = [
  colorPrimary,
  colorPrimary,
  colorPrimary,
  /*Colors.lightGreen[300],
  Colors.lightGreen[400],
  Colors.lightGreen[500],*/
];
const String appTitle = 'E-Bus';
const String mainTitle = 'ای باس';
const String resultTitle = 'نتایج جستجو';
const String filterTitle = 'فیلترکردن اتوبوس ها';
const String userStaticsTitle = 'خلاصه وضعیت سفرها';

const String loremString =
    "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.";
// const String baseUrl = "http://api.ebus.ir";
// const String baseUrl = "http://ls.arian.co.ir:3003";
// const String signupURL = "http://ls.arian.co.ir:3003";
// const String signupURL = "ls.arian.co.ir:3003";
const String baseUrl = "ebus.ir"; // server
// const String baseUrl = "192.168.1.100:9999"; //arash
// const String baseUrl = "192.168.1.181:9999"; //arash sherkat
// const String baseUrl = "192.168.1.130:8080"; // mamadreza


const String prefixURL = "/service/api/v1"; //TODO
// const String prefixURL = "/develop/api/v1";

const String signupURL2 = "ebusapi.arian.co.ir";
const String signupCodeFailSTR = "کد وارد شده اشتباه است!";
const String notUserSTR = "عضو نیستید؟";
const String signUpSTR = "ثبت نام کنید.";
const String signUpNationalCodeSTR = "کد ملی";
const String signInUserSTR = "نام کاربری / شماره تلفن / ایمیل";
const String signInPassSTR = "رمز ورود";
const String signInBtnSTR = "ورود";
const String signInForgetBtnSTR = "فراموشی رمز عبور";
const String signInSuccessSTR = "وارد شدید";
const String signInErrorSTR = "ورود نا موفق";
const String signInFieldEmptySTR = "اطلاعات را کامل وارد نمایید!";
const String forgetPass1STR = "بازیابی رمز از طریق";
const String dialogBtnNextSTR = "بعدی";
const String dialogBtnPrevSTR = "قبلی";
const String dialogErrorSTR = "خطای بارگذاری";
const String seatChooseError = "این صندلی در دسترس نیست.";
const String forget3TextFieldSTR = "کد دریافتی را وارد نمایید";
const String forget4PassErrorSTR = "رمز وارد شده معتبر نیست!";
const String forget4PassReqErrorSTR = "خطای تغییر رمز!";
const String forget4PassSuccessSTR = "رمز تغیر یافت!";
const String forget4PassCodeTR = "رمز جدید";
const String forget4PassConfirmSTR = "تکرار رمز جدید";

const String myProfileTitle = "حساب کاربری";
const String myProfileInfo = "مشخصات من";
const String myProfilePhone = "شماره تماس";
const String myProfileEmail = "ایمیل";
const String myProfileName = "نام";
const String myProfileLastName = "نام خانوادگی";
const String myProfileGender = "جنسیت";
const String myProfileUsername = "نام کاربری";
const String myProfileEmpty = "وارد نشده";
const String myProfileError = "خطای";
const String myProfileSuccess = "تایید";
const String myProfileEditSubmit = "ثبت تغییرات";

const String oldPassword = "رمز قبلی";
const String newPassword = "رمز جدید";
const String newPasswordConfirm = "تائید رمز جدید";

const operationDone = "عملیات موفق آمیز";
const operationFail = "عملیات ناموفق";
const btnCancel = "انصراف";

const String myMainSource = "مبدا";
const String myMainDestination = "مقصد";
const String myMainDate = "تاریخ";
const String myMainQuantity = "بزرگسال";
const String myMainChildQuantity = "کودک";
const String myMainTime = "زمان حرکت";
const String myMainSearch = "جستجوی اتوبوس ها";
const String myMainChoice = "انتخاب";

const String myFilterPrice = "هزینه سفر";
const String myFilterBusType = "نوع اتوبوس";
const String myFilterBusVip = "اتوبوس ویژه";
const String myFilterBusCasual = "اتوبوس معمولی";
const String myFilterApplyButton = "اعمال فیلتر";

const String myTravelDetailsSource = "مبدا";
const String myTravelDetailsDestination = "مقصد";
const String myTravelDetailsVoucherCode = "کد تخفیف";
const String myTravelDetailsVoucherCodeBtn = "بررسی کد تخفیف";
const String myTravelDetailsReserveBtn = "صدور پیش فاکتور";
const String myTravelDetailsReservePrice = "مبلغ حدودی قابل پرداخت";
const String myTravelDetailsconstPrice = "مبلغ نهایی قابل پرداخت";
const String myTravelDetailsDiscountPrice = "تخفیف";
const String myTravelDetailsPayment = "پرداخت";

const String myInvoicePayment = "پرداخت از طریق";
const String myInvoiceBankPayment = "واریز آنلاین";
const String myInvoiceWalletPayment = "کیف پول";

const String myPassengerTitle = "لیست مسافران تعریف شده";
const String myPassengerFaveTitle = "مسافران منتخب";

const String myReportsBtnTitle = "مشاهده جزئیات";
const String myAddReportsBtnTitle = "ثبت گزارش جدید";

const String myAddTransactionBtnTitle = "لیست تراکنش ها";
const String myTravelsBtnTitle = "لیست سفر های انجام شده";
const String myAssignPassengersTitle = "وارد کردن اطلاعات مسافران";
const String myAssignPassengersBtnTitle = "تائید اطلاعات مسافران";

const String myTravelsTitle = "سفرهای من";
