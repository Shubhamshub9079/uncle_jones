import 'package:UncleJons/helpers/system_config.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/screens/product_details.dart';
import 'package:flutter/material.dart';
import '../helpers/shared_value_helper.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.16,
                        width: MediaQuery.of(context).size.width * 0.33,
                        padding: EdgeInsets.all(10),
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(6), bottom: Radius.zero),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: widget.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
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
                                  fontSize: 14,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          SystemConfig.systemCurrency!.symbol!)
                                      : widget.main_price!,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: MyTheme.black,
                                      fontSize: 14,
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
                                            SystemConfig.systemCurrency!.code !=
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
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: MyTheme.medium_grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          );
                                        })
                                    : Container(
                                        height: 5.0,
                                      ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Discount : ',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (widget.has_discount!)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 5),
                                          margin: EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffe62e04),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x14000000),
                                                offset: Offset(-1, 1),
                                                blurRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            widget.discount ?? "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                              height: 1.8,
                                            ),
                                            textHeightBehavior: TextHeightBehavior(
                                                applyHeightToFirstAscent: false),
                                            softWrap: false,
                                          ),
                                        ),
                                      Visibility(
                                        visible: whole_sale_addon_installed.$,
                                        child: widget.is_wholesale != null &&
                                            widget.is_wholesale!
                                            ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(6.0),
                                              bottomLeft:
                                              Radius.circular(6.0),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                const Color(0x14000000),
                                                offset: Offset(-1, 1),
                                                blurRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            "Wholesale",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w700,
                                              height: 1.8,
                                            ),
                                            textHeightBehavior:
                                            TextHeightBehavior(
                                                applyHeightToFirstAscent:
                                                false),
                                            softWrap: false,
                                          ),
                                        )
                                            : SizedBox.shrink(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // discount and wholesale
              ],
            ),
          ),
        ],
      ),
    );
  }
}
