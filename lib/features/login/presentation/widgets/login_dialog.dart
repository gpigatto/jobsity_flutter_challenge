import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/register_bloc.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(serviceLocator()),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(serviceLocator()),
        ),
      ],
      child: _LoginDialog(),
    );
  }
}

class _LoginDialog extends StatefulWidget {
  @override
  __LoginDialogState createState() => __LoginDialogState();
}

class __LoginDialogState extends State<_LoginDialog> {
  final pinFocus = FocusNode();
  final confirmPinFocus = FocusNode();

  bool signUp = false;

  String user = "";
  String pin = "";
  String confirmPin = "";

  _validation() {
    var errorMsg = "";
    var error = false;

    if (user == "" && !error) {
      errorMsg = "Invalid user";

      error = true;
    }

    if (user.length > 16 && !error) {
      errorMsg = "Invalid user";

      error = true;
    }

    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

    if (!validCharacters.hasMatch(user) && !error) {
      errorMsg = "Invalid user";

      error = true;
    }

    if (user == "" && !error) {
      errorMsg = "Invalid user";

      error = true;
    }

    if (pin.length < 4 && !error) {
      errorMsg = "Invalid pin";

      error = true;
    }

    if (signUp) {
      if (confirmPin.length < 4 && !error) {
        errorMsg = "Invalid confirm pin";

        error = true;
      }

      if (confirmPin != pin && !error) {
        errorMsg = "Invalid confirm pin";

        error = true;
      }

      // TODO check if user exist
    }

    if (error) {
      Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.darkAccent,
        textColor: AppTheme.accentBackground,
        fontSize: 16.0,
      );
    }

    return error;
  }

  _action() {
    if (_validation()) {
      return null;
    }

    if (signUp) {
      context.read<RegisterBloc>().add(
            RegisterLoad(
              LoginClass(
                username: user,
                pin: pin,
              ),
            ),
          );
    } else {
      context.read<LoginBloc>().add(
            LoginLoad(
              LoginClass(
                username: user,
                pin: pin,
              ),
            ),
          );
    }
  }

  _loginBlocHandler(stateContext, state) {
    if (state is LoginLoaded) {
      if (state.correct) {
        _successToast("Welcome!");

        context.read<GetLoggedBloc>().add(GetLoggedLoad());

        Navigator.pop(context);
      } else {
        _errorToast("Invalid User..");
      }
    } else if (state is LoginError) {
      _errorToast("Something went wrong..");
    }
  }

  _registerBlocHandler(context, state) {
    if (state is RegisterLoaded) {
      context.read<LoginBloc>().add(
            LoginLoad(
              LoginClass(
                username: user,
                pin: pin,
              ),
            ),
          );
    } else if (state is RegisterError) {
      _errorToast("Something went wrong..");
    }
  }

  _errorToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.darkAccent,
      textColor: AppTheme.accentBackground,
      fontSize: 16.0,
    );
  }

  _successToast(message) {
    Fluttertoast.showToast(
      msg: "Welcome!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.highlight,
      textColor: AppTheme.fontColor,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _radius = 16.0;
    final _padding = 120.0;

    final _minSize = MainAxisSize.min;

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            _loginBlocHandler(context, state);
          },
        ),
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            _registerBlocHandler(context, state);
          },
        ),
      ],
      child: AlertDialog(
        title: _title(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
        ),
        content: Builder(
          builder: (context) {
            var width = MediaQuery.of(context).size.width - _padding;

            return Container(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: _minSize,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _usernameField(context),
                    VSpace(24),
                    PinField(
                      title: "Pin",
                      onComplete: (value) {
                        pin = value;

                        if (signUp) {
                          FocusScope.of(context).requestFocus(confirmPinFocus);
                        } else {
                          _action();
                        }
                      },
                      focusNode: pinFocus,
                    ),
                    VSpace(24),
                    if (signUp)
                      Column(
                        children: [
                          PinField(
                            title: "Confirm Pin",
                            onComplete: (value) {
                              confirmPin = value;
                              _action();
                            },
                            focusNode: confirmPinFocus,
                          ),
                          VSpace(24),
                        ],
                      )
                    else
                      SizedBox(),
                    _logIn(),
                    if (!signUp)
                      Column(
                        children: [
                          VSpace(8),
                          _signUp(),
                        ],
                      )
                    else
                      SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _title() {
    final _title = signUp ? "Register" : "Login";
    final _textColor = AppTheme.fontColor;
    final _fontWeight = AppTheme.fontWeightBold;
    final _textSize = 22.0;

    return Text(
      _title,
      style: TextStyle(
        color: _textColor,
        fontSize: _textSize,
        fontWeight: _fontWeight,
      ),
    );
  }

  _signUp() {
    final _textColor = AppTheme.darkAccent;

    return TextButton(
      onPressed: () {
        setState(() {
          signUp = true;
        });
      },
      child: Text(
        'Not a user yet? Sign up here',
        style: TextStyle(color: _textColor),
      ),
    );
  }

  _usernameField(BuildContext context) {
    final _color = AppTheme.backGround;
    final _cursorColor = AppTheme.fontColor;
    final _shadow = AppTheme.shadow0;

    final _icon = Icons.person;

    final _radius = 16.0;
    final _innerPaddingHorizontal = 8.0;
    final _innerPaddingVertical = 4.0;
    final _fontSize = 22.0;

    final _hint = "Username";

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _innerPaddingVertical,
          horizontal: _innerPaddingHorizontal,
        ),
        child: TextField(
          cursorColor: _cursorColor,
          decoration: InputDecoration(
            hintText: _hint,
            hintStyle: TextStyle(
              fontSize: _fontSize,
            ),
            border: InputBorder.none,
            icon: Icon(
              _icon,
              color: _cursorColor,
            ),
          ),
          style: TextStyle(
            fontSize: _fontSize,
          ),
          onChanged: (value) {
            user = value;
          },
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  _logIn() {
    final _text = signUp ? "Register" : "Login";
    final _color = AppTheme.darkAccent;
    final _textColor = AppTheme.accentBackground;
    final _textWeight = AppTheme.fontWeightBold;
    final _textSize = 20.0;
    final _radius = 12.0;
    final _padding = 16.0;
    final _shadow = AppTheme.shadow0;

    return Container(
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _action();
          },
          borderRadius: BorderRadius.all(
            Radius.circular(_radius),
          ),
          child: Padding(
            padding: EdgeInsets.all(_padding),
            child: Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textColor,
                fontWeight: _textWeight,
                fontSize: _textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinField extends StatelessWidget {
  final String title;
  final Function onComplete;
  final FocusNode focusNode;

  const PinField(
      {Key? key,
      required this.title,
      required this.onComplete,
      required this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _padding = 16.0;
    final _radius = 16.0;

    final _shadow = AppTheme.shadow0;
    final _background = AppTheme.backGround;

    return Container(
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.all(
          Radius.circular(_radius),
        ),
        boxShadow: [_shadow],
      ),
      child: Padding(
        padding: EdgeInsets.all(_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pinTitle(title),
            VSpace(16),
            _pin(
              context,
              (value) => {onComplete(value)},
            )
          ],
        ),
      ),
    );
  }

  _pin(BuildContext context, Function onComplete) {
    final _innerRadius = 8.0;

    final _textColor = AppTheme.fontColor;
    final _background = AppTheme.backGround;
    final _activeColor = AppTheme.highlight;

    final _shape = PinCodeFieldShape.box;
    final _length = 4;

    final _animation = AnimationType.fade;
    final _animationDuration = Duration(milliseconds: 300);

    return PinCodeTextField(
      appContext: context,
      length: _length,
      obscureText: true,
      animationType: _animation,
      cursorColor: _textColor,
      pinTheme: PinTheme(
        shape: _shape,
        borderRadius: BorderRadius.circular(_innerRadius),
        activeFillColor: _background,
        activeColor: _activeColor,
        selectedColor: _activeColor,
        selectedFillColor: _activeColor,
        inactiveColor: _activeColor,
        inactiveFillColor: _background,
      ),
      animationDuration: _animationDuration,
      enableActiveFill: true,
      onCompleted: (v) => onComplete(v),
      onChanged: (value) => {},
      beforeTextPaste: (text) {
        return false;
      },
      focusNode: focusNode,
      keyboardType: TextInputType.number,
    );
  }

  _pinTitle(title) {
    final _textColor = AppTheme.fontColor;
    final _textSize = 20.0;

    return Row(
      children: [
        Icon(Icons.lock),
        HSpace(4),
        Text(
          title,
          style: TextStyle(
            color: _textColor,
            fontSize: _textSize,
          ),
        ),
      ],
    );
  }
}
