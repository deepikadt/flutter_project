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
}
