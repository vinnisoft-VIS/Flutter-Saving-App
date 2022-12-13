import 'package:flutter/material.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/controllers/app_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/tarnsactions_controller.dart';

class DailyTransactionsPage extends StatefulWidget {
  const DailyTransactionsPage({Key? key}) : super(key: key);

  @override
  State<DailyTransactionsPage> createState() => _DailyTransactionsPageState();
}

class _DailyTransactionsPageState extends State<DailyTransactionsPage> {
  final _transactionsController = Get.put(TransactionsController());

  DateTime today = DateTime.now();

  final _inputFormat = DateFormat('EEEE, MMMM dd,yyyy');
  var _selectedDate = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _transactionsController.appBarTitle.value = Strings.dailyForecast;

      _transactionsController.fetchDailyForcast(
          date: DateFormat('dd-MM-yyyy')
              .format(_transactionsController.currentDate.value));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset('assets/PageBG.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
          ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed: () {
                          _transactionsController.getPreviousDayData();
                        },
                        icon: Obx(
                          () => SvgPicture.asset(
                            "assets/backward.svg",
                            height: 15,
                            color: DateUtils.dateOnly(_transactionsController.currentDate.value)
                                    .isAfter(DateUtils.dateOnly(_transactionsController
                                .userCreatedDate ??
                                DateTime.now()))
                                ? Colors.black
                                : Colors.black.withOpacity(0.1),
                          ),
                        )),
                    Expanded(
                      child: Obx(
                        () => Text(
                            DateFormat('EEEE, MMMM dd, yyyy').format(
                                _transactionsController.currentDate.value),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.black)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _transactionsController.getNextDayData();
                          });
                        },
                        icon: SvgPicture.asset(
                          "assets/forward.svg",
                          height: 15,
                        )),
                  ],
                ),
              ),
              Stack(
                children: [
                  Obx(
                    () => _transactionsController.dailyForecast.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                            itemCount:
                                _transactionsController.dailyForecast.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Slidable(
                                  endActionPane:
                                  ActionPane(motion: StretchMotion(), children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        _transactionsController
                                            .deleteTransaction(index,TransactionType.daily);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      label: 'Delete',
                                    )
                                  ]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.white,
                                    ),
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: SvgPicture.asset(
                                              _transactionsController
                                                          .dailyForecast[index]
                                                          .incomeExpenseType ==
                                                      1
                                                  ? "assets/debited.svg"
                                                  : "assets/credited.svg"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  _transactionsController
                                                      .dailyForecast[index].title
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              //"Feb 1 . Expense"
                                              Text(
                                                "${_transactionsController.dailyForecast[index].dateOfPayment} ${_transactionsController.dailyForecast[index].incomeExpenseType == 1 ? ' .Expense' : ' .Income'}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF818A88)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _transactionsController
                                                    .dailyForecast[index]
                                                    .incomeExpenseType ==
                                                1
                                            ? Text(
                                                "${_transactionsController.dailyForecast[index].amount}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: _transactionsController
                                                                .dailyForecast[
                                                                    index]
                                                                .incomeExpenseType ==
                                                            1
                                                        ? AppColors.expenseColor
                                                        : AppColors.expenseColor),
                                              )
                                            : Text(
                                                "${_transactionsController.dailyForecast[index].amount}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: _transactionsController
                                                                .dailyForecast[
                                                                    index]
                                                                .incomeExpenseType ==
                                                            1
                                                        ? AppColors.expenseColor
                                                        : AppColors.incomeColor),
                                              ),
                                        const SizedBox(
                                          width: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Image.asset('assets/ic_no_data.gif'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          Obx(
            () => Center(
              child: Visibility(
                visible: _transactionsController.showProgress.value,
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
