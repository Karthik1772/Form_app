import 'dart:convert';
import 'package:demo/core/common/custom_snackbar.dart';
import 'package:demo/features/Energy_Consumption/sheets/sheetscolumn.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';

class SheetsFlutter {
  static const String _sheetId = "1P1J2yr7NrXwPtPlQ2BHdB58qaRgrV49pmKUw2Wl4R3Y";

  static final Map<String, dynamic> _credentials = jsonDecode('''
  {
    "type": "service_account",
    "project_id": "formapp2025",
    "private_key_id": "466682642e55e1ec646470d2ae7d8550c8f0ff8f",
    "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC0EJQC/Rd5Hk8r\\nzHFPb+QDxeFWxDxpKfwk7nfXKD+1GL+DnG0Yd/xfyrRcGPesaf6s9F/fg0qAADlJ\\ng/fL5vF4Bsjw3EK3kSaUtm0LapXN/n8mEv+vPbqJTYr1CmNgEnG4VNNr3Ddlhusw\\nyzVTtRWJxFILDLgNR2oHNgLrGahL9G7zWe+6c6++zdXjaCXvNKqtYJkamWa6gwIp\\nE/cUuyK0vykmQl3zJ0zDAjnX+f+N04IkGu0CaPIHsWlnFb5P3kZQq5M8joufnAYD\\nMFH5iC6cccQeCcHguDrmyzXoHk6ENOjZ1A1B+idgeE1rfv81HehOwlpi0caVP8tr\\n0Yvqg28RAgMBAAECgf8vK2ian9JWWCpFPvkv5g/FLUEqiZ2JrwXuZsneAx0tQ55n\\ny8KIdmYWcfNtbNz0vY+Jnzq+QpZxkZ1wNLHlKEp5Ns3MyuZvUAbbTi6invk/TTvh\\nrXhtX65N6ZJNPrtpn2tK7m20A6w/XGigD5uYogdSX6teWaadU+fim7OIAuCjhKRG\\nf3MpA+Tf2EP5kkEubQvMsq1zEFG+JjEc4gxHfFJCZLK6zfDNFJUCJ0LyET6qy75s\\n2TFgA2048pvd3YNTQPNYeyeiDDTB5rOB58hC6G0mi6Pgc9Y9/eD1++AlojNvZHLE\\nbxsDo2yo7v4S5WdtTW9e81wLClLpdenoN/sZ8cECgYEA3ArTgktfKxcCyOd00jyl\\nztbnT3k66kil/vU0NSjvC6kBNKZvv3VcGDBpBURkGnMjIIaTnazOWk2RRXTDfTgr\\nZsYipQuniV6uhdgnUhvN0tpY1gbhVIhDLsw5G0cVps8nRT4kYJ0313kMxhH3q6sQ\\n3neQByAVxngW2asjOS/9gFECgYEA0X1YebbJ33/+DPTwTbkGtrZJqIA9QFg3clYu\\n1KCD5Hw/6Bmy8/p+HJ0m2Q9ZC5NBx5nWEaSA3ey1LuoR0aml5CwUBdo9Rkcy2QgI\\nm/qWF8b5/1OkoRdDMu9vLe6J1QOrEmq/qu6+QHNLdDwhiS4fspKus6wX4rYy6iVV\\nwltgEsECgYEAlsbIVbCl3pXe76FB+ElcaFXznA5640yyifilNIP/AONmkxg03GFj\\noKOTYuuRGFqqyD/O6K0fnNsn3wr6ZVRW0Q6VcLiCrWt2dPo/P1EUARZi5w1B27Wf\\nK3L+8oUL/ghWZWkGbjlsqTYmHZb0Oep3HamZxHgk06E4LyDIewg6UXECgYEAjOo3\\n/YeLO6ApECYjDuULMxRjb8jzarjscyitz7E5hxRdGI9Q5PT2p+C+JPxB9ZtUgCNm\\n7+8sEBwNtEUXP2VSha1wuo8W8JMsDPlucR2aoNvjhnCJKSMwvK56pvbyGCujg3vy\\n+dQmfcwQUVuxY0l3YPNyOMHmP0Y38XCzw00bzwECgYAvSgzrdZyUBzAMIRBr5nL4\\nBc2Gxko46HHzjJzj4ql2ZfSKe3lpkrINA8c6BYUilGwSKwIX5ysbQicQAF2QpwCu\\nfA3FjPfPCUpHSI9TFmxcDeYFPAv0vrYRX5KNogh04cd/q1noNXYnWg5FDcKLRA3h\\nZT9YBPlDbRnHvis4u1urwg==\\n-----END PRIVATE KEY-----\\n",
    "client_email": "fluttersheets@formapp2025.iam.gserviceaccount.com",
    "client_id": "105393478974228434641",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheets%40formapp2025.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
  ''');
  static final _gsheet = GSheets(jsonEncode(_credentials));
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheet.spreadsheet(_sheetId);
      _userSheet = await _getWorksheet(spreadsheet, title: "Energy");

      final firstRow = await _userSheet!.values.row(1);
      if (firstRow.isEmpty) {
        await _userSheet!.values.insertRow(1, SheetsColumn.getColumns());
        print("Column headers created in Transportation sheet");
      }
    } catch (e) {
      print("Error initializing Google Sheets: \$e");
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

  static Future insert(BuildContext context, List<Map<String, dynamic>> rowList) async {
    try {
      if (rowList.isEmpty || rowList.any((row) => row.values.contains(null) || row.values.contains(""))) {
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
