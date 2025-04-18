import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';
import 'package:Formify/core/common/custom_snackbar.dart';
import 'package:Formify/features/sheet_pages/Demographic_Information/sheets/sheetscolumn.dart';

class SheetsFlutter {
  static final String _sheetId = dotenv.env['GOOGLE_SHEET_ID'] ?? '';
  static final String _privateKey = dotenv.env['PRIVATE_KEY']?.replaceAll(r'\n', '\n') ?? '';

  static final Map<String, dynamic> _credentials = {
    "type": "service_account",
    "project_id": "formapp2025",
    "private_key_id": "466682642e55e1ec646470d2ae7d8550c8f0ff8f",
    "private_key": _privateKey,
    "client_email": "fluttersheets@formapp2025.iam.gserviceaccount.com",
    "client_id": "105393478974228434641",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheets%40formapp2025.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  static final _gsheet = GSheets(jsonEncode(_credentials));
  static Worksheet? _userSheet;

  static Future<void> init() async {
    try {
      final spreadsheet = await _gsheet.spreadsheet(_sheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: "Energy");
      final firstRow = SheetsColumn.getColumns();
      await _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      debugPrint("Error initializing Google Sheets: $e");
    }
  }

  static Future<Worksheet> _getWorksheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (_) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<bool> checkIfEmailExists(String email) async {
    if (_userSheet == null) return false;
    final rows = await _userSheet!.values.allRows();
    final emailIndex = SheetsColumn.getColumns().indexOf(SheetsColumn.email);

    for (final row in rows) {
      if (row.length > emailIndex && row[emailIndex] == email) {
        return true;
      }
    }
    return false;
  }

  static Future<void> insert(BuildContext context, List<Map<String, dynamic>> rowList) async {
    try {
      if (rowList.isEmpty || rowList.any((row) => row.values.contains(null) || row.values.contains(''))) {
        CustomSnackbar.snackbarShow(context, "Please fill all required fields!");
        return;
      }
      await _userSheet!.values.map.appendRows(rowList);
      CustomSnackbar.snackbarShow(context, "Details saved successfully!");
    } catch (e) {
      CustomSnackbar.snackbarShow(context, "Server error. Try again!");
    }
  }
}
