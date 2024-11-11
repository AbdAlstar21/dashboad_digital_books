// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names
import 'dart:math';
import 'package:dashboard/pages/eva/reports.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/pages/account/login.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/users/users.dart';
import 'package:dashboard/pages/admin/admins.dart';
import '../books/books.dart';
import '../categories/categories.dart';
import '../reports/reports.dart';
import '../users/users.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void logout(context) {
    prefs!.remove(G_user_id);
    prefs!.remove(G_user_name);
    prefs!.remove(G_user_email);
    // prefs!.remove(G_user_image);
    prefs!.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: pcWhite,
          //////////////////////////////
          ///
          ///
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              // backgroundColor: pcBlue,

              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الصفحة الرئيسية',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'الإعدادات',
                ),
              ],
              currentIndex: 0,
              selectedItemColor: pcBlue,
              unselectedItemColor: Colors.grey,
              // selectedItemColor: Colors.amber,
              // unselectedItemColor: pcGrey,

              selectedLabelStyle:
                  const TextStyle(fontFamily: "Cairo", fontSize: 16),
              unselectedLabelStyle:
                  const TextStyle(fontFamily: "Cairo", fontSize: 15),
            ),
          ),

          ///
          ///
          //////////////////////////////
          appBar: AppBar(
            title: const Text("إدارة التطبيق"),
            actions: [
              Container(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    logout(context);
                  },
                  child: Icon(Icons.outbond, size: 35),
                ),
              )
            ],
          ),
          body:
              // GridView.count(

              //     crossAxisCount: 2,
              //     crossAxisSpacing: 10.0,
              //     mainAxisSpacing: 10.0,
              GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 320,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  padding: const EdgeInsets.all(10),
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(choice: choices[index]),
                    );
                  }))),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  final Widget? page;
  void ChoicePage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
  }

  const Choice({
    // chontap
    required this.title,
    required this.icon,
    this.page,
  });
  // void chontap(BuildContext context,Widget chwidget){
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) =>  chwidget));
  // }

}

List<Choice> choices = <Choice>[
  const Choice(title: 'المستخدمين', icon: Icons.contacts, page: Users()),
  const Choice(
      title: 'المشرفين', icon: Icons.admin_panel_settings, page: Admins()),
  Choice(title: 'الكتب', icon: Icons.book, page: Books()),
  const Choice(title: 'الأقسام', icon: Icons.category, page: Categories()),
  const Choice(title: 'الإبلاغات', icon: Icons.report, page: Reports()),
  const Choice(title: 'التقييمات', icon: Icons.star, page: Eva()),
];
void choiceontap(context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}

class SelectCard extends StatelessWidget {
  const SelectCard({required this.choice});
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: pcBlue, width: 4),
          borderRadius: BorderRadius.circular(24),
        ),
        // color: pcWhite,
        child: InkWell(
          onTap: () {
            choice.ChoicePage(context);
          },
          child: Center(
            child: FittedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // InkWell(
                    //   onTap: () {
                    //     logout(context);
                    //   },
                    //   child:
                    Icon(
                      choice.icon,
                      size: 60,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    // ),
                    Text(
                      choice.title,
                      style: const TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
