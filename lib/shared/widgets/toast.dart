import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';

class CustomToast {
  errorToast(message, position) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme().colors.dark,
      textColor: AppTheme().colors.backGround,
      fontSize: 16.0,
    );
  }

  successToast(message, position) {
    Fluttertoast.showToast(
      msg: "Welcome!",
      toastLength: Toast.LENGTH_LONG,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme().colors.highlight,
      textColor: AppTheme().fontColors.base,
      fontSize: 16.0,
    );
  }
}
