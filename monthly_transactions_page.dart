import 'package:flutter/material.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliver_bar_chart/sliver_bar_chart.dart';
import '../controllers/tarnsactions_controller.dart';

class MonthlyTransactionsPage extends StatefulWidget {
  const MonthlyTransactionsPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _MonthlyTransactionsPageState createState() =>
      _MonthlyTransactionsPageState();
}

class _MonthlyTransactionsPageState extends State<MonthlyTransactionsPage> {
  final _transactionsController = Get.put(TransactionsController());
  bool isOpened = false;
  var _selectedDate = DateTime.now();
  var currentMonthName = "";

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _transactionsController.appBarTitle.value = Strings.monthlyForecast;

      _transactionsController.fetchMonthlyTransactions(
          year: _transactionsController.currentDate.value.year.toString(),
          month: _transactionsController.currentDate.value.month.toString());
    });
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
          SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _transactionsController
                                        .getPreviousMonthData();
                                  },
                                  icon:
                                  Obx(
                                    () => SvgPicture.asset(
                                      "assets/backward.svg",
                                      height: 15,
                                      color: DateTime(_transactionsController.currentDate.value.year,_transactionsController.currentDate.value.month).isAfter(DateTime(_transactionsController.userCreatedDate.year,_transactionsController.userCreatedDate.month))

                                          ? Colors.black
                                          : Colors.black.withOpacity(0.1),
                                    ),
                                  )),
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: Strings.financialForecast,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: DateFormat('MMM,yyyy').format(
                                              _transactionsController
                                                  .currentDate.value),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _transactionsController.getNextMonthData();
                                  },
                                  icon: SvgPicture.asset(
                                      "assets/forward.svg",
                                      height: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Divider(
                              thickness: 0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 24, top: 8),
                                        child: Text(
                                          Strings.savings,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, top: 4),
                                        child: Text(
                                          _transactionsController
                                              .monthTotalSaving.value
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.themeColor),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 24, top: 8),
                                        child: Text(
                                          Strings.savingsToDate,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24, top: 4),
                                        child: Text(
                                          _transactionsController.saving.value
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.themeColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverBarChart(
                                          restrain: false,
                                          fluctuating: false,
                                          minHeight: 150.0,
                                          maxHeight: 150.0,
                                          maxWidth: 30.0,
                                          barWidget: BarChartWidget(
                                            maxHeight: 200.0,
                                            minHeight: 0.0,
                                            barValues: [
                                              BarChartData(
                                                x: '',
                                                y: 75.0,
                                                barColor: AppColors.incomeColor,
                                              ),
                                              BarChartData(
                                                x: '',
                                                y: 50.0,
                                                barColor:
                                                    AppColors.expenseColor,
                                              ),
                                              BarChartData(
                                                x: '',
                                                y: 25.0,
                                                barColor: AppColors.themeColor,
                                              ),
                                            ],
                                            isScrolling: true,
                                            yAxisIntervalCount: 3,
                                            xAxisTextRotationAngle: 180.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Divider(
                              thickness: 0.5,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      const Text(
                                        Strings.income,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        _transactionsController.income.value
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.incomeColor),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      const Text(
                                        Strings.expenses,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        _transactionsController.expense.value,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.expenseColor),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 24),
                    child: Text(
                      "$currentMonthName " + Strings.totalsByCategory,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount:
                          _transactionsController.monthlyTransactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  child: SvgPicture.asset(
                                      _transactionsController
                                                  .monthlyTransactions[index]
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      _transactionsController
                                          .monthlyTransactions[index].title
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Text(
                                  _transactionsController
                                      .monthlyTransactions[index].amount
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _transactionsController
                                                  .monthlyTransactions[index]
                                                  .incomeExpenseType ==
                                              1
                                          ? const Color(0xFFED4242)
                                          : AppColors.incomeColor),
                                ),
                                const SizedBox(
                                  width: 16,
                                )
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: Image.asset('assets/ic_forward.png', height: 15,),)
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
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
