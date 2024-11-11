// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'dart:io';

import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/admin/admins.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../function.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  bool isloading = false;
  bool checkActive = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtadmin_name = TextEditingController();
  TextEditingController txtadmin_password = TextEditingController();
  TextEditingController txtadmin_email = TextEditingController();
  TextEditingController txt_admin_gender = TextEditingController();
  TextEditingController txt_admin_image = TextEditingController();
  TextEditingController txtadmin_note = TextEditingController();

  saveData(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState!.validate();
    load.add_loading();
    if (txtadmin_email.text.isNotEmpty &&
        myvalid &&
        txtadmin_name.text.isNotEmpty &&
        txtadmin_email.text.contains('.') &&
        txtadmin_email.text.contains('@') &&
        txtadmin_password.text.isNotEmpty &&
        txtadmin_password.text.length >= 6) {
      isloading = true;
      load.add_loading();
      Map arr = {
        "admin_name": txtadmin_name.text,
        "admin_email": txtadmin_email.text,
        "admin_password": txtadmin_password.text,
        "admin_active": checkActive ? "1" : "0",
        "admin_note": txtadmin_note.text,
        "admin_token": token
      };
      bool res = await uploadImageWithData(_image, arr,
          "admin/insert_admin.php", context, () => Admins(), "insert");

      isloading = res;
      load.add_loading();
    } else {
      Toast.show('not connected internet', context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    txtadmin_name.dispose();
    txtadmin_password.dispose();
    txtadmin_email.dispose();
    txtadmin_note.dispose();
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
      backgroundColor: pcWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: pcBlue,
        elevation: 0.0,
        title: Text(
          'إضافة مشرف جديد',
          // style: TextStyle(
          //     fontSize: 30, fontFamily: "Cairo", color: Colors.tealAccent),
        ),

        // centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     size: 30,
        //     color: Colors.tealAccent,
        //   ),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Consumer<LoadingControl>(builder: (context, load, child) {
              return Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: pcGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: txtadmin_name,
                        decoration: const InputDecoration(
                            hintText: "اسم المشرف", border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الاسم بشكل صحيح';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: pcGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: txtadmin_email,
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: pcGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: txtadmin_password,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: "كلمة المرور", border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة مرور';
                          }
                          if (value.length <= 8) {
                            return 'يجب أن تكون أكبر من 6 محارف';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Container(
                    //   margin: const EdgeInsets.all(10.0),
                    //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    //   decoration: BoxDecoration(
                    //     color: pcGrey,
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   child: DropdownButton(
                    //     isExpanded: true,

                    //     //iconEnabledColor: Colors.white,
                    //     // style: TextStyle(color: Colors.black, fontSize: 16),
                    //     // dropdownColor: Colors.green,
                    //     // focusColor: Colors.black,
                    //     value: initialValue,
                    //     icon: const Icon(Icons.keyboard_arrow_down),
                    //     items: itemList.map((String items) {
                    //       return DropdownMenuItem(
                    //           value: items, child: Text(items));
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         initialValue = newValue!;
                    //         (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return 'الرجاء إدخال الجنس';
                    //           }
                    //           return null;
                    //         };
                    //       });
                    //     },
                    //   ),
                    // ),

                    // CheckboxListTile(
                    //   title: const Text('الكتاب مجاني'),
                    //   value: checkActive,
                    //   onChanged: (value) => setState(() => {
                    //         checkActive = value!,
                    //         if (value == true)
                    //           {visible_enable = true, visible_text_price = false}
                    //         else
                    //           {visible_enable = false, visible_text_price = true}
                    //       }),
                    // ),
                    // Visibility(
                    //   visible: visible_text_price,
                    //   child: Container(
                    //     margin: const EdgeInsets.all(10.0),
                    //     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    //     decoration: BoxDecoration(
                    //       color: pcGrey,
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //     child: TextFormField(
                    //       readOnly: visible_enable,
                    //       keyboardType: TextInputType.number,
                    //       decoration: const InputDecoration(
                    //           hintText: "سعر الكتاب (بالدولار)",
                    //           border: InputBorder.none),
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return 'الرجاء إدخال سعر الكتاب';
                    //         }
                    //         if (value.length >= 6) {
                    //           return 'لا يمكن أن يكون بهذا السعر';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),

                    // Container(
                    //   margin: const EdgeInsets.all(10.0),
                    //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    //   decoration: BoxDecoration(
                    //     color: pcGrey,
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   child: MaterialButton(
                    //     onPressed: () {},
                    //     child: Row(
                    //       children: const [
                    //         Expanded(
                    //           child: Text(
                    //             "حمل صورة شخصية",
                    //             style: TextStyle(fontSize: 20.0),
                    //           ),
                    //         ),
                    //         Icon(Icons.upload_file)
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Container(
                      height: MediaQuery.of(context).size.width / 2.7,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: pcGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        controller: txtadmin_note,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: 'ملاحظات', border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: pcGrey,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CheckboxListTile(
                        title: const Text('admin؟'),
                        value: checkActive,
                        onChanged: (newvalue) => setState(() => {
                              checkActive = newvalue!,
                              // if (value == true)
                              //   {
                              //     visible_enable = true,
                              //     visible_text_price = false
                              //   }
                              // else
                              //   {
                              //     visible_enable = false,
                              //     visible_text_price = true
                              //   }
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
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(
                            child: _image == null
                                ? Text("الصورة غير محددة")
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
                              saveData(context, load);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                "إضافة المشرف",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 231, 219, 182),
                                    fontSize: 25.0),
                              ),
                              margin: const EdgeInsets.only(
                                  bottom: 10.0, top: 10.0),
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: pcBlue,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                  ]),

                  //f
                ),
              );
            })
          ]),
        ),
      ),
    );
  }
}
