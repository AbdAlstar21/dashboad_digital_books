// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:dashboard/pages/provider/loading.dart';
import '../function.dart';
import 'edit.dart';
import 'admin_data.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class SingleAdmin extends StatelessWidget {
  int admin_index;
  AdminData admins;
  SingleAdmin({Key? key, required this.admin_index, required this.admins})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var providerUser = Provider.of<LoadingControl>(context);
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              adminList!.removeAt(admin_index);
              deleteData(
                  "admin_id", admins.admin_id, "admin/delete_admin.php");
              providerUser.add_loading();
            },
            child: Container(
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.cancel,
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: admins.admin_thumbnail == ""
                ? ProfilePicture(
                    name: admins.admin_name,
                    radius: 31,
                    fontsize: 21,
                  )
                : ProfilePicture(
                    name: admins.admin_name,
                    // role: 'ADMINISTRATOR',
                    radius: 31,
                    fontsize: 21,
                    tooltip: true,
                    img: imageAdmins + admins.admin_thumbnail,
                    // 'https://avatars.githubusercontent.com/u/37553901?v=4',
                  ),
            // users.admin_thumbnail == ""
            // ? ImageNetwork(
            //     image: imageUsers + "user.png",
            //                 height: 400,
            //                 width: 55,
            //                 onLoading: const CircularProgressIndicator(
            //                   color: Colors.indigoAccent,
            //                 ),
            //                 onError: const Icon(
            //                   Icons.error,
            //                   color: Colors.red,
            //                 ),
            //               )
            //             : ImageNetwork(
            //                 image: imageUsers + users.admin_thumbnail,
            //                 height: 400,
            //                 width: 55,
            //                 onLoading: CircularProgressIndicator(
            //                   color: Colors.indigoAccent,
            //                 ),
            //                 onError: const Icon(
            //                   Icons.error,
            //                   color: Colors.red,
            //                 ),
            //               ),
            title: Text(
              admins.admin_name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(admins.admin_email),
                  Text(admins.admin_lastdate)
                ]),
            trailing: SizedBox(
              width: 30.0,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAdmin(
                                    admin_index: admin_index,
                                    admins: admins,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
