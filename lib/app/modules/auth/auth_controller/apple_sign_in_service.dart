import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {
  Future<Map<String, String>?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print('Apple Sign-In Credential: userIdentifier=${credential.userIdentifier}, email=${credential.email}, givenName=${credential.givenName}, familyName=${credential.familyName}');

      // Handle cases where email or name might be null
      final email = credential.email ?? 'unknown_apple_user_${credential.userIdentifier ?? 'unknown'}@example.com';
      final fullName = (credential.givenName != null && credential.familyName != null)
          ? '${credential.givenName} ${credential.familyName}'
          : credential.givenName ?? 'Apple User';

      return {
        'email': email,
        'fullname': fullName,
      };
    } catch (error, stackTrace) {
      print('Apple Sign-In Error: $error');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}