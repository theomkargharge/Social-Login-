import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:googlesignin/googlesign.dart';
import 'package:googlesignin/profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signIN(context) async {
    final user = await GoogleSignInApI.login();
    debugPrint(user.toString());
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  user: user,
                  userData: null,
                )));
  }

  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _cheking = true;

  Future<void> checkFacebookLogin() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _cheking = false;
    });

    if (accessToken != null) {
      debugPrint(accessToken.token);
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;

      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      debugPrint(_userData.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(
                    user: null,
                    userData: userData,
                  )));
    } else {
      debugPrint(result.status.toString());
      debugPrint(result.message.toString());
    }
    setState(() {
      _cheking = false;
    });
  }

  _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          ' Social Login ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://www.intotheminds.com/blog/app/uploads/social-media-marketing-smm-banner.jpg',
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            left: 80,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () => signIN(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              width: 50,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                            const Text(
                              'Google Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () => _login(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Facebook_Logo_2023.png/900px-Facebook_Logo_2023.png',
                              width: 36,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                            const Text(
                              'Facebook Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
