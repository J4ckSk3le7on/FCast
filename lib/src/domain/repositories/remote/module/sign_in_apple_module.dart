import 'package:f_cast/src/config/auth_variables.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@injectable
class SignInAppleModule {
  final AuthVariables authVariables;

  SignInAppleModule(this.authVariables);

  Future<AuthorizationCredentialAppleID> getSignInWithAppleResult() async {
    return SignInWithApple.getAppleIDCredential(
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: authVariables.appleClientId,
        redirectUri: Uri.parse(
          authVariables.appleRedirectUri,
        ),
      ),
      scopes: [AppleIDAuthorizationScopes.email],
    );
  }
}
