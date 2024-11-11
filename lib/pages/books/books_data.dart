// ignore_for_file: unused_import, non_constant_identifier_names, must_be_immutable
//changed//
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';

import 'package:dashboard/pages/provider/loading.dart';

import '../config.dart';
import '../function.dart';
import 'edit.dart';

List<BooksData>? bookList;
String imageBook = images_path + "books/";
String fileBook = files_path;

class BooksData {
  String? cat_id;
  String book_id;
  String book_name;
  String book_author_name;
  String book_lang;
  bool book_block;
  String book_date;
  String book_summary;
  String book_thumbnail;
   String? book_image;
  double? book_eva;
  int? book_download;
  int? book_page_number;
  int? book_Number_of_reviews;
  double? book_size;
  String book_publisher;
   String book_file;
  

  BooksData({
     this.cat_id,
    required this.book_id,
    required this.book_name,
    required this.book_author_name,
    required this.book_lang,
    required this.book_block,
    required this.book_date,
    required this.book_summary,
    required this.book_thumbnail,
    this.book_image,
    this.book_eva,
    this.book_download,
    this.book_page_number,
    this.book_Number_of_reviews,
    this.book_size,
    required this.book_publisher,
    required this.book_file,
  });
}
