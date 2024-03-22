import 'package:flutter/material.dart';
import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperSix {
  static Widget buildSixCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isSixInitial == true &&
        homeData.homeSixCategoryList.length == 0) {
      return Row(
        children: [
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
              width: (MediaQuery.of(context).size.width - 64) / 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShimmerHelper().buildBasicShimmer(
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width - 160) / 3,
            ),
          ),
        ],
      );
    } else if (homeData.homeSixCategoryList.length > 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(6.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: homeData.homeSixCategoryList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return MiniProductCard(
            id: homeData.homeSixCategoryList[index].id,
            image: homeData.homeSixCategoryList[index].thumbnailImage,
            name: homeData.homeSixCategoryList[index].name,
            main_price: homeData.homeSixCategoryList[index].mainPrice,
            stroked_price: homeData.homeSixCategoryList[index].strokedPrice,
            has_discount: homeData.homeSixCategoryList[index].hasDiscount,
            is_wholesale: homeData.homeSixCategoryList[index].isWholesale,
            discount: homeData.homeSixCategoryList[index].discount,
          );
        },
      );
    } else {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            'No related product',
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }
}
