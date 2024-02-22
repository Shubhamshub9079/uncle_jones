import 'package:UncleJons/custom/box_decorations.dart';
import 'package:UncleJons/helpers/system_config.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/screens/main.dart';
import 'package:UncleJons/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/shared_value_helper.dart';

class MiniProductCard extends StatefulWidget {
  int? id;
  String? image;
  String? name;
  String? main_price;
  String? stroked_price;
  bool? has_discount;
  bool? is_wholesale;
  var discount;

  MiniProductCard({
    Key? key,
    this.id,
    this.image,
    this.name,
    this.main_price,
    this.stroked_price,
    this.has_discount,
    this.is_wholesale = false,
    this.discount,
  }) : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProductDetails(
              id: widget.id,
            );
          }),
        );
      },
      child: Container(
        width: 175,
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 90,
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/Uncleplaceholder.png',
                        image: widget.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 6),
                        child: Text(
                          widget.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0XFF464646),
                              fontSize: 12,
                              height: 1.2,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          children: [
                            Text(
                              'UJ Price : ',
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 13),
                            ),
                            widget.has_discount!
                                ? Text(
                                    SystemConfig.systemCurrency != null
                                        ? widget.stroked_price!.replaceAll(
                                            SystemConfig.systemCurrency!.code!,
                                            SystemConfig
                                                .systemCurrency!.symbol!)
                                        : widget.stroked_price!,
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: MyTheme.medium_grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Container(),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              SystemConfig.systemCurrency != null
                                  ? widget.main_price!.replaceAll(
                                      SystemConfig.systemCurrency!.code!,
                                      SystemConfig.systemCurrency!.symbol!)
                                  : widget.main_price!,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: MyTheme.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // discount and wholesale
            Positioned.fill(
              top: 10,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.has_discount!)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xff237726),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
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
                            fontSize: 10,
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
                      child: widget.is_wholesale!
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
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
                                "Wholesale",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 1.8,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                softWrap: false,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ), // whole sale
          ],
        ),
      ),
    );
  }
}
