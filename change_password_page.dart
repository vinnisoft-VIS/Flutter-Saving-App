import 'package:flutter/material.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_projects/controllers/change_password_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _changePasswordController = Get.put(ChangePasswordController());




  @override void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leadingWidth: 48,
        centerTitle: true,
        title: const Text(
          Strings.changePassword,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        )  ,

      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset('assets/PageBG.png',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
              Form(
                key: _changePasswordController.changePasswordKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          Strings.oldPassword,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                              border: Border.all(width: 1.0,color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16),
                              child: TextFormField(
                                controller: _changePasswordController.oldPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Strings.oldPassword,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF848484))
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          Strings.newPassword,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                              border: Border.all(width: 1.0,color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16),
                              child: TextFormField(
                                controller: _changePasswordController.newPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText:  Strings.newPassword,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF848484))
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          Strings.confirmPassword,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                              border: Border.all(width: 1.0,color: Colors.black12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16,right: 16),
                              child: TextFormField(
                                controller: _changePasswordController.confirmPasswordController,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText:  Strings.confirmPassword,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF848484))
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                      ),
                      const SizedBox(height: 32,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.themeColor,
                            ),
                            child: TextButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_changePasswordController.oldPasswordController.text.isEmpty) {
                                    Get.snackbar("Alert", "Please enter old password");
                                  } else if (_changePasswordController.newPasswordController.text.isEmpty) {
                                    Get.snackbar("Alert", "Please enter new password");
                                  } else if (_changePasswordController.confirmPasswordController.text.isEmpty) {
                                    Get.snackbar("Alert", "Please enter confirm password");
                                  } else if (_changePasswordController.newPasswordController.text != _changePasswordController.confirmPasswordController.text){
                                    Get.snackbar("Alert", "New password and confirm password must be same.");
                                  } else {
                                    var oldPassword = _changePasswordController.oldPasswordController.text.toString().trim();
                                    var newPassword = _changePasswordController.newPasswordController.text.toString().trim();
                                    var confirmPassword = _changePasswordController.confirmPasswordController.text.toString().trim();

                                    _changePasswordController.changePassword(oldPassword, newPassword, confirmPassword);
                                  }
                                },
                                child: const Text(
                                  Strings.changePassword,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                            )
                        ),
                      ),
                      const SizedBox(height: 32,)

                    ],
                  ),
                ),
              )
            ],
          ),
          Obx(
                () => Center(
              child: Visibility(
                visible: _changePasswordController.showProgress.value,
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
