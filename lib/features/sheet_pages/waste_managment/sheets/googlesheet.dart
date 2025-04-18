import 'dart:convert';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/features/sheet_pages/waste_managment/sheets/sheetscolumn.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SheetsFlutter {
  static late final String _sheetId;
  static late final Map<String, dynamic> _credentials;
  static late final GSheets _gsheet;
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      // Load credentials from assets
      final credentialsJson = await rootBundle.loadString(
        'google_credentials.json',
      );
      final fullConfig = jsonDecode(credentialsJson);

      // Extract sheet ID
      _sheetId = fullConfig['sheet_id'];

      // Remove sheet_id from credentials
      _credentials = Map<String, dynamic>.from(fullConfig);
      _credentials.remove('sheet_id');

      // Initialize GSheets
      _gsheet = GSheets(jsonEncode(_credentials));
      final spreadsheet = await _gsheet.spreadsheet(_sheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: "Waste");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
      print("Init completed successfully! of Waste.dart");
    } catch (e) {
      print("Error initializing Google Sheets: $e");
      print("Stack trace: ${StackTrace.current}");
    }
  }

  static Future<Worksheet> _getWorksheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(
    BuildContext context,
    List<Map<String, dynamic>> rowList,
  ) async {
    try {
      if (rowList.isEmpty ||
          rowList.any(
            (row) => row.values.contains(null) || row.values.contains(""),
          )) {
        CustomSnackbar.snackbarShow(
          context,
          "Please fill all required fields!",
        );
        return;
      }

      await _userSheet!.values.map.appendRows(rowList);
      CustomSnackbar.snackbarShow(context, "Details saved successfully!");
    } catch (e) {
      CustomSnackbar.snackbarShow(context, "Server error. Try again!");
      print("Error inserting data: $e");
    }
  }
}
