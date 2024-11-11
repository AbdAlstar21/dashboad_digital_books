// import 'package:dashboard/pages/config.dart';
// import 'package:dashboard/pages/users/pop_menu.dart';
// import 'package:dashboard/pages/users/users_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'add_user.dart';

// List<UsersData> userList = [];

// class Users extends StatefulWidget {
//   Users({Key? key}) : super(key: key);
//   @override
//   _UsersState createState() => _UsersState();
// }

// class _UsersState extends State<Users> {
//   void getDataUser() async {
//     List arr = await getData();
//     for (int i = 0; i < arr.length; i++) {
//       userList.add(UsersData(
//         user_id: arr[i]["user_id"],
//         user_name: arr[i]["user_name"],
//         // user_password: arr[i]["user_password"],
//         user_email: arr[i]["user_email"],
//         user_active: arr[i]["user_active"] == "1" ? true : false,
//         // user_lastdate: arr[i]["user_lastdate"],
//         // user_note: arr[i]["user_note"],
//       ));
//     }
//     setState(() {});
//   }

//   // List<String> images = [
//   //   "images/1.jpg",
//   //   "images/2.jpg",
//   //   "images/3.jpg",
//   //   "images/4.jpg",
//   // ];
//   bool isFabVisibleAdd = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     getDataUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           //start for add button

//           floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//           floatingActionButton: Visibility(
//             visible: isFabVisibleAdd,
//             child: FloatingActionButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const AddUser()));
//                 },
//                 backgroundColor: Colors.blue,
//                 child: const Icon(
//                   Icons.add,
//                 )),
//           ),

//           //end for add button
//           appBar: AppBar(
//             title: Text("المستخدمين"),
//           ),
//           body: NotificationListener<UserScrollNotification>(
//             onNotification: (notification) {
//               if (notification.direction == ScrollDirection.forward) {
//                 setState(() {
//                   isFabVisibleAdd = true;
//                 });
//               } else if (notification.direction == ScrollDirection.reverse) {
//                 setState(() {
//                   isFabVisibleAdd = false;
//                 });
//               }
//               return true;
//             },
//             child:
//                 /////
//                 FutureBuilder<List>(
//                     future: getContactData(),
//                     builder: (context, snapshot) {
          
//                       return Container(
//                         child: Text(snapshot.data![0]['user_name']),
//                       );
//                       // if (snapshot.hasError) {
//                       //   print(snapshot.error);
//                       // }
//                       // return snapshot.hasData
//                       //     ? ListView.separated(
//                       //         itemCount: snapshot.data!.length,
//                       //         itemBuilder: (context, index) {
//                       //           List? list = snapshot.data;

//                       //           return Row(
//                       //             children: [
//                       //               Expanded(
//                       //                 child: ListTile(
//                       //                   leading: CircleAvatar(
//                       //                     // backgroundImage: AssetImage(images[index]),
//                       //                     backgroundColor: Colors.amber,
//                       //                   ),

//                       //                   title: Text(list![index]['user_name']),
//                       //                   //  subtitle: Text(list[index]),
//                       //                 ),
//                       //               ),
//                       //               Padding(
//                       //                 padding: const EdgeInsets.all(8.0),
//                       //                 child: MyPopMenu(),
//                       //               )
//                       //             ],
//                       //           );
//                       //         },
//                       //         separatorBuilder: (BuildContext, index) {
//                       //           return Divider(height: 1);
//                       //         },
//                       //       )
//                       //     : Center(
//                       //         child: CircularProgressIndicator(),
//                       //       );
//                     }

//                     // child: ListView.separated(
//                     //             itemBuilder: (BuildContext, index) {
//                     // // return SingleUser(
//                     // //   user_index: index,
//                     // //   users: userList[index],
//                     // // );
//                     // return Row(
//                     //   children: [
//                     //     Expanded(
//                     //       child: ListTile(
//                     //         leading: CircleAvatar(
//                     //           // backgroundImage: AssetImage(images[index]),
//                     //           backgroundColor: Colors.amber,
//                     //         ),
//                     //         title: Text("This is title"),
//                     //         subtitle: Text("This is subtitle"),
//                     //       ),
//                     //     ),
//                     //     Padding(
//                     //       padding: const EdgeInsets.all(8.0),
//                     //       child: MyPopMenu(),
//                     //     )
//                     //   ],
//                     // );
//                     //             },
//                     //             separatorBuilder: (BuildContext, index) {
//                     // return Divider(height: 1);
//                     //             },
//                     //             itemCount: userList.length,
//                     //             shrinkWrap: true,
//                     //             padding: EdgeInsets.all(5),
//                     //             scrollDirection: Axis.vertical,
//                     //           ),
//                     ),
//           )),
//     );
//   }
// }
