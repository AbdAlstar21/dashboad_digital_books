// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable


import '../config.dart';

List<AdminData>? adminList;
String imageAdmins = images_path + "admins/";

class AdminData {
  String admin_id;
  String admin_name;
  String admin_pwd;
  String admin_email;
  bool admin_active;
  String admin_lastdate;
  String admin_note;
  String admin_thumbnail;
  AdminData({
    required this.admin_id,
    required this.admin_name,
    required this.admin_pwd,
    required this.admin_email,
    required this.admin_active,
    required this.admin_lastdate,
    required this.admin_note,
    required this.admin_thumbnail,

  });
}

