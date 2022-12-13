
import 'package:flutter/material.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/forgot_password_controller.dart';

class AddSavingsPage extends StatefulWidget {
  const AddSavingsPage({Key? key}) : super(key: key);

  @override
  _AddSavingsPage createState() => _AddSavingsPage();
}

class _AddSavingsPage extends State<AddSavingsPage> {

  final _forgotPasswordController = Get.put(ForgotPasswordController());



  @override
  Widget build(BuildContext context) {
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
            key: _forgotPasswordController.forgotPasswordFormKey,
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
                    onChanged: (text){



                    },
                      controller: _forgotPasswordController.forgotPasswordEmailController,
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
                          hintText: Strings.currentSavingBalance,
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
                  child: SizedBox(
                    height: 62,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        if (_forgotPasswordController.forgotPasswordEmailController.text.isEmpty) {
                          Get.snackbar("Alert", "Please enter your email address");
                        } else {
                          _forgotPasswordController.forgotPassword();
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                        AppColors.themeColor, // Background Color
                      ),
                      child: const Text(
                        Strings.submit,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Obx(
                () => Center(
              child: Visibility(
                visible: _forgotPasswordController.showProgress.value,
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
}
