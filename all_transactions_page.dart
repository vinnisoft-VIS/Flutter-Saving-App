import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/controllers/upcoming_transactions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Colors.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({Key? key}) : super(key: key);

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {

  final _upcomingTransactionsController = Get.put(UpcomingTransactionsController());

  @override void initState() {
    _upcomingTransactionsController.fetchUpComingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leadingWidth: 48,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        ),
        centerTitle: true,
        title:const Text(
           'Upcoming Transactions',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),


      ),

      body: Stack(
        children: [
          Image.asset('assets/PageBG.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
          Column(
            children: [
              const SizedBox(height: 16,),
              Expanded(
                child: Obx(
                      ()=> ListView.separated(
                    itemCount: _upcomingTransactionsController.upcomingTransaction.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          height: 60,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child:
                                SvgPicture.asset(_upcomingTransactionsController.upcomingTransaction[index].incomeExpenseType == 1
                                    ? "assets/debited.svg" :
                                    "assets/credited.svg"),
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        _upcomingTransactionsController.upcomingTransaction[index].title.toString(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                    Text(
                                      "${_upcomingTransactionsController.upcomingTransaction[index].dateOfPayment} "
                                          "${_upcomingTransactionsController.upcomingTransaction[index].incomeExpenseType == 1?
                                          " .Expense": " .Income"}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF818A88)),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                _upcomingTransactionsController.upcomingTransaction[index].amount.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _upcomingTransactionsController.upcomingTransaction[index].incomeExpenseType == 1 ?
                                    AppColors.expenseColor : AppColors.incomeColor),
                              ),

                              const SizedBox(width: 16,)
                            ],
                          ),
                        ),
                      );

                    }, separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 8,
                    );
                  },),
                ),
              ),
            ],
          ),
          Obx(
                () => Center(
               child: Visibility(
                visible: _upcomingTransactionsController.showProgress.value,
                child: const SpinKitFadingCircle(
                  color: Color(0xFF3A4FBF),
                  size: 50.0,
                ),
              ),
            ),
          )
        ],
      )

    );
  }
}

