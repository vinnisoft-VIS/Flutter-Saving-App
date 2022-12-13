import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_projects/pages/sign_up_page.dart';
import 'package:flutter_projects/pages/forgot_password_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../controllers/login_controller.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn(

    scopes: [
      'email'
    ]
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  final _loginController = Get.put(LoginController());
  GoogleSignInAccount? _currentUser;

  bool isLoggedIn = false;
  Map fbUserData = {};
  var currentDevice = "";


  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _currentUser = account;
      var userName = account?.displayName;

      var userEmail = account?.email;
      var socialId = account?.id;
      var photoUrl = account?.photoUrl;

      if (Platform.isAndroid) {
        setState(() {
          currentDevice = Strings.android;
        });
      } else {
        setState(() {
          currentDevice = Strings.ios;
        });
      }

      _loginController.socialLogin(userName!, userEmail!, socialId!, Strings.google, photoUrl!, currentDevice);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/PageBG.png',
              fit: BoxFit.fill,
            ),
          ),
          Form(
            key: _loginController.loginFormKey,
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                Center(
                    child: Image.asset(
                  'assets/appIcon.png',
                  height: 90,
                  width: 90,
                )),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  Strings.appName,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    controller: _loginController.loginEmailController,
                      style: const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 10.0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 12, bottom: 12, right: 10),
                            child: Image.asset(
                              'assets/mail.png',
                              width: 21,
                              height: 16,
                              fit: BoxFit.fill,
                            ),
                          ),
                          hintText: Strings.yourEmail,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Color(0xFFbdc6cf)),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: const BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 1),
                          ))),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    controller: _loginController.loginPasswordController,
                     obscureText: !_isPasswordVisible,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 10.0),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10, right: 10),
                            child: Image.asset(
                              'assets/lock.png',
                              width: 16,
                              height: 16,
                              fit: BoxFit.fill,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 8, top: 8, bottom: 8),
                            child: IconButton(
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,color: Color(0xFFD0D2D1),),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          hintText: Strings.password,
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Color(0xFFbdc6cf)),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.textFieldBorderColor,
                                width: 1),
                          ))),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        if (_loginController.loginEmailController.value.text.isEmpty) {
                          Get.snackbar("Alert", "Please enter email address");
                        } else if (_loginController.loginPasswordController.value.text.isEmpty) {
                          Get.snackbar("Alert", "Please enter your password");
                        } else {
                          _loginController.loginUser();
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                            AppColors.themeColor, // Background Color
                      ),
                      child: const Text(
                        Strings.login,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(Strings.forgotPassword + "?",
                      style: TextStyle(
                      fontSize: 16,
                        color: Color(0xFF93A1B2)
                    ),),
                    TextButton(onPressed: (){
                      Get.to(const ForgotPasswordPage());
                    }, child: const Text(Strings.recoverHere,style: TextStyle(color: Colors.black, fontSize: 16),))
                  ],
                ),
                const Text(Strings.or,style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9796A1)),),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white
                      ),
                      onPressed: () {
                        signIn();
                      },
                      icon: Image.asset('assets/google.png', height: 20, width: 20,),
                      label: const Text(Strings.loginWithGmail,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white
                      ),
                      onPressed: () {
                        FacebookAuth.instance.login(
                          permissions: ["public_profile", "email"]
                        ).then((value) => {

                          if(value.status == LoginStatus.success){
                            FacebookAuth.instance.getUserData().then((userData) => {
                              _loginController.socialLogin(userData["name"], userData["email"], userData["id"],
                                  Strings.facebook, userData["picture"]["data"]["url"], currentDevice)
                            })
                          }




                        });
                      },
                      icon:  Image.asset('assets/facebook.png', height: 24, width: 24,),
                      label: const Text(Strings.loginWithFacebook,style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Platform.isIOS ? SizedBox(
                //     height: 62,
                //     width: MediaQuery.of(context).size.width,
                //     child: ElevatedButton.icon(
                //       style: ElevatedButton.styleFrom(
                //           primary: Colors.white
                //       ),
                //       onPressed: () async {
                //         final appleIdCredential = await SignInWithApple.getAppleIDCredential(
                //           scopes: [
                //             AppleIDAuthorizationScopes.email,
                //             AppleIDAuthorizationScopes.fullName,
                //
                //           ],
                //         );
                //
                //         print(appleIdCredential.email);
                //         // final oAuthProvider = OAuthProvider('apple.com');
                //         // final credential = oAuthProvider.credential(
                //         //   idToken: appleIdCredential.identityToken,
                //         //   accessToken: appleIdCredential.authorizationCode,
                //         // );
                //        // await FirebaseAuth.instance.signInWithCredential(credential);
                //       },
                //       icon:  const Icon(Icons.apple,color: Colors.black, size: 32.0,),
                //       label: const Text(Strings.loginWithApple,style: TextStyle(
                //           fontWeight: FontWeight.w500,
                //           fontSize: 16,color: Colors.black),
                //       ),
                //     ),
                //   ): Container(),
                // ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const Text(Strings.dontHaveAnAccount + "?",style: TextStyle(
                        fontSize: 16,
                      color: Color(0xFF93A1B2)
                    ),
                    ),
                    TextButton(onPressed: (){
                      Get.to(SignUpPage());
                    }, child: const Text(Strings.signUp,style: TextStyle(color: Colors.black, fontSize: 16),))
                  ],
                ),
                const SizedBox(height: 16,)
              ],
            ),
          )
          ),
          Obx(
                () => Center(
              child: Visibility(
                visible: _loginController.showProgress.value,
                child: const SpinKitFadingCircle(
                  color: Color(0xFF3A4FBF),
                  size: 50.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//MARK: - GOOGLE SIGN OUT
  void signOut() {
    _googleSignIn.disconnect();
  }

//MARK: - GOOGLE SIGN IN
  Future<void> signIn() async {

    try {

      await _googleSignIn.signOut();
      await _googleSignIn.signIn();

    } catch (error){
      print(error);
    }
  }



}
