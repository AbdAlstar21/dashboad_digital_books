import 'package:flutter/material.dart';

class MyPopMenu extends StatefulWidget {
  const MyPopMenu({Key? key}) : super(key: key);

  @override
  _MyPopMenuState createState() => _MyPopMenuState();
}

class _MyPopMenuState extends State<MyPopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.white,
        iconSize: 30,
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text('حذف'),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 2, 2, 2),
                        child: Icon(Icons.delete)
                      ),
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text('تعديل'),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 2, 2),
                        child: Icon(Icons.star),
                      ),
                    ],
                  )),
              // PopupMenuItem(
              //     value: 3,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: const <Widget>[
              //         Text('مشاركة'),
              //         Padding(
              //           padding: EdgeInsets.fromLTRB(8, 2, 2, 2),
              //           child: Icon(Icons.share),
              //         ),
              //       ],
              //     )),
            ]);
  }
}
