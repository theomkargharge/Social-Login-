import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApI {
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', "https://www.googleapis.com/auth/userinfo.profile"],
  );

  // var ans = googleSignIn.signIn().then((value) {
  //   print(value.authentication.then((googleKey) => ));
  // });

  static Future<GoogleSignInAccount?> login() => googleSignIn.signIn();
  /*.then((result) {
        result?.authentication.then((googleKey) {
          debugPrint(googleKey.toString());
          debugPrint('this is access token ${googleKey.accessToken}');
          debugPrint('this is id token ${googleKey.idToken}');
          // print('This is google access token ${googleKey.accessToken}');
          // print(googleKey.idToken);
          // print(googleSignIn.currentUser?.displayName);
        }).catchError((err) {
          debugPrint(' error');
        });
      }).catchError((err) {
        debugPrint('error occured');
      }); */
  static logOut() => googleSignIn.signOut();
}
