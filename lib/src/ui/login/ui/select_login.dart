import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/common/ui/platform_scaffold.dart';
import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectLoginPage extends PlatformPage {
  SelectLoginPage()
      : super(
          SelectLoginWidget(),
          "select login",
          title: "Select Login",
        );
}

class SelectLoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var signInCubit = BlocProvider.of<SignInCubit>(context);
    var authCubit = BlocProvider.of<AuthenticationCubit>(context);
    return PlatformScaffold(
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.podcast,
                  size: 200,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Let's Get Started",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Flexible(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          onPressed: () => signInCubit.selectRegister(),
                          child: Text("Crate New Account"),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          onPressed: () => signInCubit.selectLogin(),
                          child: Text("Login With Email"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "OR",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.white,
                        child: Text(
                          "Continue with Google",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black),
                        ),
                        onPressed: () => authCubit.signInWithGoogle(),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.black,
                        child: Text(
                          "Continue with Apple",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () => authCubit.signInWithApple(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
