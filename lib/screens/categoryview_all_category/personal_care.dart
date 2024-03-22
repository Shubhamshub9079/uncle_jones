import 'package:flutter/cupertino.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperThree {
  static Widget buildThreeCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isThereInitial == true &&
        homeData.homeThreeCategoryList.length == 0) {
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
    } else if (homeData.homeThreeCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            padding: const EdgeInsets.all(6.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: homeData.homeThreeCategoryList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MiniProductCard(
                id: homeData.homeThreeCategoryList[index].id,
                image: homeData.homeThreeCategoryList[index].thumbnailImage,
                name: homeData.homeThreeCategoryList[index].name,
                main_price: homeData.homeThreeCategoryList[index].mainPrice,
                stroked_price:
                    homeData.homeThreeCategoryList[index].strokedPrice,
                has_discount: homeData.homeThreeCategoryList[index].hasDiscount,
                is_wholesale: homeData.homeThreeCategoryList[index].isWholesale,
                discount: homeData.homeThreeCategoryList[index].discount,
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
