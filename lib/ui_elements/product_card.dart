import 'package:UncleJons/helpers/system_config.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/screens/product_details.dart';
import 'package:flutter/material.dart';
import '../screens/auction_products_details.dart';

class ProductCard extends StatefulWidget {
  var identifier;
  int? id;
  String? image;
  String? name;
  String? main_price;
  String? stroked_price;
  bool? has_discount;
  bool? is_wholesale;
  var discount;

  ProductCard({
    Key? key,
    this.identifier,
    this.id,
    this.image,
    this.name,
    this.main_price,
    this.is_wholesale = false,
    this.stroked_price,
    this.has_discount,
    this.discount,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print((MediaQuery.of(context).size.width - 48) / 1);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return widget.identifier == 'auction'
                ? AuctionProductsDetails(id: widget.id)
                : ProductDetails(
                    id: widget.id,
                  );
          }),
        );
      },
      child: Stack(
        children: <Widget>[
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 5, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                  child:
                      //   Container(
                      //     width: 120,
                      //     height: 25,
                      //
                      //     decoration: BoxDecoration(
                      //       color: Color(0xffFFCDD2),
                      //       borderRadius: BorderRadius.circular(17),
                      //     ),
                      //
                      //     child: Center(
                      //       child: Text(
                      //         "UJ Exclusive",
                      //         style: TextStyle(
                      //             color: Colors.pink,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ), //BoxDecoration
                      //   ),
                      // ), //
                      // SizedBox(
                      //   height: 5,
                      // ),

                      Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(6), bottom: Radius.zero),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: widget.image!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: MyTheme.black,
                                    letterSpacing: 0.8,
                                    fontSize: 13,
                                    height: 1.8,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'UJ Price :',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    SystemConfig.systemCurrency!.code != null
                                        ? widget.main_price!.replaceAll(
                                            SystemConfig.systemCurrency!.code!,
                                            SystemConfig
                                                .systemCurrency!.symbol!)
                                        : widget.main_price!,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: MyTheme.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  widget.has_discount!
                                      ? StreamBuilder<Object>(
                                          stream: null,
                                          builder: (context, snapshot) {
                                            return Text(
                                              SystemConfig.systemCurrency!
                                                          .code !=
                                                      null
                                                  ? widget.stroked_price!
                                                      .replaceAll(
                                                          SystemConfig
                                                              .systemCurrency!
                                                              .code!,
                                                          SystemConfig
                                                              .systemCurrency!
                                                              .symbol!)
                                                  : widget.stroked_price!,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: MyTheme.medium_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            );
                                          })
                                      : Container(
                                          height: 5.0,
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     // Text(
                              //     //   'Save this order : ',
                              //     //   style: TextStyle(
                              //     //       color: Colors.green,
                              //     //       fontSize: 14,
                              //     //       fontWeight: FontWeight.bold),
                              //     // ),
                              //     // Align(
                              //     //   alignment: Alignment.center,
                              //     //   child: Column(
                              //     //     crossAxisAlignment:
                              //     //         CrossAxisAlignment.start,
                              //     //     mainAxisAlignment: MainAxisAlignment.start,
                              //     //
                              //     //     children: [
                              //     //       if (widget.has_discount!)
                              //     //         Container(
                              //     //           padding: EdgeInsets.symmetric(
                              //     //               horizontal: 6, vertical: 5),
                              //     //           margin: EdgeInsets.only(bottom: 5),
                              //     //           decoration: BoxDecoration(
                              //     //             border: Border.all(
                              //     //               color: Colors.green,
                              //     //               width: 2,
                              //     //             ),
                              //     //
                              //     //                 //color: Colors.red,
                              //     //                 borderRadius: BorderRadius.circular(17),
                              //     //             boxShadow: [
                              //     //               BoxShadow(
                              //     //                 color: const Color(0x14000000),
                              //     //                 offset: Offset(-1, 1),
                              //     //                 blurRadius: 1,
                              //     //               ),
                              //     //             ],
                              //     //           ),
                              //     //           child: Text(
                              //     //             widget.discount ?? "",
                              //     //             style: TextStyle(
                              //     //               fontSize: 12,
                              //     //               color: Colors.black,
                              //     //               fontWeight: FontWeight.w700,
                              //     //               height: 1.8,
                              //     //             ),
                              //     //             textHeightBehavior:
                              //     //                 TextHeightBehavior(
                              //     //                     applyHeightToFirstAscent:
                              //     //                         false),
                              //     //             softWrap: false,
                              //     //           ),
                              //     //         ),
                              //     //       Visibility(
                              //     //         visible: whole_sale_addon_installed.$,
                              //     //         child: widget.is_wholesale != null &&
                              //     //                 widget.is_wholesale!
                              //     //             ? Container(
                              //     //                 padding: EdgeInsets.symmetric(
                              //     //                     horizontal: 4, vertical: 4),
                              //     //                 decoration: BoxDecoration(
                              //     //                   color: Colors.blueGrey,
                              //     //                   borderRadius:
                              //     //                       BorderRadius.only(
                              //     //                     topRight:
                              //     //                         Radius.circular(6.0),
                              //     //                     bottomLeft:
                              //     //                         Radius.circular(6.0),
                              //     //                   ),
                              //     //                   boxShadow: [
                              //     //                     BoxShadow(
                              //     //                       color: const Color(
                              //     //                           0x14000000),
                              //     //                       offset: Offset(-1, 1),
                              //     //                       blurRadius: 1,
                              //     //                     ),
                              //     //                   ],
                              //     //                 ),
                              //     //                 child: Text(
                              //     //                   "Wholesale",
                              //     //                   style: TextStyle(
                              //     //                     fontSize: 10,
                              //     //                     color:
                              //     //                         const Color(0xffffffff),
                              //     //                     fontWeight: FontWeight.w700,
                              //     //                     height: 1.8,
                              //     //                   ),
                              //     //                   textHeightBehavior:
                              //     //                       TextHeightBehavior(
                              //     //                           applyHeightToFirstAscent:
                              //     //                               false),
                              //     //                   softWrap: false,
                              //     //                 ),
                              //     //               )
                              //     //             : SizedBox.shrink(),
                              //     //       ),
                              //     //     ],
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 125,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),

                                child: Center(
                                  child: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ), //BoxDecoration
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // discount and wholesale
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
