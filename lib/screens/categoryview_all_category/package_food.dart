import 'package:flutter/cupertino.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperFive {
  static Widget buildFiveCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isFiveInitial == true &&
        homeData.homeFiveCategoryList.length == 0) {
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
    } else if (homeData.homeFiveCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            padding: const EdgeInsets.all(1.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: homeData.homeFiveCategoryList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MiniProductCard(
                id: homeData.homeFiveCategoryList[index].id,
                image: homeData.homeFiveCategoryList[index].thumbnailImage,
                name: homeData.homeFiveCategoryList[index].name,
                main_price: homeData.homeFiveCategoryList[index].mainPrice,
                stroked_price:
                    homeData.homeFiveCategoryList[index].strokedPrice,
                has_discount: homeData.homeFiveCategoryList[index].hasDiscount,
                is_wholesale: homeData.homeFiveCategoryList[index].isWholesale,
                discount: homeData.homeFiveCategoryList[index].discount,
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
            'No related product',
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }
}
