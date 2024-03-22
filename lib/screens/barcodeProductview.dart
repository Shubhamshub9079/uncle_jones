import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/screens/product_details.dart';
import 'package:barcode_scan2/platform_wrapper.dart';

import 'package:flutter/material.dart';

class ProductViewBarCode extends StatefulWidget {
  final String scannedBarcode;
int? id;
   ProductViewBarCode({Key? key, required this.scannedBarcode})
      : super(key: key);

  @override
  _ProductViewBarCodeState createState() => _ProductViewBarCodeState();
}

class _ProductViewBarCodeState extends State<ProductViewBarCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.accent_color,
        title: Text('Product View'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Scanned Barcode: ${widget.scannedBarcode}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     try {
          //       var result = await BarcodeScanner.scan();
          //       if (result.rawContent != null && result.rawContent.isNotEmpty) {
          //         int scannedId = int.tryParse(result.rawContent) ?? 0; // Convert to int
          //         print('Scanned ID: $scannedId');
          //
          //         // Navigate to the ProductDetails screen with the scanned ID
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) {
          //             return ProductDetails(
          //               id: scannedId, // Convert int to String if necessary
          //             );
          //           }),
          //         );
          //       } else {
          //         print('User canceled the scan or no barcode found');
          //       }
          //     } catch (e) {
          //       // Handle any exceptions
          //       print('Error: $e');
          //     }
          //   },
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all<Color>(MyTheme.accent_color),
          //     minimumSize: MaterialStateProperty.all<Size>(Size(150, 50),),
          //   ),
          //   child: Text(
          //     'View Product',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // )



        ],
      ),
    );
  }
}
