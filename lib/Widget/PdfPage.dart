import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPage {
  static List<String> headers = [
    'Sr No',
    'Amount',
    'From',
    'To',
    'Labour',
    'Hold',
    'Date',
    'vehicle No'
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
    List<List> all,
    String companyName,
    int total,
    int labour,
    int days,
    String billDate,
    List<List> dieselData,
    int diTotalAmount,
    int diTotalLiters,
  ) async {
    final double totalTableWidth = PdfPageFormat.letter.width - 2 * 20;
    final double column1Width = totalTableWidth * 0.1; // 15% of total width
    final double column2Width = totalTableWidth * 0.1; // 15% of total width
    final double column3Width = totalTableWidth * 0.1; // 15% of total width
    final double column4Width = totalTableWidth * 0.1; // 10% of total width
    final double column5Width = totalTableWidth * 0.1; // 15% of total width
    final double column6Width = totalTableWidth * 0.1; // 15% of total width
    final double column7Width = totalTableWidth * 0.1; // 15% of total width
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Expanded(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('FROM-TO Form',
                              textAlign: pw.TextAlign.start,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.sp,
                              )),
                          pw.Text(companyName,
                              textAlign: pw.TextAlign.start,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 19.sp,
                              )),
                        ]),
                    pw.SizedBox(height: 10.h),
                    pw.Table.fromTextArray(
                      data: all,
                      headers: headers,
                      cellHeight: 20,
                      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 4),
                      border: null,
                      cellAlignments: {
                        0: pw.Alignment.centerLeft, // Alignment for 'Amount'
                        1: pw.Alignment.centerLeft, // Alignment for 'From'
                        2: pw.Alignment.centerLeft, // Alignment for 'To'
                        3: pw.Alignment.center, // Alignment for 'Hold'
                        4: pw.Alignment.centerLeft, // Alignment for 'Date'
                        5: pw
                            .Alignment.centerLeft, // Alignment for 'Vehicle No'
                        6: pw.Alignment.centerLeft,
                        7: pw.Alignment.centerLeft,
                      },
                      headerStyle: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 9),
                      cellStyle: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
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
                        color: PdfColors.grey300,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Divider(
                        color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 1.h),
                    pw.Divider(
                        color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 10.h),
                    pw.Text('TOTAl AMOUNT = $total',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12.sp,
                        )),
                    pw.Text('TOTAl LABOUR CHARGES = $labour',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12.sp,
                        )),
                    pw.Text('TOTAl Hold in Days = $days day',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12.sp,
                        )),
                    pw.SizedBox(height: 20.h),
                    pw.Divider(
                        color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 20.h),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('DIESEL Form',
                              textAlign: pw.TextAlign.start,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.sp,
                              )),
                        ]),
                    pw.SizedBox(height: 10.h),
                    pw.Table.fromTextArray(
                      data: dieselData,
                      headers: diHeaders,
                      cellHeight: 20,
                      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 1),
                      border: null,
                      cellAlignments: {
                        0: pw.Alignment.centerLeft, // Alignment for 'Amount'
                        1: pw.Alignment.centerLeft, // Alignment for 'From'
                        2: pw.Alignment.centerLeft, // Alignment for 'To'
                        3: pw.Alignment.center, // Alignment for 'Hold'
                        4: pw.Alignment.centerLeft, // Alignment for 'Date'
                        5: pw
                            .Alignment.centerLeft, // Alignment for 'Vehicle No'
                        6: pw.Alignment.centerLeft,
                        7: pw.Alignment.centerLeft,
                      },
                      headerStyle: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 10),
                      cellStyle: pw.TextStyle(
                          fontSize: 9, fontWeight: pw.FontWeight.bold),
                      // columnWidths: {
                      //   0: pw.FixedColumnWidth(column1Width),
                      //   1: pw.FixedColumnWidth(column2Width),
                      //   2: pw.FixedColumnWidth(column3Width),
                      //   3: pw.FixedColumnWidth(column4Width),
                      //   4: pw.FixedColumnWidth(column5Width),
                      //   5: pw.FixedColumnWidth(column6Width),
                      //   6: pw.FixedColumnWidth(
                      //       column7Width), // Width for 'Labour Amount'
                      // },
                      headerDecoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Divider(
                        color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 1.h),
                    pw.Divider(
                        color: PdfColors.black, height: 10, thickness: 1),
                    pw.SizedBox(height: 10.h),
                    pw.Text('TOTAl LITERS = $diTotalLiters',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12.sp,
                        )),
                    pw.Text('TOTAl AMOUNT = $diTotalAmount',
                        textAlign: pw.TextAlign.end,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12.sp,
                        )),
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
