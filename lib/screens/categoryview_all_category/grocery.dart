import 'package:flutter/material.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelpertwo {
  static Widget buildTwoCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isTwoInitial == true &&
        homeData.homeTwoCategoryList.length == 0) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
                height: 120.0,
                width: (MediaQuery.of(context).size.width - 64) / 3),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
                height: 120.0,
                width: (MediaQuery.of(context).size.width - 64) / 3),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
                height: 120.0,
                width: (MediaQuery.of(context).size.width - 160) / 3),
          ),
        ],
      );
    } else if (homeData.homeTwoCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            padding: const EdgeInsets.all(6.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 14.0,
              mainAxisSpacing: 14.0,
            ),
            itemCount: homeData.homeTwoCategoryList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MiniProductCard(
                id: homeData.homeTwoCategoryList[index].id,
                image: homeData.homeTwoCategoryList[index].thumbnailImage,
                name: homeData.homeTwoCategoryList[index].name,
                main_price: homeData.homeTwoCategoryList[index].mainPrice,
                stroked_price: homeData.homeTwoCategoryList[index].strokedPrice,
                has_discount: homeData.homeTwoCategoryList[index].hasDiscount,
                is_wholesale: homeData.homeTwoCategoryList[index].isWholesale,
                discount: homeData.homeTwoCategoryList[index].discount,
              );
            },
          ),
        ),
      );
    } else {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            'No related products',
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }
}
