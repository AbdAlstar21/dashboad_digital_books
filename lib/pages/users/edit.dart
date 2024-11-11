// // ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, non_constant_identifier_names, avoid_print

// import 'dart:io';

// import 'package:dashboard/pages/components/progres.dart';
// import 'package:dashboard/pages/provider/loading.dart';
// import 'package:dashboard/pages/users/users.dart';
// import 'package:dashboard/pages/users/users_data.dart';
// import 'package:flutter/material.dart';
// import 'package:dashboard/pages/config.dart';
// import 'package:dashboard/pages/function.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
// import 'package:image_network/image_network.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';

// class EditUsers extends StatefulWidget {
//   int user_index;
//   UsersData users;

//   EditUsers({Key? key, required this.user_index, required this.users})
//       : super(key: key);
//   @override
//   _EditUsersState createState() => _EditUsersState();
// }

// class _EditUsersState extends State<EditUsers> {
//   bool isloading = false;
//   bool checkActive = false;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController txtuser_name = TextEditingController();
//   TextEditingController txtuser_pwd = TextEditingController();
//   TextEditingController txtuser_mobile = TextEditingController();
//   TextEditingController txtuser_note = TextEditingController();

//   updateUser(context, LoadingControl load) async {
//     if (!await checkConnection()) {
//       Toast.show("Not connected Internet", context,
//           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//     }
//     bool myvalid = _formKey.currentState!.validate();
//     load.add_loading();
//     if (txtuser_name.text.isNotEmpty &&
//         txtuser_mobile.text.isNotEmpty &&
//         txtuser_pwd.text.isNotEmpty &&
//         myvalid) {
//       isloading = true;
//       load.add_loading();
//       Map arr = {
//         "user_id": widget.users.user_id,
//         "user_name": txtuser_name.text,
//         "user_email": txtuser_mobile.text,
//         "user_password": txtuser_pwd.text,
//         "user_active": checkActive ? "1" : "0",
//         "user_note": txtuser_note.text
//       };
//       bool res = await uploadImageWithData(_image, arr, "users/update_user.php",
//           context, () => Users(), "update");
//       userList![widget.user_index].user_name = txtuser_name.text;
//       userList![widget.user_index].user_mobile = txtuser_mobile.text;
//       userList![widget.user_index].user_pwd = txtuser_pwd.text;
//       userList![widget.user_index].user_note = txtuser_note.text;
//       userList![widget.user_index].user_active = checkActive;
//       isloading = res;
//       load.add_loading();
//     } else {
//       Toast.show("Please fill data", context,
//           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//     }
//   }

//   @override
//   void dispose() {
//     // ignore: todo
//     // TODO: implement dispose
//     super.dispose();
//     txtuser_name.dispose();
//     txtuser_pwd.dispose();
//     txtuser_mobile.dispose();
//     txtuser_note.dispose();
//   }

//   String imageEdit = "";
//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     txtuser_mobile.text = widget.users.user_mobile;
//     txtuser_name.text = widget.users.user_name;
//     txtuser_note.text = widget.users.user_note;
//     txtuser_pwd.text = widget.users.user_pwd;
//     checkActive = widget.users.user_active;
//     imageEdit = widget.users.user_thumbnail == ""
//         ? ""
//         : images_path + "users/" + widget.users.user_thumbnail;
//   }

//   File? _image;
//   final picker = ImagePicker();
//   Future getImageGallery() async {
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (image != null) {
//         _image = File(image.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   // Future getImageCamera() async {
//   //   var image = await picker.pickImage(source: ImageSource.camera);
//   //   setState(() {
//   //     if (image != null) {
//   //       _image = File(image.path);
//   //     } else {
//   //       print('No image selected.');
//   //     }
//   //   });
//   // }

//   void showSheetGallery(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.image),
//                 title: const Text("معرض الصور"),
//                 onTap: () {
//                   getImageGallery();
//                 },
//               ),
//               // ListTile(
//               //   leading: const Icon(Icons.camera),
//               //   title: const Text("كاميرا"),
//               //   onTap: () {
//               //     getImageCamera();
//               //   },
//               // ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: pcBlue,
//           title: const Text("تعديل بيانات مستخدم"),
//           centerTitle: true,
//         ),
//         body: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Container(
//             margin: const EdgeInsets.all(10.0),
//             padding: const EdgeInsets.only(top: 30),
//             child: Column(
//               children: <Widget>[
//                 Consumer<LoadingControl>(builder: (context, load, child) {
//                   return Expanded(
//                     child: Form(
//                       key: _formKey,
//                       child: ListView(
//                         children: <Widget>[
//                           Container(
//                             margin: const EdgeInsets.all(10.0),
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20.0),
//                             decoration: BoxDecoration(
//                               color: pcGrey,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: TextFormField(
//                               controller: txtuser_name,
//                               decoration: const InputDecoration(
//                                   hintText: "اسم المستخدم",
//                                   border: InputBorder.none),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   print("enyter name");
//                                   return "الرجاء ادخال الاسم ";
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(10.0),
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20.0),
//                             decoration: BoxDecoration(
//                               color: pcGrey,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: TextFormField(
//                               controller: txtuser_mobile,
//                               decoration: const InputDecoration(
//                                   hintText: "البريد الإلكتروني",
//                                   border: InputBorder.none),
//                               validator: (value) {
//                                 if (value == null ||
//                                     value.isEmpty ||
//                                     !value.contains('.') ||
//                                     !value.contains('@')) {
//                                   return 'الرجاء إدخال بريد إلكتروني صحيح';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(10.0),
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20.0),
//                             decoration: BoxDecoration(
//                               color: pcGrey,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: TextFormField(
//                               controller: txtuser_pwd,
//                               decoration: const InputDecoration(
//                                   hintText: "كلمة المرور",
//                                   border: InputBorder.none),
//                               validator: (String? value) {
//                                 if (value!.isEmpty || value.length < 5) {
//                                   return "الرجاء ادخال كلمة المرور ";
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),

//                           // Container(
//                           //   margin: const EdgeInsets.only(bottom: 10.0),
//                           //   padding:
//                           //       const EdgeInsets.only(left: 20.0, right: 20.0),
//                           //   child: IconButton(
//                           //       icon: Icon(
//                           //         Icons.image,
//                           //         size: 60.0,
//                           //         color: Colors.orange[400],
//                           //       ),
//                           //       onPressed: () {
//                           //         showSheetGallery(context);
//                           //       }),
//                           // ),
//                           // Container(
//                           //   padding: const EdgeInsets.all(15.0),
//                           //   child: _image == null
//                           //       ? (imageEdit == ""
//                           //           ? const Text("الصورة غير محددة")
//                           //           : ProfilePicture(
//                           //               name: widget.users.user_name,
//                           //               radius: 145,
//                           //               fontsize: 21,
//                           //               tooltip: true,
//                           //               img: imageEdit,
//                           //             ))
//                           //       : Image.file(
//                           //           _image!,
//                           //           width: 150.0,
//                           //           height: 150.0,
//                           //           fit: BoxFit.cover,
//                           //         ),
//                           // ),

//                           // Container(
//                           //     margin: const EdgeInsets.only(bottom: 10.0),
//                           //     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                           //     child: Checkbox(
//                           //         value: checkActive,
//                           //         onChanged: (newValue) {
//                           //           setState(() {
//                           //             checkActive = newValue!;
//                           //           });
//                           //         })),

//                           Container(
//                             height: MediaQuery.of(context).size.width / 2.7,
//                             margin: const EdgeInsets.all(15.0),
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20.0),
//                             decoration: BoxDecoration(
//                               color: pcGrey,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: TextFormField(
//                               controller: txtuser_note,
//                               maxLines: null,
//                               keyboardType: TextInputType.multiline,
//                               decoration: const InputDecoration(
//                                   hintText: "الملاحظات",
//                                   border: InputBorder.none),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(10.0),
//                             padding:
//                                 const EdgeInsets.only(left: 20.0, right: 20.0),
//                             decoration: BoxDecoration(
//                               color: pcGrey,
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             child: CheckboxListTile(
//                               title: const Text('admin؟'),
//                               value: checkActive,
//                               onChanged: (newvalue) => setState(() => {
//                                     checkActive = newvalue!,
//                                   }),
//                             ),
//                           ),
//                           MaterialButton(
//                             onPressed: () {
//                               showSheetGallery(context);
//                             },
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.image,
//                                   size: 35.0,
//                                   color: Colors.orange[400],
//                                 ),
//                                 Expanded(
//                                   child: _image == null
//                                       ? (imageEdit == ""
//                                           ? const Text("الصورة غير محددة")
//                                           : ProfilePicture(
//                                               name: widget.users.user_name,
//                                               radius: 136,
//                                               fontsize: 21,
//                                               tooltip: true,
//                                               img: imageEdit,
//                                             ))
//                                       : Image.file(
//                                           _image!,
//                                           width: 80.0,
//                                           height: 150.0,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           isloading
//                               ? circularProgress()
//                               : MaterialButton(
//                                   onPressed: () {
//                                     updateUser(context, load);
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     width: MediaQuery.of(context).size.width,
//                                     child: const Text(
//                                       "حفظ",
//                                       style: TextStyle(
//                                           color: Color.fromARGB(
//                                               255, 231, 219, 182),
//                                           fontSize: 25.0),
//                                     ),
//                                     margin: const EdgeInsets.only(
//                                         bottom: 10.0, top: 30.0),
//                                     padding: const EdgeInsets.all(2.0),
//                                     decoration: BoxDecoration(
//                                         color: pcBlue,
//                                         borderRadius:
//                                             BorderRadius.circular(25.0)),
//                                   )),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ));
//   }
// }
