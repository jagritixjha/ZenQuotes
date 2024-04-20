import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/utils/modal_class.dart';

class QuoteDetailsScreen extends StatefulWidget {
  const QuoteDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => QuoteDetailsScreenState();
}

List<TextStyle> fontStyles = [
  GoogleFonts.roboto(),
  GoogleFonts.lato(),
  GoogleFonts.openSans(),
  GoogleFonts.montserrat(),
  GoogleFonts.nunito(),
  GoogleFonts.oswald(),
  GoogleFonts.sanchez(),
  GoogleFonts.poppins(),
];

class QuoteDetailsScreenState extends State<QuoteDetailsScreen> {
  double opacity = 1;
  double imageOpacity = 0.6;
  Color scaffoldBg = Colors.white;
  GlobalKey key = GlobalKey();
  // String? fonts;
  TextStyle selectedStyle = GoogleFonts.roboto();

  Future<File> getFiles() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image images = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? bytes = await images.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List unit8 = bytes!.buffer.asUint8List();
    Directory direc = await getTemporaryDirectory();
    File file = await File(
        '${direc.path}/QA-${DateTime.now().microsecondsSinceEpoch}.png');
    file.writeAsBytesSync((unit8));
    return file;
  }

  @override
  Widget build(BuildContext context) {
    Quotes quotes = ModalRoute.of(context)!.settings.arguments as Quotes;
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (value) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            alignment: Alignment.center,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'Alert',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            content: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Yes",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                ),
              )
            ],
          ),
        );
      },
      child: Scaffold(
        backgroundColor: scaffoldBg.withOpacity(opacity),
        appBar: AppBar(
          backgroundColor: scaffoldBg.withOpacity(opacity),
          title: const Text(
            'Customize',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                scaffoldBg = Colors.white;
                selectedStyle = GoogleFonts.poppins();
                opacity = 1;
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: RepaintBoundary(
                key: key,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(imageOpacity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        quotes.quote,
                        textAlign: TextAlign.center,
                        style: selectedStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "- ${quotes.author}",
                        style: selectedStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Background Color",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              scaffoldBg = Colors.primaries[index];
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.primaries[index],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 4,
                          );
                        },
                        itemCount: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Background Opacity",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Slider(
                      value: opacity,
                      min: 0.5,
                      max: 1,
                      onChanged: (value) {
                        opacity = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Font Family",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                selectedStyle = fontStyles[index];
                              });
                            },
                            child: Text(
                              "Abc",
                              style: fontStyles[index].copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 6,
                          );
                        },
                        itemCount: fontStyles.length,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            '${quotes.quote}\n\n-${quotes.author}'))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Quote copied to clipboard'),
                                    ),
                                  );
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                side: const BorderSide(
                                  color: Colors.black87,
                                  width: 1.5,
                                ),
                              ),
                              icon: const Icon(
                                Icons.copy_outlined,
                                color: Colors.black87,
                              ),
                              label: const Text(
                                "Copy",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                ImageGallerySaver.saveFile(
                                        (await getFiles()).path,
                                        isReturnPathOfIOS: true)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Saved to Gallery'),
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                side: const BorderSide(
                                  color: Colors.black87,
                                  width: 1.5,
                                ),
                              ),
                              icon: const Icon(
                                Icons.save_alt_outlined,
                                color: Colors.black87,
                              ),
                              label: const Text(
                                "Save",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> fontFamilies = [
  'Roboto',
  'Lato',
  'Open Sans',
  'Montserrat',
  'Nunito',
  'Oswald',
  'Source Sans Pro',
  'Poppins',
];
