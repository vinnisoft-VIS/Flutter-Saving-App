import 'package:flutter/material.dart';
import 'package:flutter_projects/pages/tabbar_page.dart';
import 'package:flutter_projects/slide_dot.dart';
import 'package:get/get.dart';
import 'package:flutter_projects/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../preferences/pref_keys.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  PageController pageController = PageController(initialPage: 0);
  int pageChanged = 0;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String btnTitle = "Skip";


  @override void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              pageChanged = index;
              if (index==3) {
                setState(() {
                  btnTitle = "Next";
                });
              } else {
                setState(() {
                  btnTitle = "Skip";
                });
              }
              print(index);
            });
          },
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white10,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/OBRedBG.png',fit: BoxFit.fill,),
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/OB1.png',width: 280,),
                          const SizedBox(height: 24,),
                         const Text("TRACK EXPENSES", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 16,),
                          const Padding(
                            padding: EdgeInsets.only(left: 60,right: 60),
                            child: Text("Track all bills and stay ahead of upcoming expenses.",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),

            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white10,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/OBGreenBG.png',fit: BoxFit.fill,),
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/OB2.png',width: 280,),
                          const SizedBox(height: 24,),
                          const Text("TRACK INCOME", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 16,),
                          const Padding(
                            padding: EdgeInsets.only(left: 60,right: 60),
                            child: Text("Track all income and stay ahead of upcoming payments made to you.",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),

            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white10,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/OBBlueBG.png',fit: BoxFit.fill,),
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/OB3.png',width: 280,),
                          const SizedBox(height: 24,),
                          const Text("FORECAST SAVINGS", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 16,),
                          const Padding(
                            padding: EdgeInsets.only(left: 60,right: 60),
                            child: Text("Forecast income, expenses, and savings for the week, month, year, or next 5 years.",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),

            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white10,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/OBYellowBG.png',fit: BoxFit.fill,),
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/OB4.png',width: 280,),
                          const SizedBox(height: 24,),
                          const Text("FORECAST GOAL DATES", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(height: 16,),
                          const Padding(
                            padding: EdgeInsets.only(left: 60,right: 60),
                            child: Text("Forecast the day you'll have enough for that new phone, car,  house, or special gift.",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                          )
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i<4; i++)
                    if ( i == pageChanged)
                      SlideDots(true)
                    else
                      SlideDots(false)
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, right: 16),
            child: TextButton(onPressed: (){
              Get.offAll(const LoginPage());
            }, child: Text(btnTitle,style:
               const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),)),
          ),
        )
      ],
    ),
  );

  void getToken() async {
    SharedPreferences pref = await _pref;
    String token = pref.getString(PrefKeys.keyUserToken) ?? '';
    print(token);
    // if (token != null) {
    //   Get.offAll(const TabBarPage(title: "", currentIndex: 0,));
    // }
  }

}

