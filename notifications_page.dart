import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Strings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leadingWidth: 48,
        centerTitle: true,
        title: const Text(
          Strings.notification,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        ),

      ),
      body: Stack(
        children: [
          Image.asset('assets/PageBG.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),

          ListView.separated(itemBuilder: (BuildContext  context, int index){
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Expanded(child: Text(('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. '),
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),)
                  ),
                  SizedBox(width: 32,),
                  Text('2 min ago',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300
                    ),)
                ],
              ),
            );
          }, separatorBuilder: (BuildContext  context, int Index){
            return const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Divider(),
            );
          }, itemCount: 20),

          // ListView.builder(
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.all(8),
          //     itemCount: 20,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(16),
          //         child: Row(
          //           children: const [
          //             Expanded(child: Text(('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. '),
          //               maxLines: 2,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w400,
          //                   fontSize: 14
          //               ),)
          //             ),
          //             SizedBox(width: 32,),
          //             Text('2 min ago',
          //               style: TextStyle(
          //                 fontSize: 10,
          //                 fontWeight: FontWeight.w300
          //             ),)
          //           ],
          //         ),
          //       );
          //     }
          // ),
        ],
      )
    );
  }
}
