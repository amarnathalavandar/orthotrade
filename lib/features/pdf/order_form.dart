import 'package:flutter/material.dart';
import 'package:orthotrade/features/orders/controllers/orders/order_review_controller.dart';
import 'package:orthotrade/utils/constants/sizes.dart';

class PdfDesign extends StatelessWidget {

  // final controller = OrderReviewController.instance;
   const PdfDesign({super.key});

  @override
  Widget build(BuildContext context) {

    // final orderedItems = controller.orderItems;
    // controller.updateInvoiceTotal();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(MOSizes.defaultSpace),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          /// MATT LOGO, ADDRESS AND INVOICE HEADING
                          Column(
                            children: [
                              /// MATT LOGO AND COMPLETE ADDRESS
                              Row(
                                  children: [
                                    Image.asset('assets/logos/orthotrade-logo-black.png',
                                      width: 80, height: 80,
                                    ),
                                    //const SizedBox(width: 10),
                                    const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('MATT ORTHODONTICS',
                                            style : TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10
                                            ),
                                          ),
                                          Text('West Ontario Street, \nS230 Chicago Illinois 60654',
                                            style : TextStyle(
                                                color: Colors.black87,
                                                fontSize: 8
                                            ),
                                          ),
                                          Text('United States',
                                            style : TextStyle(
                                                color: Colors.black87,
                                                fontSize: 8
                                            ),
                                          ),
                                          Text('+1 - 987-654-3210',
                                            style : TextStyle(
                                                color: Colors.black87,
                                                fontSize: 8
                                            ),
                                          )
                                        ])
                                  ]),
                              ///INVOICE HEADING
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('INVOICE ',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Divider(height: 1),
                          /// COMPLETE INVOICE DETAILS , SHIP TO AND BILL TO HEADING , SHIP TO AND BILL TO ADDRESS
                          Row(
                           children: [
                             /// NO,DATE,TERMS,FOB,PROJECT , SHIP TO AND SHIP TO ADDRESS
                             Column(
                               children: [
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Invoice No',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': INV-000531',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// INVOICE DATE
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Invoice Date',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': INV-000531',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// TERMS
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Terms', style :Theme.of(context).textTheme.bodySmall),
                                       ),

                                       SizedBox(width: 80,
                                         child: Text(': Time Of Delivery',style:Theme.of(context).textTheme.bodySmall),
                                       ),
                                     ]),
                                 /// FOB
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('FOB',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': N/A',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// PROJECT
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Project',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,
                                         child: Text(': Kamion',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),

                               ],
                             ),
                            // SizedBox(width: 20,),

                             /// VERTICAL DIVIDER
                             Column(
                               children: [
                                 Container(
                                   height: 70, // Height of the vertical line
                                   width: 1, // Width of the vertical line
                                   color: Colors.grey, // Color of the vertical line
                                 ),

                               ],
                             ),
                             /// VIA,PURCHASE,ORDER,REP,SHIP DATE , BILL TO AND BILL TO ADDRESS
                            //SizedBox(width: 10,),
                             Column(
                               children: [
                                 /// VIA
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Via',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': Air',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// PURCHASE ORDER
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Purchase Order',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': PO-232322',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// REP
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Rep', style :Theme.of(context).textTheme.bodySmall),
                                       ),

                                       SizedBox(width: 80,
                                         child: Text(': Scott Kramer',style:Theme.of(context).textTheme.bodySmall),
                                       ),
                                     ]),
                                 /// SHIP DATE
                                 Row(
                                     children: [
                                       SizedBox(width: 60,
                                         child: Text('Ship Date',
                                           style:Theme.of(context).textTheme.bodySmall,
                                         ),
                                       ),
                                       SizedBox(width: 80,

                                         child: Text(': 12/03/2024',
                                           style:Theme.of(context).textTheme.bodySmall,),
                                       ),
                                     ]),
                                 /// BILL TO GREY HEADING
                                 Row(
                                   children: [
                                     Container(
                                       width: 160,
                                       height: 14,
                                       decoration: BoxDecoration(

                                           color: Colors.grey.shade500

                                       ),
                                       child: const Text('Bill To'),
                                     ),
                                   ],
                                 ),
                                 const Divider(height: 1),
                               ],
                             ),
                           ],
                         ),
                          /// SHIP TO AND BILL TO HEADING
                          Row(
                            children: [
                              /// BILL TO GREY HEADING
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 14,
                                        decoration: BoxDecoration(

                                            color: Colors.grey.shade500

                                        ),
                                        child: const Text('Bill To'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [   Container(
                                      width: 150,
                                      height: 14,
                                      decoration: BoxDecoration(

                                          color: Colors.grey.shade500

                                      ),
                                      child: const Text('Ship To'),
                                    )

                                    ],
                                  )

                                ],
                              )
                            ],
                          ),


                          Row(
                            children: [
                              Expanded(child: FittedBox(
                                child: DataTable(
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color:Colors.grey,
                                    ),
                                    columnSpacing: 10,
                                    dataRowMaxHeight: 150,
                                    dataRowMinHeight: 30,
                                    headingTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                    dataTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
                                    columns: const [
                                      DataColumn(label: Expanded(child: Text('S.no'))),
                                      DataColumn(label: Expanded(child: Text('Item & Description'))),
                                      DataColumn(label: Expanded(child: Text('Item Code'))),
                                      DataColumn(label: Expanded(child: Text('Qty'))),
                                      DataColumn(label: Expanded(child: Text('Rate'))),
                                      DataColumn(label: Expanded(child: Text('Discount'))),
                                      DataColumn(label: Expanded(child: Text('Amount'))),
                                    ], rows:  [
                                  for(int i=0;i<4;i++)
                                    DataRow(
                                        cells: [
                                          DataCell(Center(child: Text('${i+1}'))),
                                          DataCell(
                                              Center(
                                                child: Text('Wires',
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                          ),
                                          const DataCell(Center(child: Text('0001'))),
                                          DataCell(Center(child: Text('1'))),
                                          DataCell(Center(child: Text('300'))),
                                          DataCell(Center(child: Text('200'))),
                                          DataCell(Center(child: Text('100'))),
                                        ]),
                                ]),
                              ))
                            ],
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Total   ${'300'}')
                              ],
                            ),
                          )
                        ]),
                  )));
        },),
        floatingActionButton:
        FloatingActionButton.extended(
            onPressed: (() {
              // controller.uploadOrderItems()
            } ),
         label: const Text('Submit')),
      ),
    );
  }
}
