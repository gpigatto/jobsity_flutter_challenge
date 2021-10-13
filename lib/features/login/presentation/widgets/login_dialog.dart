import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobsity_flutter_challenge/core/infrastructure/service_locator.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/check_biometric_command.dart';
import 'package:jobsity_flutter_challenge/features/login/domain/commands/register_command.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/check_biometric_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/get_logged_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/login_biometric_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/register_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/save_biometric_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/bloc/user_exist_bloc.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/utils/validation.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/login_button.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/pin_field.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/username_field.dart';
import 'package:jobsity_flutter_challenge/shared/app_theme.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/space.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/toast.dart';
import 'package:local_auth/local_auth.dart';

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
        BlocProvider<CheckBiometricBloc>(
          create: (_) => CheckBiometricBloc(serviceLocator()),
        ),
        BlocProvider<UserExistBloc>(
          create: (_) => UserExistBloc(serviceLocator()),
        ),
        BlocProvider<LoginBiometricBloc>(
          create: (_) => LoginBiometricBloc(serviceLocator()),
        ),
        BlocProvider<SaveBiometricBloc>(
          create: (_) => SaveBiometricBloc(serviceLocator()),
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
  final LocalAuthentication auth = LocalAuthentication();

  final pinFocus = FocusNode();
  final confirmPinFocus = FocusNode();

  bool signedUp = false;

  String user = "";
  String pin = "";
  String confirmPin = "";

  CheckBiometricClass biometric = CheckBiometricClass(
    device: false,
    user: false,
  );

  bool userChecked = false;

  // get pin from keychain using biometric
  _loginByBiometric() async {
    final _message = "Please, Verify your identity";

    if (biometric.user && await auth.authenticate(localizedReason: _message)) {
      context.read<LoginBiometricBloc>().add(LoginBiometricLoad(user));
    }
  }

  // bloc handler to check if user + pin match
  _loginBlocHandler(stateContext, state) async {
    if (state is LoginLoaded) {
      if (state.correct) {
        CustomToast().successToast("Welcome!", ToastGravity.BOTTOM);

        context.read<GetLoggedBloc>().add(GetLoggedLoad());

        Navigator.pop(context);
      } else {
        CustomToast().errorToast("Invalid User..", ToastGravity.BOTTOM);
      }
    } else if (state is LoginError) {
      CustomToast().errorToast("Something went wrong..", ToastGravity.BOTTOM);
    }
  }

  // bloc handler to save biometric after register and login
  _registerBlocHandler(stateContext, state) async {
    final _message = "Please, Verify your identity";

    if (state is RegisterLoaded) {
      if (biometric.device &&
          await auth.authenticate(localizedReason: _message)) {
        context.read<SaveBiometricBloc>().add(
              SaveBiometricLoad(
                LoginClass(
                  username: user,
                  pin: pin,
                ),
              ),
            );
      }

      context.read<LoginBloc>().add(
            LoginLoad(
              LoginClass(
                username: user,
                pin: pin,
              ),
            ),
          );
    } else if (state is RegisterError) {
      CustomToast().errorToast("Something went wrong..", ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        BlocListener<CheckBiometricBloc, CheckBiometricState>(
          listener: (context, state) {
            if (state is CheckBiometricLoaded) {
              biometric = state.checkBiometricClass;
            }
          },
        ),
        BlocListener<UserExistBloc, UserExistState>(
          listener: (context, state) {
            if (state is UserExistLoaded) {
              setState(() {
                userChecked = true;
                signedUp = state.exist;
              });

              if (state.exist) {
                _loginByBiometric();
              }
            }
          },
        ),
        BlocListener<LoginBiometricBloc, LoginBiometricState>(
          listener: (context, state) {
            if (state is LoginBiometricLoaded) {
              if (state is LoginBiometricLoaded) {
                context.read<LoginBloc>().add(
                      LoginLoad(
                        LoginClass(
                          username: state.login_information.username,
                          pin: state.login_information.pin,
                        ),
                      ),
                    );
              }
            }
          },
        ),
      ],
      child: _dialog(),
    );
  }

  _dialog() {
    final _radius = 16.0;
    final _padding = 120.0;

    final _minSize = MainAxisSize.min;

    return AlertDialog(
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
                  UsernameField(
                    onChage: (value) {
                      user = value;
                    },
                    onSubmit: () {
                      _checkUser();
                      FocusScope.of(context).requestFocus(pinFocus);
                    },
                  ),
                  if (!userChecked)
                    _userCheckStep()
                  else if (userChecked && signedUp)
                    _loginStep()
                  else
                    _registerStep()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _title() {
    final _title = userChecked && !signedUp ? "Register" : "Login";
    final _textColor = AppTheme().fontColors.base;
    final _fontWeight = AppTheme().appFontWeight.bold;
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

  _validateFields() {
    return Validation().validateFields(
      user,
      pin,
      confirmPin,
      userChecked,
      signedUp,
    );
  }

  _registerStep() {
    final _align = CrossAxisAlignment.stretch;

    return Column(
      crossAxisAlignment: _align,
      children: [
        VSpace(24),
        PinField(
          title: "Pin",
          onComplete: (value) {
            pin = value;

            FocusScope.of(context).requestFocus(confirmPinFocus);
          },
          focusNode: pinFocus,
        ),
        VSpace(24),
        PinField(
          title: "Confirm Pin",
          onComplete: (value) {
            confirmPin = value;
            _register();
          },
          focusNode: confirmPinFocus,
        ),
        VSpace(24),
        LoginButton(label: "Register", function: () => _register()),
      ],
    );
  }

  _register() {
    if (_validateFields()) return null;

    context.read<RegisterBloc>().add(
          RegisterLoad(
            LoginClass(
              username: user,
              pin: pin,
            ),
          ),
        );
  }

  _loginStep() {
    final _align = CrossAxisAlignment.stretch;

    return Column(
      crossAxisAlignment: _align,
      children: [
        VSpace(24),
        PinField(
          title: "Pin",
          onComplete: (value) {
            pin = value;

            _login();
          },
          focusNode: pinFocus,
        ),
        VSpace(24),
        LoginButton(label: "Login", function: () => _login()),
      ],
    );
  }

  _login() {
    if (_validateFields()) return null;

    context.read<LoginBloc>().add(
          LoginLoad(
            LoginClass(
              username: user,
              pin: pin,
            ),
          ),
        );
  }

  _userCheckStep() {
    final _align = CrossAxisAlignment.stretch;

    return Column(
      crossAxisAlignment: _align,
      children: [
        VSpace(24),
        LoginButton(label: "Next", function: () => _checkUser()),
      ],
    );
  }

  _checkUser() {
    if (_validateFields()) return null;

    context.read<UserExistBloc>().add(UserExistLoad(user));
    context.read<CheckBiometricBloc>().add(CheckBiometricLoad(user));
  }
}
