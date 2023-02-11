// import 'package:flutter/material.dart';
// import 'package:hapiverse/utils/constants.dart';
//
// class BusinessAvailability extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         Text("Service Availibility"),
//         SizedBox(
//           height: 10,
//         ),
//         Card(
//           elevation: 5.0,
//           child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.monday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("monday");
//                           },
//                           child: Text("Monday"),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.tuesday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("teusday");
//                           },
//                           child: Text("Tuesday"),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.wednesday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("wednesday");
//                           },
//                           child: Text("Wednesday"),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.thursday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("thursday");
//                           },
//                           child: Text("Thursday"),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.friday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("friday");
//                           },
//                           child: Text("Friday"),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.saturday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("saturday");
//                           },
//                           child: Text("Saturday"),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: MaterialButton(
//                           shape: StadiumBorder(
//                               side: BorderSide(color: Colors.grey)),
//                           color: pro.sunday
//                               ? kUniversalColor
//                               : Colors.white,
//                           onPressed: () {
//                             pro.slectDay("sunday");
//                           },
//                           child: Text("Sunday"),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
// }
