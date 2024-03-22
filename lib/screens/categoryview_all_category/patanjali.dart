import 'package:flutter/material.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperSeven {
  static Widget buildSevenCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isSevenInitial == true &&
        homeData.homeSevenCategoryList.length == 0) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width - 64) / 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
              height: 120.0,
              width: (MediaQuery.of(context).size.width - 64) / 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
              height: 120.0,
              width: (MediaQuery.of(context).size.width - 160) / 3,
            ),
          ),
        ],
      );
    } else if (homeData.homeSevenCategoryList.length > 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(2.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: homeData.homeSevenCategoryList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return MiniProductCard(
            id: homeData.homeSevenCategoryList[index].id,
            image: homeData.homeSevenCategoryList[index].thumbnailImage,
            name: homeData.homeSevenCategoryList[index].name,
            main_price: homeData.homeSevenCategoryList[index].mainPrice,
            stroked_price: homeData.homeSevenCategoryList[index].strokedPrice,
            has_discount: homeData.homeSevenCategoryList[index].hasDiscount,
            is_wholesale: homeData.homeSevenCategoryList[index].isWholesale,
            discount: homeData.homeSevenCategoryList[index].discount,
          );
        },
      );
    } else {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            'No Related Products',
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }
}
