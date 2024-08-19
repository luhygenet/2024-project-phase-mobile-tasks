import 'package:flutter/material.dart';

import '../screens/Search.dart';
import '../screens/Update.dart';
import '../screens/details.dart';
import '../screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const ProductDetailsPage(),
        '/update': (context) => const Update(),
        '/search': (context) => const Search()
      },
    );
  }
}



            // body: Padding(
            //   padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            //   child: Column(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            //         height: 70.0,
            //         decoration: const BoxDecoration(
            //             borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(20),
            //                 topRight: Radius.circular(20))),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               children: [
            //                 Container(
            //                     width: 50,
            //                     height: 50,
            //                     decoration: const BoxDecoration(
            //                         color: Color.fromARGB(255, 192, 187, 187),
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(10)))),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 const Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       "July 7,2024",
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                         fontWeight: FontWeight.w500,
            //                         fontFamily: 'Roboto',
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           "Hello,",
            //                           style: TextStyle(
            //                             color:
            //                                 Color.fromARGB(255, 104, 101, 101),
            //                             fontWeight: FontWeight.w500,
            //                             fontFamily: 'Roboto',
            //                             fontSize: 15,
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 5,
            //                         ),
            //                         Text(
            //                           "Yohannes",
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontWeight: FontWeight.w500,
            //                             fontFamily: 'Roboto',
            //                             fontSize: 15,
            //                           ),
            //                         ),
            //                       ],
            //                     )
            //                   ],
            //                 )
            //               ],
            //             ),
            //             Icon(Icons.notifications_on_outlined)
            //           ],
            //         ),
            //       ),
            //       GridView.count(
            //         crossAxisCount: 1,
            //         children: [
            //           Card(
            //             child: Column(
            //               children: [
            //                 AspectRatio(
            //                   aspectRatio: 8 / 9,
            //                   child: Image.asset('../assets/boot'),
            //                 ),
            //                 Expanded(
            //                     child: Column(
            //                   children: [
            //                     Text("Here"),
            //                     Text("Here"),
            //                   ],
            //                 ))
            //               ],
            //             ),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // )
