// ignore_for_file: unused_field, unused_element, avoid_print, duplicate_ignore

import 'package:dashboard/pages/reports/report_data.dart';
import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/reports/single_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../function.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool isloading = false;
  TextEditingController txtrep_note = TextEditingController();

  saveData(context, LoadingControl load) async {
    if (!await checkConnection()) {
      Toast.show("Not connected Internet", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    load.add_loading();
    if (txtrep_note.text.isNotEmpty) {
      isloading = true;
      load.add_loading();
      Map arr = {"rep_note": txtrep_note.text};
      bool res = await SaveData(
          arr, "reports/insert_rep.php", context, () => Reports(), "insert");
      /*await createData(
          arr, "category/insert_category.php", context, () => Category());*/

      isloading = res;
      load.add_loading();
    } else {
      Toast.show("Please fill data", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  _displayDialog(BuildContext context, LoadingControl load) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('AlertDemo with TextField '),
            content: TextField(
              controller: txtrep_note,
              decoration: InputDecoration(hintText: "Enter Text"),
            ),
            actions: [
              MaterialButton(
                child: Text('SUBMIT'),
                onPressed: () {
                  saveData(context, load);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  ScrollController? myScroll;
  GlobalKey<RefreshIndicatorState>? refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataReport(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, "reports/readrep.php", strSearch, "");
    for (int i = 0; i < arr.length; i++) {
      reportList!.add(ReportData(
        rep_id: arr[i]["rep_id"],
        rep_not: arr[i]["rep_note"],
        rep_date: arr[i]["rep_datetime"],
      ));
    }
    loadingList = false;
    setState(() {});
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    myScroll!.dispose();
    reportList!.clear();
    txtrep_note.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    reportList = <ReportData>[];
    myScroll = ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataReport(0, "");

    myScroll?.addListener(() {
      // ignore: duplicate_ignore
      if (myScroll!.position.pixels == myScroll?.position.maxScrollExtent) {
        i += 10;
        getDataReport(i, "");
        // ignore: avoid_print
        print("scroll");
      }
    });
  }

  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("إدارة الإبلاغات");

  void _searchPressed(LoadingControl myProv) {
    if (_searchIcon.icon == Icons.search) {
      _searchIcon = const Icon(Icons.close);
      _appBarTitle = TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          reportList!.clear();
          i = 0;
          getDataReport(0, text);
          myProv.add_loading();
        },
      );
    } else {
      _searchIcon = const Icon(Icons.search);
      _appBarTitle = const Text("إدارة الإبلاغات");
    }
    myProv.add_loading();
  }

  bool isFabVisibleAdd = true;

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Consumer<LoadingControl>(builder: (context, load, child) {
      return Scaffold(
        backgroundColor: pcWhite,
        //start for add button
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

        // // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: Visibility(
        //   visible: isFabVisibleAdd,
        //   child: FloatingActionButton(
        //       onPressed: () {
        //         // AddReport();
        //         _displayDialog(context, load);
        //         // Navigator.push(context,
        //         //     MaterialPageRoute(builder: (context) => AddReport()));
        //       },
        //       backgroundColor: pcBlue,
        //       child: const Icon(
        //         Icons.add,
        //         color: Color.fromARGB(255, 231, 219, 182),
        //         size: 30,
        //       )),
        // ),

        //end for add button
        appBar: AppBar(
          // title: const Text("التصنيفات"),
          title: _appBarTitle,
          centerTitle: true,
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  _searchPressed(myProvider);
                },
                child: _searchIcon,
              ),
            )
          ],
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                isFabVisibleAdd = true;
              });
            } else if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                isFabVisibleAdd = false;
              });
            }
            return true;
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            //color: Colors.amber,
            child: RefreshIndicator(
              onRefresh: () async {
                i = 0;
                reportList!.clear();
                getDataReport(0, "");
              },
              key: refreshKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: ListView.builder(
                        controller: myScroll,
                        itemCount: reportList!.length,
                        itemBuilder: (context, index) {
                          final item = reportList![index];
                          return Dismissible(
                            key: Key(item.rep_id),
                            direction: DismissDirection.startToEnd,
                            child: SingleReport(
                              rep_index: index,
                              reports: reportList![index],
                            ),
                            onDismissed: (direction) {
                              reportList!.remove(item);
                              deleteData("rep_id", item.rep_id,
                                  "reports/delete_rep.php");
                              myProvider.add_loading();
                            },
                          );
                        },
                      ),
                    ),
                    Positioned(
                        child:
                            loadingList ? circularProgress() : const Text(""),
                        bottom: 0,
                        left: MediaQuery.of(context).size.width / 2)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}