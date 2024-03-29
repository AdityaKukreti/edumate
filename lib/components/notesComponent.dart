import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackdu/videoDetails.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../api.dart';

class NotesContainer extends StatefulWidget {
  const NotesContainer({super.key, required this.videoId});

  final String videoId;

  @override
  State<NotesContainer> createState() => _NotesContainerState();
}

class _NotesContainerState extends State<NotesContainer> {
  List<Widget> notes = [];
  List<pw.Widget> pdfNotes = [];
  bool noteStatus = false;
  bool notesGenerated = true;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          child: SizedBox(
                            height: 160,
                            width: 300,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your notes are being generated",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                  CollectionReference notesDB =
                      FirebaseFirestore.instance.collection('notes');
                  TextEditingController controller = TextEditingController();

                    controller.text =
                        await YoutubeAPI().getNotes(widget.videoId);
                  notes = [];

                  if (controller.text != 'no notes')
                    {
                    notesDB.add({
                      'uid': FirebaseAuth.instance.currentUser?.uid,
                      'notes': controller.text,
                      'videoTitle': details.videoTitle,
                      'videoChannel': details.channelName,
                      'timeStamp': Timestamp.now(),
                      'thumbnail': details.channelThumbnail,
                      'videoThumbnail': details.videoThumbnail,
                      'videoId':details.videoId
                    });

                    List<String> splitData = controller.text.split('\n');
                    for (int i = 0; i < splitData.length; i++) {
                      String data = splitData[i];
                      if (data == '') {
                        notes.add(const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(""),
                        ));
                        pdfNotes.add(pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text("\n"),
                        ));
                      } else {
                        if (data.contains('<h>')) {
                          data = data.replaceAll('<h>', '');
                          data = data.replaceAll('</h>', '');
                          notes.add(Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                          ));
                          pdfNotes.add(pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              data,
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold),
                            ),
                          ));
                        } else if (data.contains('<s>')) {
                          data = data.replaceAll('<s>', '');
                          data = data.replaceAll('</s>', '');
                          notes.add(Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ));
                          pdfNotes.add(pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              data,
                              style: pw.TextStyle(
                                  fontSize: 14, fontWeight: pw.FontWeight.bold),
                            ),
                          ));
                        } else {
                          notes.add(Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ));
                          pdfNotes.add(pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              data,
                              style: const pw.TextStyle(fontSize: 14),
                            ),
                          ));
                        }
                      }
                    }
                    pdfNotes.add(pw.SizedBox(height: 50));
                    pdfNotes.add(pw.Align(
                        alignment: pw.Alignment.bottomRight,
                        child: pw.Text('these notes are generated using ai',
                            style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold))));
                    notesGenerated = true;

                  }
                    else
                      {
                        notes.add(const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Notes couldn't be generated for this video.",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                          ),
                        ));
                        notesGenerated = false;
                      }
                  noteStatus = true;
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text("Get AI-generated notes"),
            ),
            noteStatus
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(

                      children: [
                        SizedBox(
                          height: notesGenerated?0:20,
                        ),
                        for (int i = 0; i < notes.length; i++) notes[i],
                         const SizedBox(
                          height: 20,
                        ),
                        notesGenerated?TextButton(
                            onPressed: () async {
                              final doc = pw.Document();
                              doc.addPage(
                                pw.MultiPage(
                                  pageFormat: PdfPageFormat.a4,
                                  build: (pw.Context context) {
                                    return pdfNotes;
                                  },
                                ),
                              );
                              await Printing.layoutPdf(
                                  onLayout: (PdfPageFormat format) async =>
                                      doc.save());
                            },
                            child: const Text("Save Notes as PDF")):const SizedBox(),
                      ],
                    ),
                  )
                : const SizedBox(),
             const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
