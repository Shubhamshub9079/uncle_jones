
import 'package:flutter/material.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperEight {
  static Widget buildEightCategoryData(BuildContext context, HomePresenter homeData) {
    if (homeData.isEightInitial == true && homeData.homeEightCategoryList.length == 0) {
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
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width - 160) / 3),
          ),
        ],
      );
    } else if (homeData.homeEightCategoryList.length > 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(5.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: homeData.homeEightCategoryList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return MiniProductCard(
            id: homeData.homeEightCategoryList[index].id,
            image: homeData.homeEightCategoryList[index].thumbnailImage,
            name: homeData.homeEightCategoryList[index].name,
            main_price: homeData.homeEightCategoryList[index].mainPrice,
            stroked_price: homeData.homeEightCategoryList[index].strokedPrice,
            has_discount: homeData.homeEightCategoryList[index].hasDiscount,
            is_wholesale: homeData.homeEightCategoryList[index].isWholesale,
            discount: homeData.homeEightCategoryList[index].discount,
          );
        },
      );
    } else {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            'No Related Product',
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }
}
