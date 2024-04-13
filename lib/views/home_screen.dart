import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/utils/modal_class.dart';
import 'package:quotes_app/utils/quotes_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isList = true;

  void showRandomQuotes() {
    Random r = Random();
    String category = 'art';

    List<Quotes> l = allQuotes
        .where(
          (element) => element.category == category,
        )
        .toList();

    Quotes q = l[r.nextInt(l.length)];

    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          "Welcome",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        alignment: Alignment.center,
        children: [
          Text(
            q.quote,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 500), () {
      showRandomQuotes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          isList: isList,
          toggleList: () {
            isList = !isList;
            setState(() {});
          }),
      body: Column(
        children: [
          // cate
          categoryList(),
          Expanded(
            flex: 12,
            child: Scrollbar(
              thickness: 10,
              interactive: true,
              child: GridView.builder(
                  itemCount: allQuotes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isList == true ? 2 : 1,
                    mainAxisExtent: isList == true ? null : 180,
                    // childAspectRatio: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.blueGrey.shade50,
                        // height: 150,
                        // width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        padding: isList == true
                            ? const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              )
                            : const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                allQuotes[index].quote,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '-${allQuotes[index].author}',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
          // quotes
          // quoteGridView(),
          // isList ? quoteListView() : quoteGridView(),
        ],
      ),
    );
  }
}

Widget quoteListView() {
  return Expanded(
    flex: 12,
    child: ListView.separated(
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(allQuotes[index].quote),
          children: [
            Text(allQuotes[index].author),
            Text(allQuotes[index].category),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: allQuotes.length,
    ),
  );
}

// Widget quoteGridView() {
//   return Expanded(
//     flex: 12,
//     child: Scrollbar(
//       thickness: 10,
//       interactive: true,
//       child: GridView.builder(
//           itemCount: allQuotes.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: isList == true ? 2 : 1,
//             // childAspectRatio: 1,
//             crossAxisSpacing: 5,
//             mainAxisSpacing: 5,
//           ),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 150,
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     Text(
//                       allQuotes[index].quote,
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                     Text(
//                       '-${allQuotes[index].author}',
//                       style: const TextStyle(color: Colors.black),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     ),
//   );
// }

AppBar appBar({
  String title = "Home Page",
  required bool isList,
  required void Function() toggleList,
}) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
          onPressed: toggleList,
          icon: Icon(isList ? Icons.grid_view_outlined : Icons.menu))
    ],
  );
}

Widget categoryList() {
  return Expanded(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: allCategories
          .map(
            (e) => Container(
              decoration: BoxDecoration(color: Colors.pink.shade50),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              child: Text(e),
            ),
          )
          .toList(),
    ),
  );
}
