// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:dashboard/pages/config.dart';
// import 'package:dashboard/pages/users/pop_menu.dart';
// import 'package:dashboard/pages/users/users.dart';

// List<String> images = [
//   "images/1.jpg",
//   "images/2.jpg",
//   "images/3.jpg",
//   "images/4.jpg",
// ];

// class UsersData {
//   String user_id;
//   String user_name;
//   // String user_password;
//   String user_email;
//   bool user_active;
//   // String user_lastdate;
//   // String? user_note;
//   // Image? user_image;
//   UsersData({
//     required this.user_id,
//     required this.user_name,
//     // required this.user_password,
//     required this.user_email,
//     required this.user_active,
//     // required this.user_lastdate,
//     // this.user_note,
//     // this.user_image,
//   });
// }

// class SingleUser extends StatelessWidget {
//   int user_index;
//   UsersData users;
//   SingleUser({
//     required this.user_index,
//     required this.users,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: ListTile(
//             leading: CircleAvatar(
//               // backgroundImage: AssetImage(images[index]),
//               backgroundColor: Colors.amber,
//             ),
//             title: Text(users.user_name),
//             subtitle: Text(users.user_email),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: MyPopMenu(),
//         )
//       ],
//     );
//   }
// }

// Future<bool> createUsers(
//     // ignore: non_constant_identifier_names
//     String user_name,
//     String user_email,
//     String user_password,
//     bool user_active,
//     String user_note,
//     String user_token,
//     BuildContext context) async {
//   String url = api_path + "users/insert_user.php?token=" + token;
//   Map data = {
//     "user_name": user_name,
//     "user_email": user_email,
//     "user_password": user_password,
//     // "user_active": user_active,
//     "user_active": user_active ? "1" : "0",
//     "user_note": user_note,
//     "user_token": user_token
//   };
//   http.Response response = await http.post(Uri.parse(url), body: data);
//   if (json.decode(response.body)["code"] == "200") {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => Users()));
//     print("sucsses");
//     return true;
//   } else {
//     print("faild");
//     return false;
//   }
// }

// Future<List> getContactData() async {
//   var url = api_path + "users/readuser.php";
//   // ?strart=0&end=20&token=" + token;
//   var response = await http.get(Uri.parse(url));
//   var responsebody = jsonDecode(response.body);
//   return responsebody;
//   print(responsebody);
// }


// Future<List> getData() async {
//   String url = api_path + "users/readuser.php?strart=0&end=20&token=" + token;
//   http.Response response = await http.post(Uri.parse(url));
//   if (json.decode(response.body)["code"] == "200") {
//     List arr = (json.decode(response.body)["message"]);
//     return arr;
//   } else
//     return ["error"];
// }



