import 'package:f_cast/src/extensions/string_extensions.dart';
import 'package:f_cast/src/ui/common/ui/keyboard_visibility_builder.dart';
import 'package:f_cast/src/ui/common/ui/platform_icon.dart';
import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/common/ui/platform_scaffold.dart';
import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterWithEmailPage extends PlatformPage {
  RegisterWithEmailPage()
      : super(
          RegisterWithEmailWidget(),
          "register with email",
          title: "register",
        );
}

class RegisterWithEmailWidget extends StatefulWidget {
  @override
  _RegisterWithEmailWidgetState createState() =>
      _RegisterWithEmailWidgetState();
}

class _RegisterWithEmailWidgetState extends State<RegisterWithEmailWidget> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmController = TextEditingController();

  String _errorText;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      child: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        child: KeyboardVisibilityBuilder(
          builder: (BuildContext context, bool isKeyboardOpen) {
            return Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: PlatformIcon(
                      size: 24,
                      materialIcon: Icons.arrow_back,
                      cupertinoIcon: CupertinoIcons.back,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Flexible(
                  flex: isKeyboardOpen ? 1 : 3,
                  child: FaIcon(
                    FontAwesomeIcons.podcast,
                    color: Colors.white,
                    size: isKeyboardOpen ? 100 : 200,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_errorText != null && _errorText.isNotEmpty)
                            Text(
                              _errorText,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).errorColor),
                            ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) => value.isEmail()
                                ? null
                                : "Please enter a valid email",
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) => value.isNotEmpty
                                ? null
                                : "Please enter a password",
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _confirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            validator: (value) =>
                                value == _passwordController.text
                                    ? null
                                    : "Passwords do not match",
                          ),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text("Create Account"),
                              shape: StadiumBorder(),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  var signInCubit =
                                      BlocProvider.of<AuthenticationCubit>(
                                          context);
                                  var result =
                                      await signInCubit.registerWithEmail(
                                          _emailController.text,
                                          _passwordController.text,
                                          _confirmController.text);
                                  if (!result) {
                                    setState(() {
                                      _errorText = "Unable to register";
                                    });
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    child: Text(
                      "Already have an account? Login Now!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      var signInCubit = BlocProvider.of<SignInCubit>(context);
                      signInCubit.selectLogin();
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
