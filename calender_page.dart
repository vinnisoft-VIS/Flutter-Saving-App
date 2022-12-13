import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_projects/Colors.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_projects/controllers/calendar_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import '../controllers/app_controller.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

  final CalendarController _controller = CalendarController();

  final _calendarPageController = Get.put(CalendarPageController());
  final _appController = Get.put(AppController());
  var currentDate = "";
  var newNowDate = DateTime.now();


  @override
  void initState() {

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEEE,MMMM dd,yyyy');
    final String formatted = formatter.format(now);

    final DateFormat newFormatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = newFormatter.format(now);

    _calendarPageController.fetchDailyForecast(formattedDate);
    _calendarPageController.fetchCalendarTransactions(now.month.toString(), now.year.toString());

    setState(() {
      currentDate = formatted;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          Strings.calender,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            final _state = _appController.sideMenuKey.currentState!;
            if (_state.isOpened) {
              _state.closeSideMenu(); // close side men
            } else {
              _state.openSideMenu();
            }
          },
          icon: SvgPicture.asset("assets/menu.svg"),
          padding: const EdgeInsets.only(left: 24),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {}, icon: SvgPicture.asset("assets/filter.svg")),
        //
        //   const SizedBox(
        //     width: 8,
        //   ),
        // ],
      ),

      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset('assets/PageBG.png',
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: SizedBox(

                        height: MediaQuery.of(context).size.height * 0.55,

                        child: Obx(
                            ()=> SfCalendar(
                              onViewChanged: (ViewChangedDetails details) {
                                List<DateTime> dates = details.visibleDates;
                                _calendarPageController.fetchCalendarTransactions(dates[21].month.toString(), dates[21].year.toString());
                              },

                            onTap: (CalendarTapDetails details) {
                              final DateTime? now = details.date;
                              final DateFormat formatter = DateFormat('EEEE,MMMM dd,yyyy');
                              final String formatted = formatter.format(now!);
                              final DateFormat newFormatter = DateFormat('dd-MM-yyyy');
                              final String formattedDate = newFormatter.format(now);


                              setState(() {
                                currentDate = formatted;
                              });
                              _calendarPageController.fetchDailyForecast(formattedDate);
                            },

                            todayHighlightColor: Colors.transparent,
                            todayTextStyle: const TextStyle(
                              color: Colors.black
                            ),
                            allowAppointmentResize: true,
                            view: CalendarView.month,
                            selectionDecoration: BoxDecoration(
                              color: AppColors.themeColor.withOpacity(0.4)
                            ),
                            appointmentBuilder:
                                (BuildContext context,
                                CalendarAppointmentDetails calendarAppointmentDetails){
                              if (calendarAppointmentDetails.isMoreAppointmentRegion) {
                                return SizedBox(
                                  width: calendarAppointmentDetails.bounds.width,
                                  height: calendarAppointmentDetails.bounds.height,
                                  child: const Text('+3',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 2,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      )
                                  ),
                                );
                              } else if (_controller.view == CalendarView.month) {
                                final Appointment appointment =
                                    calendarAppointmentDetails.appointments.first;
                                return Container(
                                    width: calendarAppointmentDetails.bounds.width,
                                    height: calendarAppointmentDetails.bounds.height,
                                    decoration: BoxDecoration(
                                        color: appointment.color,
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        gradient: const LinearGradient(
                                            colors: [Colors.red, Colors.cyan],
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft)),
                                    alignment: Alignment.center,
                                    child: appointment.isAllDay
                                        ? Text(appointment.subject,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 8))
                                        : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text(appointment.subject,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white, fontSize: 10)),

                                        Text('${DateFormat('hh:mm a').
                                            format(appointment.startTime)}' +
                                                DateFormat('hh:mm a').
                                                format(appointment.endTime),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10))
                                      ],
                                    ));
                              } else {
                                final Appointment appointment =
                                    calendarAppointmentDetails.appointments.first;
                                return Container(
                                  width: calendarAppointmentDetails.bounds.width,
                                  height: 20,
                                  color: appointment.color,
                                  child: Text(appointment.subject,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),),
                                );
                              }
                            },

                            showNavigationArrow: true,
                            viewNavigationMode: ViewNavigationMode.snap,
                            dataSource: DataSource(_calendarPageController.appointments.value),
                            monthViewSettings:
                            MonthViewSettings(
                                monthCellStyle: MonthCellStyle(
                                todayBackgroundColor: const Color(0xFF90B6E8).withOpacity(0.3)
                              ),
                              appointmentDisplayCount: 2,
                                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                            ),
                          ),
                        ),
                      ),
                    ),

                     _calendarPageController.dailyForecast.isNotEmpty == true ? Padding(
                       padding: const EdgeInsets.only(left: 16),
                       child: Text(currentDate,
                           style: const TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.w600
                         ),
                         ),

                     ) : Container(),


                    //MARK: - LIST VIEW
                    Obx(
                        ()=> ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: _calendarPageController.dailyForecast.length,
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
                                        child:
                                        SvgPicture.asset(_calendarPageController.dailyForecast[index].incomeExpenseType == 1  ? "assets/debited.svg" : "assets/credited.svg"),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                       Expanded(
                                        flex: 1,
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(_calendarPageController.dailyForecast[index].title.toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text("${_calendarPageController.dailyForecast[index].dateOfPayment} "
                                                  "${_calendarPageController.dailyForecast[index].incomeExpenseType == 1 ? ".Expense": ".Income"}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                color: Color(0xFF818A88)),
                                              ),
                                            ],
                                          )
                                        ),
                                      ),

                                      Text("${_calendarPageController.dailyForecast[index].amount}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: _calendarPageController.dailyForecast[index].incomeExpenseType==1 ? AppColors.expenseColor : AppColors.incomeColor),
                                      ),


                                      const SizedBox(width: 16,)
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Image.asset('assets/ic_forward.png', height: 12,))
                                    ],
                                  ),
                                ),
                              );
                          }
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Obx(
                () => Center(
              child: Visibility(
                visible: _calendarPageController.showProgress.value,
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

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

