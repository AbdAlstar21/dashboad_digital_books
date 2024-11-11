import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';

import 'package:dashboard/pages/provider/loading.dart';
import 'package:path_provider/path_provider.dart';

import '../config.dart';
import '../function.dart';
import 'books_data.dart';
import 'edit.dart';
import 'pdf_viewer.dart';

class SingleBook extends StatelessWidget {
  int book_index;
  BooksData books;
  SingleBook({Key? key, required this.book_index, required this.books})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var providerBook = Provider.of<LoadingControl>(context);

    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewPage(
              url: files_path + books.book_file,
              name: books.book_name,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blue[300],
                  ),
                  child:
                      books.book_thumbnail == "" || books.book_thumbnail == null
                          ? ImageNetwork(
                              image: imageBook + "def.png",
                              width: 110,
                              height: 140,
                              onLoading: const CircularProgressIndicator(
                                color: Colors.indigoAccent,
                              ),
                              onError: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            )
                          : ImageNetwork(
                              image: imageBook + books.book_thumbnail,
                              width: 110,
                              height: 140,
                              onLoading: CircularProgressIndicator(
                                color: Colors.indigoAccent,
                              ),
                              onError: const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      books.book_name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books.book_author_name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(books.book_eva.toString()),
                              Padding(padding: EdgeInsets.only(right: 10)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: Colors.green,
                                  ),
                                  Text(books.book_download.toString()),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.blueAccent,
                              ),
                              Text(books.book_date),
                            ],
                          )
                        ]),
                    trailing: Column(
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => EditBooks(
                        //                   book_index: book_index,
                        //                   books: books,
                        //                 )));
                        //   },
                        //   child: Container(
                        //     margin: const EdgeInsets.only(bottom: 5),
                        //     padding: const EdgeInsets.all(4),
                        //     child: const Icon(
                        //       Icons.edit,
                        //       color: Colors.white,
                        //       size: 16,
                        //     ),
                        //     decoration: BoxDecoration(
                        //         color: Colors.blue,
                        //         borderRadius: BorderRadius.circular(5.0)),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            bookList!.removeAt(book_index);
                            deleteData("book_id", books.book_id,
                                "books/delete_book.php");
                            providerBook.add_loading();
                          },
                          child: Container(
                            // margin:const EdgeInsets.only(top:5),
                            padding: const EdgeInsets.all(6),
                            // margin: const EdgeInsets.only(top: 20),

                            child: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 188, 5),
                              size: 24,
                            ),
                            decoration: BoxDecoration(
                                color: pcBlue,
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
