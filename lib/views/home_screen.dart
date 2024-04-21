import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/utils/modal_class.dart';
import 'package:quotes_app/utils/quotes_list.dart';
import 'package:quotes_app/utils/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isList = true;
  List<Quotes> l = [];

  List<Quotes> updateCategoryList() {
    if (category != 'all') {
      l = allQuotes
          .where(
            (element) => element.category == category,
          )
          .toList();
    } else {
      l.addAll(allQuotes);
    }
    return l;
  }

  void updateCategory(String newCategory) {
    setState(() {
      category = newCategory;
      l = updateCategoryList();
    });
  }

  void showRandomQuotes() {
    Random r = Random();
    List<Quotes> l = updateCategoryList();
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
    allCategories.insert(0, 'all');
    Future.delayed(const Duration(microseconds: 500), () {
      showRandomQuotes();
    });
    l = updateCategoryList();
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
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: allCategories
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        updateCategory(e);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: category == e
                                ? const Border(
                                    bottom: BorderSide(color: Colors.blueGrey))
                                : null),
                        margin: const EdgeInsets.all(14),
                        child: Text(
                          e,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: category == e
                                  ? Colors.blue.shade700
                                  : Colors.blueGrey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            flex: 12,
            child: Scrollbar(
              thickness: 10,
              interactive: true,
              child: GridView.builder(
                itemCount: l.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isList == true ? 2 : 1,
                  mainAxisExtent: isList == true ? null : 180,
                  // childAspectRatio: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.instance.detailScreen,
                          arguments: l[index]);
                    },
                    child: Container(
                      color: Colors.blueGrey.shade50,
                      margin: index % 2 == 0
                          ? const EdgeInsets.only(left: 12, right: 8)
                          : const EdgeInsets.only(right: 12, left: 8),
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
                              l[index].quote,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '-${l[index].author}',
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar appBar({
  required bool isList,
  required void Function() toggleList,
}) {
  return AppBar(
    title: Text(
      'ZenQuotes',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    ),
    forceMaterialTransparency: true,
    actions: [
      IconButton(
          onPressed: toggleList,
          icon: Icon(isList ? Icons.grid_view_outlined : Icons.menu))
    ],
  );
}
