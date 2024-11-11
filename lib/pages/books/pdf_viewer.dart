// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class PdfViewPage extends StatefulWidget {
  final String url;
  final String name;
  PdfViewPage({
    Key? key,
    required this.url,
    required this.name,
  }) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
//    loadPdf();
    print(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: SfPdfViewer.network(
          widget.url,
        ),
      ),
    );
  }
}
