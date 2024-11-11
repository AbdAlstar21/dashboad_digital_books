// // ignore_for_file: non_constant_identifier_names

// import 'package:dashboard/pages/components/progres.dart';
// import 'package:dashboard/pages/provider/loading.dart';
// import 'package:dashboard/pages/users/users_data.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

// import '../config.dart';

// class AddUser extends StatefulWidget {
//   const AddUser({Key? key}) : super(key: key);

//   @override
//   _AddUserState createState() => _AddUserState();
// }

// class _AddUserState extends State<AddUser> {
  
//   String initialValue = 'الجنس';
//   var itemList = [
//     'الجنس',
//     "ذكر",
//     "أنثى",
//   ];
//   bool isloading = false;
//   bool checkActive = false;
//   bool visible_enable = false;
//   var _formkey = GlobalKey<FormState>();
//   TextEditingController txt_user_name = new TextEditingController();
//   TextEditingController txt_user_email = new TextEditingController();
//   TextEditingController txt_user_gender = new TextEditingController();
//   TextEditingController txt_user_image = new TextEditingController();
//   TextEditingController txt_user_password = new TextEditingController();
//   TextEditingController txt_user_note = new TextEditingController();
//   saveData(context, LoadingControl load) async {
//     if (!await checkConnection()) {
//       Toast.show("Not connected Internet", context,
//           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//     }
//     bool my_validate = _formkey.currentState!.validate();
//     load.add_loading();
//     if (txt_user_email.text.isNotEmpty &&
//         my_validate &&
//         txt_user_name.text.isNotEmpty &&
//         txt_user_email.text.contains('.') &&
//         txt_user_email.text.contains('@') &&
//         txt_user_password.text.isNotEmpty &&
//         txt_user_password.text.length >= 8) {
//       isloading = true;
//       load.add_loading();

//       bool res = await createUsers(
//           txt_user_name.text,
//           txt_user_email.text,
//           txt_user_password.text,
//           checkActive,
//           txt_user_note.text,
//           token,
//           context);
//       isloading = res;
//       load.add_loading();
//     } else {
//       Toast.show('not connected internet', context,
//           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: pcBlue,
//           elevation: 0.0,
//           title: const Directionality(
//             textDirection: TextDirection.rtl,
//             child: Text(
//               'إضافة مستخدم جديد',
//               // style: TextStyle(
//               //     fontSize: 30, fontFamily: "Cairo", color: Colors.tealAccent),
//             ),
//           ),
//           // centerTitle: true,
//           // leading: IconButton(
//           //   icon: const Icon(
//           //     Icons.arrow_back,
//           //     size: 30,
//           //     color: Colors.tealAccent,
//           //   ),
//           //   onPressed: () => Navigator.of(context).pop(),
//           // ),
//         ),
//         body: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Container(
//             margin: const EdgeInsets.all(10.0),
//             child: Column(children: <Widget>[
//               Consumer<LoadingControl>(builder: (context, load, child) {
//                 return Expanded(
//                   child: Form(
//                     key: _formkey,
//                     child: ListView(children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(10.0),
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         decoration: BoxDecoration(
//                           color: pcGrey,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: TextFormField(
//                           controller: txt_user_name,
//                           decoration: const InputDecoration(
//                               hintText: "اسم المستخدم",
//                               border: InputBorder.none),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'الرجاء إدخال الاسم بشكل صحيح';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(10.0),
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         decoration: BoxDecoration(
//                           color: pcGrey,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: TextFormField(
//                           controller: txt_user_email,
//                           decoration: const InputDecoration(
//                               hintText: "البريد الإلكتروني",
//                               border: InputBorder.none),
//                           validator: (value) {
//                             if (value == null ||
//                                 value.isEmpty ||
//                                 !value.contains('.') ||
//                                 !value.contains('@')) {
//                               return 'الرجاء إدخال بريد إلكتروني صحيح';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(10.0),
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         decoration: BoxDecoration(
//                           color: pcGrey,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: TextFormField(
//                           controller: txt_user_password,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                               hintText: "كلمة المرور",
//                               border: InputBorder.none),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'الرجاء إدخال كلمة مرور';
//                             }
//                             if (value.length <= 8) {
//                               return 'يجب أن تكون أكبر من 6 محارف';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),

//                       // Container(
//                       //   margin: const EdgeInsets.all(10.0),
//                       //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                       //   decoration: BoxDecoration(
//                       //     color: pcGrey,
//                       //     borderRadius: BorderRadius.circular(20.0),
//                       //   ),
//                       //   child: DropdownButton(
//                       //     isExpanded: true,

//                       //     //iconEnabledColor: Colors.white,
//                       //     // style: TextStyle(color: Colors.black, fontSize: 16),
//                       //     // dropdownColor: Colors.green,
//                       //     // focusColor: Colors.black,
//                       //     value: initialValue,
//                       //     icon: const Icon(Icons.keyboard_arrow_down),
//                       //     items: itemList.map((String items) {
//                       //       return DropdownMenuItem(
//                       //           value: items, child: Text(items));
//                       //     }).toList(),
//                       //     onChanged: (String? newValue) {
//                       //       setState(() {
//                       //         initialValue = newValue!;
//                       //         (value) {
//                       //           if (value == null || value.isEmpty) {
//                       //             return 'الرجاء إدخال الجنس';
//                       //           }
//                       //           return null;
//                       //         };
//                       //       });
//                       //     },
//                       //   ),
//                       // ),

//                       // CheckboxListTile(
//                       //   title: const Text('الكتاب مجاني'),
//                       //   value: checkActive,
//                       //   onChanged: (value) => setState(() => {
//                       //         checkActive = value!,
//                       //         if (value == true)
//                       //           {visible_enable = true, visible_text_price = false}
//                       //         else
//                       //           {visible_enable = false, visible_text_price = true}
//                       //       }),
//                       // ),
//                       // Visibility(
//                       //   visible: visible_text_price,
//                       //   child: Container(
//                       //     margin: const EdgeInsets.all(10.0),
//                       //     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                       //     decoration: BoxDecoration(
//                       //       color: pcGrey,
//                       //       borderRadius: BorderRadius.circular(20.0),
//                       //     ),
//                       //     child: TextFormField(
//                       //       readOnly: visible_enable,
//                       //       keyboardType: TextInputType.number,
//                       //       decoration: const InputDecoration(
//                       //           hintText: "سعر الكتاب (بالدولار)",
//                       //           border: InputBorder.none),
//                       //       validator: (value) {
//                       //         if (value == null || value.isEmpty) {
//                       //           return 'الرجاء إدخال سعر الكتاب';
//                       //         }
//                       //         if (value.length >= 6) {
//                       //           return 'لا يمكن أن يكون بهذا السعر';
//                       //         }
//                       //         return null;
//                       //       },
//                       //     ),
//                       //   ),
//                       // ),
//                       Container(
//                         margin: const EdgeInsets.all(10.0),
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         decoration: BoxDecoration(
//                           color: pcGrey,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: MaterialButton(
//                           onPressed: () {},
//                           child: Row(
//                             children: const [
//                               Expanded(
//                                 child: Text(
//                                   "حمل صورة شخصية",
//                                   style: TextStyle(fontSize: 20.0),
//                                 ),
//                               ),
//                               Icon(Icons.upload_file)
//                             ],
//                           ),
//                         ),
//                       ),
//                       CheckboxListTile(
//                         title: const Text('admin؟'),
//                         value: checkActive,
//                         onChanged: (newvalue) => setState(() => {
//                               checkActive = newvalue!,
//                               // if (value == true)
//                               //   {
//                               //     visible_enable = true,
//                               //     visible_text_price = false
//                               //   }
//                               // else
//                               //   {
//                               //     visible_enable = false,
//                               //     visible_text_price = true
//                               //   }
//                             }),
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.width / 2.7,
//                         margin: const EdgeInsets.all(15.0),
//                         padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                         decoration: BoxDecoration(
//                           color: pcGrey,
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         child: TextFormField(
//                           controller: txt_user_note,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           decoration: const InputDecoration(
//                               hintText: 'ملاحظات', border: InputBorder.none),
//                         ),
//                       ),

//                       isloading
//                           ? circularProgress()
//                           : MaterialButton(
//                               onPressed: () {
//                                 saveData(context, load);
//                               },
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: const Text(
//                                   "إضافة المستخدم",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 25.0),
//                                 ),
//                                 margin: const EdgeInsets.only(
//                                     bottom: 10.0, top: 20.0),
//                                 padding: const EdgeInsets.all(5.0),
//                                 decoration: BoxDecoration(
//                                   color: pcBlue,
//                                   borderRadius: BorderRadius.circular(25.0),
//                                 ),
//                               )),
//                     ]),

//                     //f
//                   ),
//                 );
//               })
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
