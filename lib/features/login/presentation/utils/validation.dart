import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/toast.dart';

class Validation {
  bool validateFields(user, pin, confirmPin, userChecked, signedUp) {
    var errorMsg = "";
    var error = false;

    if (user == "" && !error) {
      errorMsg = "Invalid username";

      error = true;
    }

    if (user.length > 16 && !error) {
      errorMsg = "Invalid username";

      error = true;
    }

    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

    if (!validCharacters.hasMatch(user) && !error) {
      errorMsg = "Invalid username";

      error = true;
    }

    if (userChecked) {
      if (pin.length < 4 && !error) {
        errorMsg = "Invalid pin";

        error = true;
      }

      if (!signedUp) {
        if (confirmPin.length < 4 && !error) {
          errorMsg = "Invalid confirm pin";

          error = true;
        }

        if (confirmPin != pin && !error) {
          errorMsg = "Invalid confirm pin";

          error = true;
        }
      }
    }

    if (error) {
      CustomToast().errorToast(errorMsg, ToastGravity.BOTTOM);
    }

    return error;
  }
}
