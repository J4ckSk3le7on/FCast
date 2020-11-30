import 'package:f_cast/src/config/auth_variables.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthVariables) //TODO env config
class DevAuthVariables extends AuthVariables {
  @override
  String get appleClientId => "com.whitewhiskywolf.fCast";

  @override
  String get appleRedirectUri =>
      "https://f-cast-55b1d.firebaseapp.com/__/auth/handler";
}
