import 'package:flutter/material.dart';

import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../presenter/home_presenter.dart';
import '../../ui_elements/mini_product_card.dart';

class CategoryViewHelperOne {
  static Widget buildOneCategoryData(
      BuildContext context, HomePresenter homeData) {
    if (homeData.isOneInitial == true &&
        homeData.homeOneCategoryList.length == 0) {
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
    } else if (homeData.homeOneCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchDairyBeverages();
              }
              return true;
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(5.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 12, // Spacing between columns
                mainAxisSpacing: 12, // Spacing between rows
              ),
              itemCount: homeData.homeOneCategoryList.length,
              // Change scrollDirection to Axis.vertical for vertical scrolling
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeOneCategoryList[index].id,
                  image: homeData.homeOneCategoryList[index].thumbnailImage,
                  name: homeData.homeOneCategoryList[index].name,
                  main_price: homeData.homeOneCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeOneCategoryList[index].strokedPrice,
                  has_discount: homeData.homeOneCategoryList[index].hasDiscount,
                  is_wholesale: homeData.homeOneCategoryList[index].isWholesale,
                  discount: homeData.homeOneCategoryList[index].discount,
                );
              },
            ),
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
