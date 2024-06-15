import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/common/widgets/loaders/loaders.dart';
import 'package:orthotrade/navigation_menu.dart';

import 'package:printing/printing.dart';

import '../../common/widgets/dialog/dialog.dart';
import '../../utils/constants/text_strings.dart';
import '../orders/controllers/orders/order_review_controller.dart';
import '../orders/models/order_items_model.dart';
import 'invoice_pdf_generator.dart';

class PdfPreviewPage extends StatelessWidget {
   PdfPreviewPage({Key? key}) : super(key: key);

  final controller = OrderReviewController.instance;

   // Function to handle saving PDF to Firestore
  Widget build(BuildContext context) {
    final orderedItems = controller.orderItems;
    controller.updateInvoiceTotal();

    return Scaffold(
      appBar: const MOAppBar(
        title: Text('Invoice Preview'),
        showBackArrow: true,
      ),
      body: InteractiveViewer(
        panEnabled: false,
        boundaryMargin: const EdgeInsets.all(80),
        minScale: 0.5,
        maxScale: 4,
        child: PdfPreview(
          useActions: false,
          previewPageMargin: const EdgeInsets.all(10),

          pdfPreviewPageDecoration: const BoxDecoration(

            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.white)],
          ),

          loadingWidget: const CupertinoActivityIndicator(),
          build: (context) => pdfBuilder(orderedItems.value),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0, // Remove shadow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (() => controller.uploadOrderItems()),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.tick_circle),
                          SizedBox(width: 8.0),
                          Text('Order'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )


    );
  }
}
