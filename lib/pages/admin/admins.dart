// ignore_for_file: unnecessary_import, avoid_print

import 'dart:ui';
import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/provider/loading.dart';
import 'package:dashboard/pages/admin/add_admin.dart';
import 'package:dashboard/pages/admin/admin_data.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../function.dart';
import 'single_admin.dart';

class Admins extends StatefulWidget {
  const Admins({Key? key}) : super(key: key);

  @override
  _AdminsState createState() => _AdminsState();
}

class _AdminsState extends State<Admins> {
  ScrollController? myScroll;
  GlobalKey<RefreshIndicatorState>? refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataAdmin(int count, String strSearch) async {
    loadingList = true;
    setState(() {});
    List arr = await getData(count, "admin/readadmin.php", strSearch, "");
    for (int i = 0; i < arr.length; i++) {
      adminList!.add(AdminData(
        admin_id: arr[i]["admin_id"],
        admin_name: arr[i]["admin_name"],
        admin_pwd: arr[i]["admin_password"],
        admin_email: arr[i]["admin_email"],
        admin_active: arr[i]["admin_active"] == "1" ? true : false,
        admin_lastdate: arr[i]["admin_lastdate"],
        admin_note: arr[i]["admin_note"],
        admin_thumbnail: arr[i]["admin_thumbnail"],
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
    adminList!.clear();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // adminList=new List<UserData>();
    adminList = <AdminData>[];
    myScroll = ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataAdmin(0, "");

    myScroll?.addListener(() {
      if (myScroll!.position.pixels == myScroll?.position.maxScrollExtent) {
        i += 10;
        getDataAdmin(i, "");
        print("scroll");
      }
    });
  }

  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("إدارة المشرفين");

  void _searchPressed(LoadingControl myProv) {
    if (_searchIcon.icon == Icons.search) {
      _searchIcon = const Icon(Icons.close);
      _appBarTitle = TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          print(text);

          adminList!.clear();
          i = 0;
          getDataAdmin(0, text);
          myProv.add_loading();
        },
      );
    } else {
      _searchIcon = const Icon(Icons.search);
      _appBarTitle = const Text("إدارة المشرفين");
    }
    myProv.add_loading();
  }

  bool isFabVisibleAdd = true;
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        visible: isFabVisibleAdd,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddAdmin()));
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
            )),
      ),
      appBar: AppBar(
        // backgroundColor: pcBlue,
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
      backgroundColor: pcWhite,
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
        child: RefreshIndicator(
          onRefresh: () async {
            i = 0;
            adminList!.clear();
            getDataAdmin(0, "");
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
                    itemCount: adminList!.length,
                    itemBuilder: (context, index) {
                      final item = adminList![index];
                      return Dismissible(
                        key: Key(item.admin_id),
                        direction: DismissDirection.startToEnd,
                        child: SingleAdmin(
                          admin_index: index,
                          admins: adminList![index],
                        ),
                        onDismissed: (direction) {
                          
                          adminList!.remove(item);
                          deleteData(
                              "admin_id", item.admin_id, "admin/delete_admin.php");
                          myProvider.add_loading();
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                    child: loadingList ? circularProgress() : const Text(""),
                    bottom: 0,
                    left: MediaQuery.of(context).size.width / 2)
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}





