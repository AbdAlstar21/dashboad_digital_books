// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/admin/admins.dart';
import 'package:dashboard/pages/admin/admin_data.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class EditAdmin extends StatefulWidget {
  int admin_index;
  AdminData admins;

  EditAdmin({Key? key, required this.admin_index, required this.admins})
      : super(key: key);
  @override
  _EditAdminState createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  bool isloading = false;
  bool checkActive = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtadmin_name = TextEditingController();
  TextEditingController txtadmin_pwd = TextEditingController();
  TextEditingController txtadmin_mobile = TextEditingController();
  TextEditingController txtadmin_note = TextEditingController();

  updateUser(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState!.validate();
    load.add_loading();
    if (txtadmin_name.text.isNotEmpty &&
        txtadmin_mobile.text.isNotEmpty &&
        txtadmin_pwd.text.isNotEmpty &&
        myvalid) {
      isloading = true;
      load.add_loading();
      Map arr = {
        "admin_id": widget.admins.admin_id,
        "admin_name": txtadmin_name.text,
        "admin_email": txtadmin_mobile.text,
        "admin_password": txtadmin_pwd.text,
        "admin_active": checkActive ? "1" : "0",
        "admin_note": txtadmin_note.text
      };
      bool res = await uploadImageWithData(_image, arr, "admin/update_admin.php",
          context, () => Admins(), "update");
      adminList![widget.admin_index].admin_name = txtadmin_name.text;
      adminList![widget.admin_index].admin_email = txtadmin_mobile.text;
      adminList![widget.admin_index].admin_pwd = txtadmin_pwd.text;
      adminList![widget.admin_index].admin_note = txtadmin_note.text;
      adminList![widget.admin_index].admin_active = checkActive;
      isloading = res;
      load.add_loading();
    } else {
      Toast.show("Please fill data", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    txtadmin_name.dispose();
    txtadmin_pwd.dispose();
    txtadmin_mobile.dispose();
    txtadmin_note.dispose();
  }

  String imageEdit = "";
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    txtadmin_mobile.text = widget.admins.admin_email;
    txtadmin_name.text = widget.admins.admin_name;
    txtadmin_note.text = widget.admins.admin_note;
    txtadmin_pwd.text = widget.admins.admin_pwd;
    checkActive = widget.admins.admin_active;
    imageEdit = widget.admins.admin_thumbnail == ""
        ? ""
        : images_path + "admins/" + widget.admins.admin_thumbnail;
  }

  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Future getImageCamera() async {
  //   var image = await picker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     if (image != null) {
  //       _image = File(image.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  void showSheetGallery(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("معرض الصور"),
                onTap: () {
                  getImageGallery();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.camera),
              //   title: const Text("كاميرا"),
              //   onTap: () {
              //     getImageCamera();
              //   },
              // ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: pcBlue,
          title: const Text("تعديل بيانات مشرف"),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Consumer<LoadingControl>(builder: (context, load, child) {
                  return Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: pcGrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: txtadmin_name,
                              decoration: const InputDecoration(
                                  hintText: "اسم المستخدم",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  print("enyter name");
                                  return "الرجاء ادخال الاسم ";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: pcGrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: txtadmin_mobile,
                              decoration: const InputDecoration(
                                  hintText: "البريد الإلكتروني",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains('.') ||
                                    !value.contains('@')) {
                                  return 'الرجاء إدخال بريد إلكتروني صحيح';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: pcGrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: txtadmin_pwd,
                              decoration: const InputDecoration(
                                  hintText: "كلمة المرور",
                                  border: InputBorder.none),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return "الرجاء ادخال كلمة المرور ";
                                }
                                return null;
                              },
                            ),
                          ),

                          // Container(
                          //   margin: const EdgeInsets.only(bottom: 10.0),
                          //   padding:
                          //       const EdgeInsets.only(left: 20.0, right: 20.0),
                          //   child: IconButton(
                          //       icon: Icon(
                          //         Icons.image,
                          //         size: 60.0,
                          //         color: Colors.orange[400],
                          //       ),
                          //       onPressed: () {
                          //         showSheetGallery(context);
                          //       }),
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: _image == null
                          //       ? (imageEdit == ""
                          //           ? const Text("الصورة غير محددة")
                          //           : ProfilePicture(
                          //               name: widget.admins.admin_name,
                          //               radius: 145,
                          //               fontsize: 21,
                          //               tooltip: true,
                          //               img: imageEdit,
                          //             ))
                          //       : Image.file(
                          //           _image!,
                          //           width: 150.0,
                          //           height: 150.0,
                          //           fit: BoxFit.cover,
                          //         ),
                          // ),

                          // Container(
                          //     margin: const EdgeInsets.only(bottom: 10.0),
                          //     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          //     child: Checkbox(
                          //         value: checkActive,
                          //         onChanged: (newValue) {
                          //           setState(() {
                          //             checkActive = newValue!;
                          //           });
                          //         })),

                          Container(
                            height: MediaQuery.of(context).size.width / 2.7,
                            margin: const EdgeInsets.all(15.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: pcGrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              controller: txtadmin_note,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                  hintText: "الملاحظات",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: pcGrey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: CheckboxListTile(
                              title: const Text('admin؟'),
                              value: checkActive,
                              onChanged: (newvalue) => setState(() => {
                                    checkActive = newvalue!,
                                  }),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              showSheetGallery(context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 35.0,
                                  color: Colors.orange[400],
                                ),
                                Expanded(
                                  child: _image == null
                                      ? (imageEdit == ""
                                          ? const Text("الصورة غير محددة")
                                          : ProfilePicture(
                                              name: widget.admins.admin_name,
                                              radius: 136,
                                              fontsize: 21,
                                              tooltip: true,
                                              img: imageEdit,
                                            ))
                                      : Image.file(
                                          _image!,
                                          width: 80.0,
                                          height: 150.0,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ),

                          isloading
                              ? circularProgress()
                              : MaterialButton(
                                  onPressed: () {
                                    updateUser(context, load);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text(
                                      "حفظ",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 231, 219, 182),
                                          fontSize: 25.0),
                                    ),
                                    margin: const EdgeInsets.only(
                                        bottom: 10.0, top: 30.0),
                                    padding: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                        color: pcBlue,
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                  )),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
