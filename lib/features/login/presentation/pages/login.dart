import 'package:flutter/cupertino.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/login_body.dart';
import 'package:jobsity_flutter_challenge/features/login/presentation/widgets/login_header.dart';
import 'package:jobsity_flutter_challenge/shared/pages/simple_body.dart';
import 'package:jobsity_flutter_challenge/shared/widgets/simple_header.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleBody(
      header: SimpleHeader(),
      body: LoginBody(),
      scrollable: false,
      headerHaveHeight: false,
    );
  }
}
