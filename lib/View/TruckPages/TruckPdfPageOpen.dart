import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Services/DatabaseServices.dart';

class TruckPdfPageOpen {
  final firestore = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  final DatabaseServices db = DatabaseServices();
  static Future<void> savePdf(String fileName, Uint8List bytesList) async {
    final output = await getTemporaryDirectory();
    var filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytesList);
    await OpenFile.open(filePath);
  }

  static Future<Uint8List> generate(
    BuildContext cont,
    String companyName,
    String companyAddress,
    String companyNumber,
    String companyEmail,
    String date,
    String startDate,
    String garage,
    String diesel,
    String maintenance,
    String toll,
    String wheel,
    int total,
  ) async {
    final DatabaseServices db = DatabaseServices();
    final firestore = FirebaseFirestore.instance;

    final auth = FirebaseAuth.instance;

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Text(companyName,
                textAlign: pw.TextAlign.start,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 19.sp,
                )),
            pw.Text(companyAddress,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 12.sp, fontWeight: pw.FontWeight.bold)),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(companyNumber,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.bold)),
                  pw.VerticalDivider(width: 20, thickness: 5),
                  pw.Text(companyEmail,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12.sp, fontWeight: pw.FontWeight.bold)),
                ]),
            pw.Expanded(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(height: 25.h),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Start Date : $startDate",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 16.sp)),
                          pw.Text("Start Date : $date",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 16.sp)),
                        ]),
                    pw.SizedBox(height: 20.h),
                    pw.Text("Total Expanses",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 18.sp)),
                    pw.SizedBox(height: 8.h),
                    pw.Divider(color: PdfColors.green, thickness: 3),
                    pw.SizedBox(height: 15.h),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Garage",
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Expanded(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 5.w),
                            child: pw.Divider(
                                color: PdfColors.black, thickness: 1),
                          )),
                          pw.Text(garage,
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 4.h),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Diesel",
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Expanded(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 5.w),
                            child: pw.Divider(
                                color: PdfColors.black, thickness: 1),
                          )),
                          pw.Text(diesel,
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 4.h),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Maintenance",
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Expanded(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 5.w),
                            child: pw.Divider(
                                color: PdfColors.black, thickness: 1),
                          )),
                          pw.Text(maintenance,
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 4.h),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Toll Tax",
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Expanded(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 5.w),
                            child: pw.Divider(
                                color: PdfColors.black, thickness: 1),
                          )),
                          pw.Text(toll,
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 4.h),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Wheel",
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.Expanded(
                              child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 5.w),
                            child: pw.Divider(
                                color: PdfColors.black, thickness: 1),
                          )),
                          pw.Text(wheel,
                              style: pw.TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 10.h),
                    pw.Text(
                        "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --"),
                    pw.SizedBox(height: 10.h),
                    pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Total",
                              style: pw.TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text("$total",
                              style: pw.TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                  ]),
            ),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(children: [
                    pw.Text('Bill Date : $date',
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
