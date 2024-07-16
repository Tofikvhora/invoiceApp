import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newmahirroadways/Services/DatabaseServices.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SavePdfPage {
  final firestore = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  final DatabaseServices db = DatabaseServices();
  static List<String> headers = [
    'Sr No',
    'Date',
    'vehicle No',
    'From',
    'To',
    'feet',
    'Hold',
    'Amount',
    "Payment",
    "Hr Number",
  ];
  static List<String> diHeaders = [
    'SR NO',
    'Amount',
    'Liters',
    'Date',
    'Vehicle No'
  ];
  static Future<void> savePdf(String fileName, Uint8List bytesList) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytesList);
    await OpenFile.open(filePath);
  }

  static Future<Uint8List> generate(
    BuildContext cont,
    List<List> table,
    List<List> diTable,
    String companyName,
    String companyAddress,
    String companyNumber,
    String companyEmail,
    int total,
    int labour,
    int days,
    String billDate,
    int diTotalAmount,
    int diTotalLiters,
  ) async {
    final DatabaseServices db = DatabaseServices();
    final firestore = FirebaseFirestore.instance;

    final auth = FirebaseAuth.instance;
    final double totalTableWidth = PdfPageFormat.letter.width - 2 * 0.5;
    final double column1Width = totalTableWidth * 0.09; // 15% of total width
    final double column2Width = totalTableWidth * 0.09; // 15% of total width
    final double column3Width = totalTableWidth * 0.1; // 15% of total width
    final double column4Width = totalTableWidth * 0.1; // 10% of total width
    final double column5Width = totalTableWidth * 0.1; // 15% of total width
    final double column6Width = totalTableWidth * 0.04; // 15% of total width
    final double column7Width = totalTableWidth * 0.09; // 15% of total width

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Text(companyName,
                textAlign: pw.TextAlign.start,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 23.sp,
                )),
            pw.Text(companyAddress,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 18.sp,
                )),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(companyNumber,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 17.sp,
                      )),
                  pw.VerticalDivider(width: 20, thickness: 5),
                  pw.Text(companyEmail,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 17.sp,
                      )),
                ]),
            table.isEmpty ? pw.SizedBox() : pw.SizedBox(height: 10.h),
            pw.Expanded(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.SizedBox(height: 10.h),
                    table.isEmpty
                        ? pw.SizedBox()
                        : pw.Table.fromTextArray(
                            data: table,
                            headers: headers,
                            cellHeight: 20.h,
                            cellPadding:
                                const pw.EdgeInsets.symmetric(horizontal: 2),
                            border: null,
                            cellAlignments: {
                              0: pw.Alignment.center, // Alignment for 'Amount'
                              1: pw.Alignment.center, // Alignment for 'From'
                              2: pw.Alignment.center, // Alignment for 'To'
                              3: pw.Alignment.center, // Alignment for 'Hold'
                              4: pw.Alignment.center, // Alignment for 'Date'
                              5: pw.Alignment
                                  .center, // Alignment for 'Vehicle No'
                              6: pw.Alignment.center,
                              7: pw.Alignment.center,
                              8: pw.Alignment.center,
                            },
                            headerStyle: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 11.sp,
                                color: PdfColors.white),
                            cellStyle: pw.TextStyle(
                                fontSize: 11.sp,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black),
                            columnWidths: {
                              0: pw.FixedColumnWidth(column1Width),
                              1: pw.FixedColumnWidth(column2Width),
                              2: pw.FixedColumnWidth(column3Width),
                              3: pw.FixedColumnWidth(column4Width),
                              4: pw.FixedColumnWidth(column5Width),
                              5: pw.FixedColumnWidth(column6Width),
                              6: pw.FixedColumnWidth(
                                  column7Width), // Width for 'Labour Amount'
                            },
                            headerDecoration: const pw.BoxDecoration(
                              color: PdfColors.black,
                            ),
                          ),
                    table.isEmpty ? pw.SizedBox() : pw.SizedBox(height: 10.h),
                    table.isEmpty
                        ? pw.SizedBox()
                        : pw.Divider(
                            color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 1.h),
                    table.isEmpty
                        ? pw.SizedBox()
                        : pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                                pw.Text('TOTAl AMOUNT : $total',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 14.sp,
                                    )),
                                // pw.Text('TOTAl LABOUR CHARGES : $labour',
                                //     textAlign: pw.TextAlign.center,
                                //     style: pw.TextStyle(
                                //       fontSize: 9.sp,
                                //     )),
                                // pw.Text('TOTAl Hold in Days : $days day',
                                //     textAlign: pw.TextAlign.center,
                                //     style: pw.TextStyle(
                                //       fontSize: 9.sp,
                                //     )),
                              ]),
                    table.isEmpty ? pw.SizedBox() : pw.SizedBox(height: 20.h),
                    diTable.isEmpty
                        ? pw.SizedBox()
                        : pw.Table.fromTextArray(
                            data: diTable,
                            headers: diHeaders,
                            cellHeight: 20,
                            cellPadding:
                                const pw.EdgeInsets.symmetric(horizontal: 1),
                            border: null,
                            cellAlignments: {
                              0: pw.Alignment
                                  .centerLeft, // Alignment for 'Amount'
                              1: pw
                                  .Alignment.centerLeft, // Alignment for 'From'
                              2: pw.Alignment.centerLeft, // Alignment for 'To'
                              3: pw.Alignment.center, // Alignment for 'Hold'
                              4: pw
                                  .Alignment.centerLeft, // Alignment for 'Date'
                              5: pw.Alignment
                                  .centerLeft, // Alignment for 'Vehicle No'
                              6: pw.Alignment.centerLeft,
                              7: pw.Alignment.centerLeft,
                            },
                            headerStyle: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                color: PdfColors.white),
                            cellStyle: pw.TextStyle(
                                fontSize: 9,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black),
                            headerDecoration: const pw.BoxDecoration(
                              color: PdfColors.green600,
                            ),
                          ),
                    diTable.isEmpty ? pw.SizedBox() : pw.SizedBox(height: 10.h),
                    diTable.isEmpty
                        ? pw.SizedBox()
                        : pw.Divider(
                            color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 1.h),
                    diTable.isEmpty
                        ? pw.SizedBox()
                        : pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                                pw.Text('TOTAl AMOUNT : $diTotalAmount',
                                    textAlign: pw.TextAlign.end,
                                    style: pw.TextStyle(
                                      fontSize: 11.sp,
                                    )),
                                pw.Text('TOTAl LITERS : $diTotalLiters',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10.sp,
                                    )),
                              ]),
                  ]),
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(children: [
                    pw.Text('Bill Date : $billDate',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15.sp,
                        )),
                  ]),
                  pw.Text(companyName,
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 15.sp,
                      )),
                ]),
          ]);
        }));
    return pdf.save();
  }
}
