import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../orders/models/order_items_model.dart';
import '../personalization/controllers/user_controller.dart';

Future<Uint8List> pdfBuilder(List<OrderItemsModel> orderItems) async {
  final pdf = Document();
  final userController = UserController.instance;

  // Define table headers
  List<String> detailsHeaders = [
    'S.No',
    'Product Description',
    'Product Code',
    'Qty',
    'Price',
    'Discount',
    'Amount'
  ];

  // Convert order items to a list of lists
  List<List<String>> itemData = [];
  int i = 0;
  for (OrderItemsModel orderItem in orderItems) {
    i++;
    List<String> itemRow = [
      i.toString(),
      orderItem.productDesc,
      orderItem.productRef,
      orderItem.quantity.toString(),
      orderItem.rate.toString(),
      orderItem.discountedPrice.toString(),
      MOHelperFunctions.getDiscountedAmount(orderItem.rate,orderItem.discountedPrice, orderItem.quantity).toString(),
    ];
    itemData.add(itemRow);
  }

  // Calculate column widths
  Map<int, TableColumnWidth> columnWidths = {};
  for (int i = 0; i < detailsHeaders.length; i++) {
    double maxWidth = detailsHeaders[i].length * 17.0;
    for (List<String> rowData in itemData) {
      double cellWidth = rowData[i].length * 8.0;
      if (cellWidth > maxWidth) {
        maxWidth = cellWidth;
      }
    }
    columnWidths[i] = FixedColumnWidth(maxWidth);
  }

  // Calculate total and tax
  double total = itemData
      .map((rowData) => double.parse(rowData[6]))
      .fold(0, (prev, amount) => prev + amount) ;
  double tax = total * 0.1; // 10% tax
  double totalWithTax=total+tax;

  // Define invoice data
  List<List<String>> leftInvoiceData = [
    ['Invoice No',': 1001'],
    ['Invoice Date',': 2024-03-23'],
    ['Via',': Air' ],
    ['Purchase Order',': PO-1122'],
    ['Project',': N/A'],
  ];
  // Define invoice data
  List<List<String>> rightInvoiceData = [
    ['Terms',': Net 30'],
    ['Ship Date',': 2024-04-22'],
    ['FOB',': N/A'],
    ['Rep',': Scott'],
  ];

  // Define bill to and ship to data
  List<List<String>> billToShipToData = [
    [
      'Bill To: ${userController.user.value.billingAddress}',
      'Ship To:\nJane Doe\n456 Main St\nCity, State, Zip\nCountry'
    ],
  ];


  List<String> sbToHeader = [
    'Bill To',
    'Ship To',
  ];

  String formattedBillingAddress=userController.user.value.billingAddress.replaceAll(',', '\n');
  String formattedShippingAddress=userController.user.value.shippingAddress.replaceAll(',', '\n');

  // Sample billtodata rows
  List<List<String>> billTodata = [
    ['${formattedBillingAddress}','${formattedShippingAddress}'],

  ];
  // Calculate column widths
  Map<int, TableColumnWidth> invoiceColumnWidths = {
    0: FixedColumnWidth(100),
    1: FixedColumnWidth(167.5),
  };
  // Calculate width for Tax and Total columns
  double taxWidth = 'Tax'.length * 95; // Adjust factor as needed
  double totalWidth = 'Total'.length * 95; // Adjust factor as needed
  double maxWidth = taxWidth > totalWidth ? taxWidth : totalWidth;

  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/logos/orthotrade-logo-black.png')).buffer.asUint8List());
  String? _bgShape = await rootBundle.loadString('assets/logos/invoice.svg');

  // Add pages to PDF
  int itemsPerPage = 10; // Number of items per page
  int pageCount = (itemData.length / itemsPerPage).ceil();



  final theme = PageTheme(
    margin: const EdgeInsets.all(30), // Sets margin for the entire page
    pageFormat: PdfPageFormat.a4, // Sets page format (e.g., A4 size)
    buildBackground: (context) => FullPage(
      ignoreMargins: true,
      child: SvgImage(svg: _bgShape!),
    ),
  );


  print('itemData.length--->${itemData.length}');
  print('pageCount--->${pageCount}');
  /// CREATING PDF PAGES
  int start =0;
  int end=0;
  for (int page = 0; page < pageCount; page++) {
    int startIndex = page * itemsPerPage;
    int endIndex = (page + 1) * itemsPerPage;

    if (endIndex > itemData.length ) {
      endIndex = itemData.length;
    }

    print('end-->$end');
    List<List<String>> currentPageData = itemData.sublist(
      startIndex,
      endIndex,
    );

    pdf.addPage(
      Page(
        pageTheme:theme ,
        build: (context) {
          return
          Column(
            children: [
            Container(
              height: 680,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: PdfColors.black), // Black border
              ),
              child:
              Column(
                children: [
                  /// MATT LOGO AND INVOICE HEADING
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black, // Choose your border color
                        width: 1, // Choose the border width
                      ),
                    ),
                    /// MATT LOGO AND INVOICE HEADING
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        /// LOGO AND COMPANY ADDRESS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child:
                                Image(
                                  imageLogo,
                                  width: 70,
                                  height: 70
                                ),
                              ),
                              SizedBox(width: MOSizes.spaceBtwItems/2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('West ABCD Street, \nS111 Chicago Illinois 60014',
                                    style : const TextStyle(
                                        color: PdfColors.grey900,
                                        fontSize: 12
                                    ),
                                  ),
                                  Text('United States',
                                    style : const TextStyle(
                                        color: PdfColors.grey900,
                                        fontSize: 12
                                    ),
                                  ),
                                  Text('+1 - 987-654-3210',
                                    style : const TextStyle(
                                        color: PdfColors.grey900,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            ]
                        ),
                        /// JUST INVOICE HEADING
                        Row(
                            children:[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child:Text('INVOICE',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15)),
                              )
                            ]
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 80, // Set a fixed height for the container

                      child:  Row(
                          mainAxisSize: MainAxisSize.max,
                          children:[
                            Row(
                                children: [
                                  /// INVOICE DETAILS , NO, DATE,etc.,
                                  TableHelper.fromTextArray(
                                    cellAlignments: {0: Alignment.centerLeft, 1: Alignment.centerLeft},
                                    data: leftInvoiceData,
                                    cellPadding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                    border: const TableBorder(
                                      right: BorderSide(width: 1, color: PdfColors.black), // Border for leftmost column
                                    ),
                                    columnWidths: invoiceColumnWidths,

                                  ),
                                ]
                            ),
                            Row(
                                children: [
                                  /// TERMS, SHIP DATE, FOB,REP
                                  TableHelper.fromTextArray(
                                    cellAlignments: {0: Alignment.topLeft, 1: Alignment.topLeft},
                                    data: rightInvoiceData,
                                    cellPadding: const EdgeInsets.symmetric(horizontal: 4,vertical: 1),
                                    border: const TableBorder(
                                    ),
                                    columnWidths: invoiceColumnWidths,
                                  ),
                                ]
                            )
                          ]
                      )
                  )
                  ,


                  ///BILL TO AND SHIP TO
                  TableHelper.fromTextArray(
                    headerStyle: TextStyle(fontWeight: FontWeight.bold), // Make text bold for header cells
                    cellAlignment: Alignment.topLeft,
                    headerAlignment: Alignment.topLeft,
                    headerDecoration: const BoxDecoration(
                      color: PdfColors.grey200,
                    ),
                    headers:sbToHeader ,
                    data: billTodata,
                  ),

                  /// ITEM DETAILS
                  Table(
                    border: TableBorder.all(),
                    columnWidths: columnWidths,
                    children: [
                      TableRow(
                        children: detailsHeaders.map((header) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              header,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
                            ),
                          );
                        }).toList(),
                      ),
                      ...currentPageData.map((rowData) {
                        return TableRow(
                          children: rowData.map((cell) {
                            return Container(

                              padding: const EdgeInsets.only(left:3),
                              child: Text(cell,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ],
                  ),

                  /// TAX AND TOTAL
                  if(pageCount-1==page)
                    TableHelper.fromTextArray(
                      cellAlignment: Alignment.topRight,
                      headerAlignment: Alignment.topRight,
                      cellStyle: TextStyle(fontWeight: FontWeight.bold), // Make text bold for all cells
                      data: [
                        ['Tax', '\$${tax.toStringAsFixed(2)}'],
                        ['Total', '\$${totalWithTax.toStringAsFixed(2)}'],
                      ],columnWidths: {0: FixedColumnWidth(maxWidth), 1: const FlexColumnWidth()},
                    ),


                  // Add footer to each page
                  SizedBox(height: 10),

                ],
              ),
            ),

            /// PAGINATION
            SizedBox(width: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
            children:[
            Text('Page ${context.pageNumber} of ${context.pagesCount}',style: const TextStyle(fontSize: 10,color: PdfColors.grey700)),
              ]),
            ]
          );
        },
      ),
    );
  }
  return pdf.save();
}
