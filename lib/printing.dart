import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PrintDocument extends StatefulWidget {
  @override
  _PrintDocumentState createState() => _PrintDocumentState();
}

class _PrintDocumentState extends State<PrintDocument> {
  static const String htmlHeader =
      '<!DOCTYPE html><html><head> <style> .rectangle { height: 128px; width: 50%; border-style: solid; border-color: #707B7C; border-radius: 25px; margin: 0 auto; } .space { height: 32px; width: 50%; background-color: #fff; } tfoot { display: table-footer-group; vertical-align: middle; border-color: inherit; } @page { margin: 2mm } table, td, th { border: 1px solid #566573; text-align: left; } table { font-size:1vw; border-collapse: collapse; width: 100%; } th, td { padding: 15px; } .header, .header-space, .footer, .footer-space { height: 10px; } .header { position: fixed; top: 0; } .footer { position: fixed; bottom: 10; } </style></head><body>';
  static const String htmlPaperTitle =
      '<body> <h2>Mickey and Honey Salon</h2> <h3>Daily Stock Report</h3> <p>Date: </p> <table> <thead>';
  static const String htmlTableTitle =
      ' <th>No.</th> <th>Product Name</th> <th>Quantity</th> <th>Action</th> <th>Action Description</th> <th>Employee ID</th> <th>Employee Name</th> <th>Date</th> </tr> </thead> <tbody class="content">';
  static const String htmlFooter =
      ' </tbody> <tfoot> </tfoot> </table></body><div class="space"></div><p align="center">Please Sign Here</p><div class="rectangle"></div></html>';

  Future<String> getReportData() async {
    String result = '';
    for (var i = 0; i < 50; i++) {
      result +=
          '<tr> <td>$i</td> <td>Lisa Sampoo</td> <td>10</td> <td>Sale</td> <td>Sale to customer</td> <td>japang_ly_001</td> <td>Ly Japang</td> <td>7/23/2019 at 9:00:01 AM</td> </tr>';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printing Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print),
        tooltip: 'Print Document',
        onPressed: () async {
          print(DateTime.now());
          await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async {
              return await Printing.convertHtml(
                format: format,
                html: htmlHeader +
                    htmlPaperTitle +
                    htmlTableTitle +
                    await getReportData() +
                    htmlFooter,
              );
            },
          );
        },
      ),
      body: Center(
        child: Text('Click on button below to print'),
      ),
    );
  }
}
