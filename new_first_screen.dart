import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/controllers/new_first_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colors.dart';
import '../Strings.dart';
import '../preferences/pref_keys.dart';
import 'login_page.dart';

class NewFirstScreen extends StatefulWidget {
   NewFirstScreen({Key? key}) : super(key: key);

  final _newFirstController = Get.put(NewFirstController());



  @override
  State<NewFirstScreen> createState() => _NewFirstScreenState();
}




class _NewFirstScreenState extends State<NewFirstScreen> {


  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/PageBG.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),

          Column(
            children: [
              const SizedBox(height: 100,),
              Center(
                  child: Image.asset(
                    'assets/ic_new_logo.png',
                    height: 140,
                    width: 200,
                  )),
              const SizedBox(height: 32,),
              const Text('Financial app that helps\ntrack and forecast future\nincome, expenses,\nsavings and debt payoff.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  //height: 2,
                  fontSize: 20,
                  color: Colors.black,
                  // letterSpacing: 1,
                  // wordSpacing: 1

                ),
              ),
              Expanded(
                child: Image.asset('assets/ic_background_new.png', fit: BoxFit.fitHeight,),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(const LoginPage());
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:
                      AppColors.themeColor, // Background Color
                    ),
                    child: const Text(
                      Strings.registerOrLogin,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32,),
            ],
          )

        ],
      ),
    );
  }
}
