import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:printing/printing.dart';
import 'package:image/image.dart' as imageUtils;

class TicketDetailPdf extends StatefulWidget {
  final List<int>? pdf;

  const TicketDetailPdf({this.pdf});
  @override
  TicketDetailPdfState createState() {
    return TicketDetailPdfState();
  }
}

class TicketDetailPdfState extends State<TicketDetailPdf>
    with SingleTickerProviderStateMixin {
  Future<Image>? myImage;
  Uint8List? myImageUint8;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    setState(() async {});
  }

  @override
  Widget build(BuildContext context) {
    myImageUint8 = Uint8List.fromList(widget.pdf!);
    print("myImageee $myImage");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf Printing Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: MemoryImage(myImageUint8!, scale: 1.0))),
        //child: Image.memory(myImageUint8),//child: Text('i don know'),//
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _showSources,
        child: const Icon(Icons.code),
      ),
    );
  }

  void _showSources() async {
    setState(() async {
      Uint8List data =
          (await rootBundle.load('images/icon.png')).buffer.asUint8List();
      myImageUint8 = data;
      print("data1 $data data2");
    });
    /*ul.launch(
      'https://github.com/DavBfr/dart_pdf/blob/master/demo/lib/${_tabUrl[_tab]}',
    );*/
    ///await Printing.sharePdf(bytes: pdf, filename: 'my-document.pdf');
  }
}
