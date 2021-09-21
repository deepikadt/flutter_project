abstract class AppConstants {
  static const Duration apiTimeOut = Duration(minutes: 2);
}

//regular expressions
class AppRegex {
  static RegExp successCode = RegExp(r'20\d');
  static RegExp numberOnly = RegExp(r'\d');
  static RegExp emailWhitelistRegex = RegExp(r'[A-Za-z0-9_.*+@-]');
  static RegExp singleSpace = RegExp(r' ');
  static RegExp multipleSpace = RegExp(r'  ');
  static RegExp alphaNumberic = RegExp(r'[A-Za-z0-9 ]');
  static RegExp dateRegEx = RegExp(r'[0-9/ ]');
  static RegExp addressBlacklistRegex = RegExp(r'[^,/\\\.A-Za-z0-9- ]');
  /*static RegExp passwordRegex =
      RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');*/
  static RegExp passwordRegex =
      RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=\S+$).{6,}$');
  // RegExp(r'^[A-Za-z0-9]*$');
  static RegExp nameWhitelistRegex = RegExp(r'[A-Za-z0-9- ]');
  static RegExp checkLeadingZero = RegExp(r'^0+(?!$)');
  static RegExp dateOfBirth = RegExp(
      r'(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)');
}

class AppIntegers {
  static const int defaultNullError = -1;
  static const int maxOtpLength = 6;
  static const int maxEmailLength = 256;
  static const int maxNameLength = 250;
  static const int maxPasswordLength = 30;
  static const int maxAddressLength = 100;
  static const int maxBioLength = 250;
  static const int minOtpLength = 0;
  static const int minUserIdLength = 3;
  static const int minNameLength = 2;
  static const int minPasswordLength = 8;
  static const int minAddressLength = 5;
  static const int maxMobileLength = 9;
  static const int mobileNumberLength = 10;
  static const int masterCategoryIdPeople = 4;
  static const int masterCategoryIdBet = 5;
  static const int minLengthDescription = 5;
  static const int maxNumberLength = 9;
  static const int maxCardHolderLength = 70;
  static const int maxAllowedBetBuddies = 10;
  static const int cvcLength = 3;
  static const int bsbNumberLength = 6;
  static const int accountNumberLength = 8;
  static const int minPinCodeLength = 4;
  static const int accountSuspended = 5001;
  static const int selfExculde = 5002;
  static const int permanantlySelfExculde = 5035;
  static const int closedOrIdentityNotVerified = 5018;
  static const int suspendedToManyLoginAttempts = 5001;
  static const int errorInCloseAccountForWithdraw = 5060;
  static const int identityNotVerified = 5032;
  static const int invalidVerificationCode = 5038;
  static const int verificationCodeLimitCrossed = 5040;
}
