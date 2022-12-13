import 'package:flutter/material.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/all_transactions_filter_controller.dart';

class AddTransactionsFilterPage extends StatefulWidget {
  const AddTransactionsFilterPage({Key? key}) : super(key: key);
  @override
  State<AddTransactionsFilterPage> createState() => _AddTransactionsFilterPage();
}

class _AddTransactionsFilterPage extends State<AddTransactionsFilterPage> {

  final _allTransactionsFilterController = Get.put(AllTransactionsFilterController());

  int _selectedIndex = -1;
  String categoryId = "";
  String categoryName = "";

  @override void initState() {
    super.initState();
    _allTransactionsFilterController.showHideDateView.value = false;
    _allTransactionsFilterController.showHideExpenseView.value = true;
    _allTransactionsFilterController.showHideCategoryView.value = false;
    _allTransactionsFilterController.filterType.value = 0;
    _allTransactionsFilterController.fetchCategories();
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
          Strings.dailyForecast,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back(result: 'Yes');
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        )  ,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: [
                Image.asset('assets/PageBG.png',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 60,
                            color: const Color(0xFFFCFCFC),
                            width: MediaQuery.of(context).size.width,
                            child: Obx(
                                  ()=> Row(
                                children: [
                                  IconButton(onPressed: () {

                                  }, icon: Image.asset('assets/ic_filter.png',
                                    height: 24, width: 24,),),

                                  GestureDetector(
                                    onTap: () {
                                      _allTransactionsFilterController.incomeExpenseType.value = 1;
                                      _allTransactionsFilterController.showHideDateView.value = false;
                                      _allTransactionsFilterController.showHideExpenseView.value = true;
                                      _allTransactionsFilterController.showHideCategoryView.value = false;
                                      _allTransactionsFilterController.filterType.value = 0;
                                      _allTransactionsFilterController.maxController.text = "";
                                      _allTransactionsFilterController.minController.text = "";


                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: _allTransactionsFilterController.filterType.value == 0?
                                        AppColors.themeColor:
                                        Colors.black.withAlpha(30),
                                      ),
                                      child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8),
                                            child: Text('Expenses',
                                              style: TextStyle(
                                                color: _allTransactionsFilterController.filterType.value == 0?
                                                Colors.white:
                                                Colors.black.withAlpha(70),
                                              ),),
                                          )
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8,),
                                  GestureDetector(
                                    onTap: () {
                                      _allTransactionsFilterController.incomeExpenseType.value = 0;
                                      _allTransactionsFilterController.showHideDateView.value = false;
                                      _allTransactionsFilterController.showHideCategoryView.value = false;
                                      _allTransactionsFilterController.showHideExpenseView.value = true;
                                      _allTransactionsFilterController.filterType.value = 1;
                                      _allTransactionsFilterController.maxController.text = "";
                                      _allTransactionsFilterController.minController.text = "";
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: _allTransactionsFilterController.filterType.value == 1?
                                        AppColors.themeColor:
                                        Colors.black.withAlpha(30),
                                      ),
                                      child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8),
                                            child: Text('Income',
                                              style: TextStyle(
                                                color: _allTransactionsFilterController.filterType.value == 1?
                                                Colors.white:
                                                Colors.black.withAlpha(70),
                                              ),),
                                          )
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8,),
                                  GestureDetector(
                                    onTap: () {
                                      _allTransactionsFilterController.showHideDateView.value = false;
                                      _allTransactionsFilterController.showHideCategoryView.value = true;
                                      _allTransactionsFilterController.showHideExpenseView.value = false;
                                      _allTransactionsFilterController.filterType.value = 2;
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: _allTransactionsFilterController.filterType.value == 2?
                                        AppColors.themeColor:
                                        Colors.black.withAlpha(30),
                                      ),
                                      child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8),
                                            child: Text('Categories',
                                              style: TextStyle(
                                                color: _allTransactionsFilterController.filterType.value == 2?
                                                Colors.white:
                                                Colors.black.withAlpha(70),
                                              ),),
                                          )
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8,),
                                  GestureDetector(
                                    onTap: () {
                                      _allTransactionsFilterController.showHideDateView.value = true;
                                      _allTransactionsFilterController.showHideCategoryView.value = false;
                                      _allTransactionsFilterController.showHideExpenseView.value = false;
                                      _allTransactionsFilterController.filterType.value = 3;
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: _allTransactionsFilterController.filterType.value == 3?
                                        AppColors.themeColor:
                                        Colors.black.withAlpha(30),
                                      ),
                                      child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8, right: 8),
                                            child: Text('Date',
                                              style: TextStyle(
                                                color: _allTransactionsFilterController.filterType.value == 3?
                                                Colors.white:
                                                Colors.black.withAlpha(70),
                                              ),),
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //MARK: - EXPENSE AND INCOME VIEW
                          Obx(
                                ()=> Visibility(
                              visible: _allTransactionsFilterController.showHideExpenseView.value,
                              child: Container(
                                color: Colors.transparent,
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Choose a range below',
                                            style: TextStyle(
                                                color: Color(0xFF6B7580),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400
                                            ),),
                                          const SizedBox(height: 16,),
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 16),
                                              child: TextFormField(
                                                  controller: _allTransactionsFilterController.minController,
                                                  keyboardType: TextInputType.number,
                                                  textInputAction: TextInputAction.done,
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Min',
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF848484)),
                                                  )
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 32,),
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 16),
                                              child: TextFormField(
                                                controller: _allTransactionsFilterController.maxController,
                                                  keyboardType: TextInputType.number,
                                                  textInputAction: TextInputAction.done,
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Max',
                                                    hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Color(0xFF848484)),
                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //MARK: - CATEGORY VIEW
                          Obx(
                            ()=> Visibility(
                              visible: _allTransactionsFilterController.showHideCategoryView.value,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                                    child: Text('Select Category',
                                      style: TextStyle(
                                        color: Color(0xFF6B7580),
                                      fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                    ),),
                                  ),
                                  Obx(
                                      ()=>  ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.only(top: 24),
                                          itemCount: _allTransactionsFilterController.categories.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 8,bottom: 8),
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    // categoryId = _allTransactionsFilterController.categories[index].id.toString();
                                                    // categoryName = _allTransactionsFilterController.categories[index].name.toString();
                                                    _selectedIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3),
                                                    color: Colors.white,
                                                  ),
                                                  height: 60,
                                                  child: Row(
                                                    children:  [
                                                      const SizedBox(
                                                        width: 32,
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(right: 16),
                                                            child: Text(
                                                              _allTransactionsFilterController.categories[index].name!,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          )
                                                      ),


                                                      SvgPicture.asset("assets/check.svg",color: _selectedIndex == index ? Colors.black : Colors.white),

                                                      const SizedBox(
                                                        width: 32,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                  ),
                                ],
                              )
                            ),
                          ),


                          //MARK: - DATE VIEW
                          Obx(
                                ()=> Visibility(
                              visible: _allTransactionsFilterController.showHideDateView.value,
                              child: Container(
                                color: Colors.transparent,
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Enter the range below ',
                                            style: TextStyle(
                                                color: Color(0xFF6B7580),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400
                                            ),),
                                          const SizedBox(height: 16,),
                                          GestureDetector(
                                            onTap: () {

                                              showDatePicker(context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000),
                                              ).then((dateValue) => {
                                                setState(() {
                                                  final DateTime? now = dateValue;
                                                  final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
                                                  final String formatted = formatter.format(now!);
                                                  _allTransactionsFilterController.startDate.value = formatted.toString();
                                                })
                                              });
                                            },
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              child: Obx(()=> Padding(
                                                padding: const EdgeInsets.all(14.0),
                                                child: Text(
                                                    _allTransactionsFilterController.startDate.value),
                                              ))
                                            ),
                                          ),
                                          const SizedBox(height: 32,),
                                          GestureDetector(
                                            onTap: () {

                                              showDatePicker(context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000),
                                              ).then((dateValue) => {
                                                setState(() {
                                                  final DateTime? now = dateValue;
                                                  final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
                                                  final String formatted = formatter.format(now!);
                                                  _allTransactionsFilterController.endDate.value = formatted.toString();
                                                })
                                              });
                                            },
                                            child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(3)
                                                ),
                                                child: Obx(()=> Padding(
                                                  padding: const EdgeInsets.all(14.0),
                                                  child: Text(
                                                      _allTransactionsFilterController.endDate.value),
                                                ))
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ],
                  )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(3)
                        ),

                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextButton(onPressed: () {
                            Get.back();
                          }, child: const Text('Apply Changes',
                            style: TextStyle(
                            color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                          ),
                          ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24,)
                  ],
                )

              ],
            ),
          ),
          Obx(
                () => Center(
              child: Visibility(
                visible: _allTransactionsFilterController.showProgress.value,
                child: const SpinKitFadingCircle(
                  color: Color(0xFF3A4FBF),
                  size: 50.0,),
              ),
            ),
          )
        ],
      ),
    );
  }

}
