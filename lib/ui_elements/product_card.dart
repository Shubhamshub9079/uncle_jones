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
  Widget build(
    BuildContext context,
  ) {
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
            padding: const EdgeInsets.fromLTRB(10, 15, 5, 0),
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
                            placeholder: 'assets/Uncleplaceholder.png',
                            image: widget.image!,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.45,
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
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  // onPressAddToCart(context, _addedToCartSnackbar);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'assets/addcart.png',
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
