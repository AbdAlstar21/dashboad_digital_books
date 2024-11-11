//changed//
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:dashboard/pages/books/add_book.dart';
import 'package:dashboard/pages/books/books_data.dart';
import 'package:dashboard/pages/components/progres.dart';
import 'package:dashboard/pages/config.dart';
import 'package:dashboard/pages/function.dart';
import 'package:dashboard/pages/provider/loading.dart';

import '../function.dart';
import 'single_book.dart';

class BooksCategory extends StatefulWidget {
  final String? cat_id;
  final String? cat_name;
  BooksCategory({
    Key? key,
    this.cat_id,
    this.cat_name,
  }) : super(key: key);

  @override
  _BooksCategoryState createState() => _BooksCategoryState();
}

class _BooksCategoryState extends State<BooksCategory> {
  ScrollController? myScroll;
  GlobalKey<RefreshIndicatorState>? refreshKey;
  int i = 0;
  bool loadingList = false;
  void getDataBook(int count, String strSearch) async {
    print(widget.cat_id!);
    print(widget.cat_name!);

    loadingList = true;
    setState(() {});
    List arr = await getData(
        count, "books/readbook_cat.php", strSearch, "cat_id=${widget.cat_id}&");
    for (int i = 0; i < arr.length; i++) {
      bookList!.add(BooksData(
        book_id: arr[i]["book_id"], //
        cat_id: arr[i]["cat_id"],
        book_name: arr[i]["book_name"], //
        book_author_name: arr[i]["book_author_name"],
        book_lang: arr[i]["book_lang"], //
        book_block: arr[i]["book_block"] == "1" ? true : false,
        book_date: arr[i]["book_date"],
        book_summary: arr[i]["book_summary"],
        book_thumbnail: arr[i]["book_thumbnail"],
        book_eva: 5.655,
        book_download: 2001212145,
        book_Number_of_reviews: 12,
        book_size: 200, //
        book_publisher: "عبد الستار أبو عبيدة",
        book_file: arr[i]["book_file"], //
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
    bookList!.clear();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _appBarTitle = Text(widget.cat_name!);
    bookList = <BooksData>[];
    myScroll = ScrollController();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    getDataBook(0, "");

    myScroll?.addListener(() {
      if (myScroll!.position.pixels == myScroll?.position.maxScrollExtent) {
        i += 10;
        getDataBook(i, "");
        // ignore: avoid_print
        print("scroll");
      }
    });
  }

  Icon _searchIcon = const Icon(Icons.search);
  Widget? _appBarTitle;

  void _searchPressed(LoadingControl myProv) {
    if (_searchIcon.icon == Icons.search) {
      _searchIcon = const Icon(Icons.close);
      _appBarTitle = TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: "ابحث ..."),
        onChanged: (text) {
          // ignore: avoid_print
          print(text);

          bookList!.clear();
          i = 0;
          getDataBook(0, text);
          myProv.add_loading();
        },
      );
    } else {
      _searchIcon = const Icon(Icons.search);
      _appBarTitle = Text(widget.cat_name!);
    }
    myProv.add_loading();
  }

  bool isFabVisibleAdd = true;
  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<LoadingControl>(context);
    return Scaffold(
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
      // backgroundColor: Colors.white,
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
            bookList!.clear();
            getDataBook(0, "");
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
                    itemCount: bookList!.length,
                    itemBuilder: (context, index) {
                      final item = bookList![index];
                      return Dismissible(
                        key: Key(item.book_id),
                        direction: DismissDirection.startToEnd,
                        child: SingleBook(
                          book_index: index,
                          books: bookList![index],
                        ),
                        onDismissed: (direction) {
                          bookList!.remove(item);
                          deleteData(
                              "book_id", item.book_id, "books/delete_book.php");
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
      // bottomNavigationBar: Visibility(
      //   visible: isFabVisibleAdd,
      //   child: SizedBox(
      //     height: 50.0,
      //     child: Column(
      //       children: <Widget>[
      //         Container(
      //           alignment: Alignment.center,
      //           child: GestureDetector(
      //             onTap: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => const AddBooks()));
      //             },
      //             child: const Text(
      //               "اضافة كتاب جديد",
      //               style: TextStyle(color: Colors.white, fontSize: 20),
      //             ),
      //           ),
      //           height: 40.0,
      //           decoration: BoxDecoration(
      //               color: Colors.blue,
      //               borderRadius: BorderRadius.circular(40)),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
