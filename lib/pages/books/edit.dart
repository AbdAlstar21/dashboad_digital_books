// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:image_network/image_network.dart';
import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/books/books_data.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';

import 'books_cat.dart';

class EditBooks extends StatefulWidget {
  int book_index;
  BooksData books;

  EditBooks({Key? key, required this.book_index, required this.books})
      : super(key: key);
  @override
  _EditBooksState createState() => _EditBooksState();
}

class _EditBooksState extends State<EditBooks> {
  String? initialValue_lang;
  String selected = "اختر لغة الكتاب";

  var itemList = ["العربية", "الإنجليزية", "التركية", "الفرنسية", "غير ذلك"];
  bool isloading = false;
  bool checkActive = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtbook_name = TextEditingController();
  TextEditingController txtbook_author_name = TextEditingController();
  TextEditingController txtbook_lang = TextEditingController();
  TextEditingController txtbook_summary = TextEditingController();

  updateBook(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    bool myvalid = _formKey.currentState!.validate();
    load.add_loading();
    if (txtbook_name.text.isNotEmpty &&
            initialValue_lang != null &&
            initialValue_lang != "غير ذلك" &&
            txtbook_author_name.text.isNotEmpty &&
            myvalid ||
        txtbook_name.text.isNotEmpty && txtbook_lang.text.isNotEmpty) {
      isloading = true;
      load.add_loading();
      Map arr = {
        "book_id": widget.books.book_id,
        "book_name": txtbook_name.text,
        "book_lang": initialValue_lang == "غير ذلك"
            ? txtbook_lang.text
            : initialValue_lang,
        "book_author_name": txtbook_author_name.text,
        "book_block": checkActive ? "1" : "0",
        "book_summary": txtbook_summary.text
      };
      bool res = await uploadImageWithData(_image, arr, "books/update_book.php",
          context, () => BooksCategory(), "update");
      bookList![widget.book_index].book_name = txtbook_name.text;
      bookList![widget.book_index].book_lang = txtbook_lang.text;
      bookList![widget.book_index].book_lang = initialValue_lang!;
      bookList![widget.book_index].book_author_name = txtbook_author_name.text;
      bookList![widget.book_index].book_summary = txtbook_summary.text;
      // bookList![widget.book_index].book_block = checkActive;
      print("bookList=  " + (bookList![widget.book_index].book_name));
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
    txtbook_name.dispose();
    txtbook_author_name.dispose();
    txtbook_lang.dispose();
    txtbook_summary.dispose();
  }

  String imageEdit = "";
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    // checkActive = widget.books.book_block;

    txtbook_name.text = widget.books.book_name;
    txtbook_summary.text = widget.books.book_summary;
    txtbook_author_name.text = widget.books.book_author_name;
    initialValue_lang = widget.books.book_lang;

    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i] != initialValue_lang) {
        print("The Item is found $initialValue_lang and The index is $i");
        initialValue_lang = "غير ذلك";
        txtbook_lang.text = widget.books.book_lang;
      }
    }
    imageEdit = widget.books.book_thumbnail == ""
        ? ""
        : images_path + "books/" + widget.books.book_thumbnail;
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
          title: const Text("اضافة كتاب جديد"),
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
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: TextFormField(
                              controller: txtbook_name,
                              decoration: const InputDecoration(
                                  hintText: "اسم الكتاب",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  // ignore: avoid_print
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
                            child: DropdownButton(
                              hint: Text(selected,
                                  style: TextStyle(fontSize: 18)),
                              isExpanded: true,

                              //iconEnabledColor: Colors.white,
                              // style: TextStyle(color: Colors.black, fontSize: 16),
                              // dropdownColor: Colors.green,
                              // focusColor: Colors.black,
                              value: initialValue_lang,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: itemList.map((String items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selected = "";
                                  initialValue_lang = newValue!;
                                });
                              },
                            ),
                          ),
                          initialValue_lang == "غير ذلك"
                              ? Container(
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0),
                                  decoration: BoxDecoration(
                                    color: pcGrey,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: TextFormField(
                                    controller: txtbook_lang,
                                    decoration: const InputDecoration(
                                        hintText: "ادخل لغة الكتاب",
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال اللغة بشكل صحيح';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              : Container(),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.image,
                                  size: 60.0,
                                  color: Colors.orange[400],
                                ),
                                onPressed: () {
                                  showSheetGallery(context);
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            child: _image == null
                                ? (imageEdit == ""
                                    ? const Text("الصورة غير محددة")
                                    : ImageNetwork(
                                        image: imageEdit,
                                        height: 150,
                                        width: 150,
                                        onLoading: CircularProgressIndicator(
                                          color: Colors.indigoAccent,
                                        ),
                                        onError: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ))
                                : Image.file(
                                    _image!,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: TextFormField(
                              controller: txtbook_author_name,
                              decoration: const InputDecoration(
                                  hintText: "اسم المؤلف",
                                  border: InputBorder.none),
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return "الرجاء المؤلف";
                                }
                                return null;
                              },
                            ),
                          ),
                          // Container(
                          //     margin: const EdgeInsets.only(bottom: 10.0),
                          //     padding: const EdgeInsets.only(
                          //         left: 20.0, right: 20.0),
                          //     child: Checkbox(
                          //         value: checkActive,
                          //         onChanged: (newValue) {
                          //           setState(() {
                          //             checkActive = newValue!;
                          //           });
                          //         })),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: TextFormField(
                              controller: txtbook_summary,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                  hintText: "الملخص", border: InputBorder.none),
                            ),
                          ),
                          isloading
                              ? circularProgress()
                              : MaterialButton(
                                  onPressed: () {
                                    updateBook(context, load);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Text(
                                      "حفظ",
                                      style: TextStyle(
                                          // color: Colors.white,
                                          fontSize: 20.0),
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
