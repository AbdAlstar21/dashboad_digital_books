// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, unused_import, must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';

import 'package:dashboard/pages/books/books_cat.dart';
import 'package:dashboard/pages/provider/loading.dart';

import '../config.dart';
import '../function.dart';

List<ReportData>? reportList;

class ReportData {
  String rep_id;
  String rep_not;
  String rep_date;
  ReportData({
    required this.rep_id,
    required this.rep_not,
    required this.rep_date,
  });
}
