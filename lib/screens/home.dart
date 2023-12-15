import 'dart:convert';
import 'package:UncleJons/custom/aiz_image.dart';
import 'package:UncleJons/custom/box_decorations.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/helpers/shimmer_helper.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/presenter/home_presenter.dart';
import 'package:UncleJons/screens/category_products.dart';
import 'package:UncleJons/screens/filter.dart';
import 'package:UncleJons/screens/top_selling_products.dart';
import 'package:UncleJons/ui_elements/mini_product_card.dart';
import 'package:UncleJons/ui_elements/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../custom/device_info.dart';
import 'itemlist_uploadimage.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
    this.title,
    this.show_back_button = false,
    go_back = true,
  }) : super(key: key);
  final String? title;
  bool show_back_button;
  late bool go_back;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  HomePresenter homeData = HomePresenter();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
          //color set to transperent or set your own color
          ),
    );

    Future.delayed(Duration.zero).then((value) {
      change();
    });
    // change();
    // TODO: implement initState
    super.initState();
  }

  change() {
    homeData.onRefresh();
    homeData.mainScrollListener();
    homeData.initPiratedAnimation(this);
  }

  @override
  void dispose() {
    homeData.pirated_logo_controller.dispose();
    //  ChangeNotifierProvider<HomePresenter>.value(value: value)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: homeData.scaffoldKey,
      appBar: PreferredSize(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Filter();
              }),
            );
          },
          child: buildAppBar(context),
        ),
        preferredSize: Size(
          DeviceInfo(context).width!,
          70,
        ),
      ),
      //drawer: MainDrawer(),
      body: ListenableBuilder(
          listenable: homeData,
          builder: (context, child) {
            return Stack(
              children: [
                RefreshIndicator(
                  color: MyTheme.accent_color,
                  backgroundColor: Colors.white,
                  onRefresh: homeData.onRefresh,
                  displacement: 0,
                  child: CustomScrollView(
                    controller: homeData.mainScrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 5,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            buildHomeCarouselSlider(context, homeData),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(
                            //     18.0,
                            //     0.0,
                            //     18.0,
                            //     0.0,
                            //   ),
                            //   child: buildHomeMenuRow1(context, homeData),
                            // ),
                            //
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(
                            //     18.0,
                            //     0.0,
                            //     18.0,
                            //     0.0,
                            //   ),
                            //   child: buildHomeMenuRow2(context),
                            // ),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                18.0,
                                0.0,
                                22.0,
                                0.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ItemImageUpload()),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: MyTheme.light_grey,
                                      border: Border.all(
                                          width: 2,
                                          color: MyTheme.accent_color)),
                                  child: Center(
                                    child: Text(
                                      'Manual Order',
                                      style: TextStyle(
                                          color: MyTheme.accent_color,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                18.0,
                                20.0,
                                22.0,
                                0.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: 'Shop By',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: ' Categories',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 110,
                                      ),
                                      Text(
                                        "View all ",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.pink,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 160,
                          child: buildHomeFeaturedCategories(context, homeData),
                        ),
                      ),
                      //Top selling product//
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Top',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: ' Selling Products',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            buildHomeFeatureProductHorizontalList(homeData)
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [],
                        ),
                      ),
                      //Daily Beverages//
                      SliverList(
                        // Categories wise products
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Dairy &',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: ' Beverages',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 130,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildOneCategoryData(homeData)
                          ],
                        ),
                      ),
                      // Bakery//
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Grocery',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildTwoCategoryData(homeData)
                          ],
                        ),
                      ),
                      // Home Kitchen//
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, right: 18.0, left: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Personal &',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: ' Care',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                ),
                                Text(
                                  'View all',
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.pink,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                          buildThreeCategoryData(homeData)
                        ]),
                      ),
                      //Shop By Brand//
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            color: Color(0XFFfff5e6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 18.0, left: 18.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: 'Shop By',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: ' Brands',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                buildBrandData(homeData)
                              ],
                            ),
                          ),
                        ]),
                      ),

                      SliverToBoxAdapter(
                        child: buildHomeBannerOne(context, homeData),
                      ),

                      ////
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Bakery',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 190,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildFourCategoryData(homeData)
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Package',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: ' Food',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildFiveCategoryData(homeData)
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Stationary',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildSixCategoryData(homeData)
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Patanjali',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildSevenCategoryData(homeData)
                          ],
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, right: 18.0, left: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: 'Home &',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: ' Kitchen',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 135,
                                  ),
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            buildEightCategoryData(homeData)
                          ],
                        ),
                      ),

                      //-----------------------------------------------------------------------------
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            buildHomeBannerTwo(context, homeData),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget buildHomeAllProducts(context, HomePresenter homeData) {
    if (homeData.isAllProductInitial && homeData.allProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: homeData.allProductScrollController));
    } else if (homeData.allProductList.length > 0) {
      //snapshot.hasData

      return GridView.builder(
        // 2
        //addAutomaticKeepAlives: true,
        itemCount: homeData.allProductList.length,
        controller: homeData.allProductScrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.618),
        padding: EdgeInsets.all(16.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // 3
          return ProductCard(
            id: homeData.allProductList[index].id,
            image: homeData.allProductList[index].thumbnail_image,
            name: homeData.allProductList[index].name,
            main_price: homeData.allProductList[index].main_price,
            stroked_price: homeData.allProductList[index].stroked_price,
            has_discount: homeData.allProductList[index].has_discount,
            discount: homeData.allProductList[index].discount,
            // choiceOptions: homeData.allProductList[index].choiceOptions,
          );
        },
      );
    } else if (homeData.totalAllProductData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context)!.no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }

  Widget buildHomeAllProducts2(context, HomePresenter homeData) {
    if (homeData.isAllProductInitial && homeData.allProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: homeData.allProductScrollController));
    } else if (homeData.allProductList.length > 0) {
      return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          itemCount: homeData.allProductList.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 20.0, bottom: 10, left: 18, right: 18),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ProductCard(
              id: homeData.allProductList[index].id,
              image: homeData.allProductList[index].thumbnail_image,
              name: homeData.allProductList[index].name,
              main_price: homeData.allProductList[index].main_price,
              stroked_price: homeData.allProductList[index].stroked_price,
              has_discount: homeData.allProductList[index].has_discount,
              discount: homeData.allProductList[index].discount,
              is_wholesale: homeData.allProductList[index].isWholesale,
              //choiceOptions: homeData.allProductList[index].choiceOptions,
            );

          });
    } else if (homeData.totalAllProductData == 0) {
      return Center(
          child: Text(AppLocalizations.of(context)!.no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }

  Widget buildHomeFeaturedCategories(context, HomePresenter homeData) {
    if (homeData.isCategoryInitial &&
        homeData.featuredCategoryList.length == 0) {
      return ShimmerHelper().buildHorizontalGridShimmerWithAxisCount(
          crossAxisSpacing: 14.0,
          mainAxisSpacing: 14.0,
          item_count: 10,
          mainAxisExtent: 170.0,
          controller: homeData.featuredCategoryScrollController);
    } else if (homeData.featuredCategoryList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 3),
          scrollDirection: Axis.horizontal,
          controller: homeData.featuredCategoryScrollController,
          itemCount: homeData.featuredCategoryList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CategoryProducts(
                      category_id: homeData.featuredCategoryList[index].id,
                      category_name: homeData.featuredCategoryList[index].name,
                    );
                  }),
                );
              },
              child: Container(
                width: 110,
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecorations.buildBoxDecoration_1(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(6), right: Radius.zero),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: homeData.featuredCategoryList[index].banner,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Text(
                        homeData.featuredCategoryList[index].name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        style:
                            TextStyle(fontSize: 12, color: MyTheme.font_grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else if (!homeData.isCategoryInitial &&
        homeData.featuredCategoryList.length == 0) {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildHomeFeatureProductHorizontalList(HomePresenter homeData) {
    if (homeData.isFeaturedProductInitial == true &&
        homeData.featuredProductList.length == 0) {
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
                  width: (MediaQuery.of(context).size.width - 160) / 3)),
        ],
      );
    } else if (homeData.featuredProductList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 200,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchFeaturedProducts();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.totalFeaturedProductData! >
                      homeData.featuredProductList.length
                  ? homeData.featuredProductList.length + 1
                  : homeData.featuredProductList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,

              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return (index == homeData.featuredProductList.length)
                    ? SpinKitFadingFour(
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    : MiniProductCard(
                        id: homeData.featuredProductList[index].id,
                        image:
                            homeData.featuredProductList[index].thumbnail_image,
                        name: homeData.featuredProductList[index].name,
                        main_price:
                            homeData.featuredProductList[index].main_price,
                        stroked_price:
                            homeData.featuredProductList[index].stroked_price,
                        has_discount:
                            homeData.featuredProductList[index].has_discount,
                        is_wholesale:
                            homeData.featuredProductList[index].isWholesale,
                        discount: homeData.featuredProductList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildBrandData(HomePresenter homeData) {
    print("homeData.homeBrandList.length - " +
        jsonEncode(homeData.homeBrandList));
    if (homeData.isBrandInitial == true && homeData.homeBrandList.length == 0) {
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
    } else if (homeData.homeBrandList.length > 0) {
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeData.homeBrandList.length > 6
              ? 6
              : homeData.homeBrandList.length,
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.4),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6), bottom: Radius.zero),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: homeData.homeBrandList[index].logo,
                  fit: BoxFit.cover,
                ),
              ),
            );
          });
    } else {
      return Container(
        height: 100,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildOneCategoryData(HomePresenter homeData) {
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
          height: 210,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchDairyBeverages();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeOneCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildTwoCategoryData(HomePresenter homeData) {
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
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchFeaturedProducts();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeTwoCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeTwoCategoryList[index].id,
                  image: homeData.homeTwoCategoryList[index].thumbnailImage,
                  name: homeData.homeTwoCategoryList[index].name,
                  main_price: homeData.homeTwoCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeTwoCategoryList[index].strokedPrice,
                  has_discount: homeData.homeTwoCategoryList[index].hasDiscount,
                  is_wholesale: homeData.homeTwoCategoryList[index].isWholesale,
                  discount: homeData.homeTwoCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildThreeCategoryData(HomePresenter homeData) {
    if (homeData.isThereInitial == true &&
        homeData.homeThreeCategoryList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 64) / 3)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 64) / 3)),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 160) / 3)),
        ],
      );
    } else if (homeData.homeThreeCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 200,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchFeaturedProducts();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeThreeCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeThreeCategoryList[index].id,
                  image: homeData.homeThreeCategoryList[index].thumbnailImage,
                  name: homeData.homeThreeCategoryList[index].name,
                  main_price: homeData.homeThreeCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeThreeCategoryList[index].strokedPrice,
                  has_discount:
                      homeData.homeThreeCategoryList[index].hasDiscount,
                  is_wholesale:
                      homeData.homeThreeCategoryList[index].isWholesale,
                  discount: homeData.homeThreeCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildFourCategoryData(HomePresenter homeData) {
    if (homeData.isFourInitial == true &&
        homeData.homeFourCategoryList.length == 0) {
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
    } else if (homeData.homeFourCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchCake();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeFourCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeFourCategoryList[index].id,
                  image: homeData.homeFourCategoryList[index].thumbnailImage,
                  name: homeData.homeFourCategoryList[index].name,
                  main_price: homeData.homeFourCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeFourCategoryList[index].strokedPrice,
                  has_discount:
                      homeData.homeFourCategoryList[index].hasDiscount,
                  is_wholesale:
                      homeData.homeFourCategoryList[index].isWholesale,
                  discount: homeData.homeFourCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  Widget buildFiveCategoryData(HomePresenter homeData) {
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
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchPackageFood();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeFiveCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeFiveCategoryList[index].id,
                  image: homeData.homeFiveCategoryList[index].thumbnailImage,
                  name: homeData.homeFiveCategoryList[index].name,
                  main_price: homeData.homeFiveCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeFiveCategoryList[index].strokedPrice,
                  has_discount:
                      homeData.homeFiveCategoryList[index].hasDiscount,
                  is_wholesale:
                      homeData.homeFiveCategoryList[index].isWholesale,
                  discount: homeData.homeFiveCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  Widget buildSixCategoryData(HomePresenter homeData) {
    if (homeData.isSixInitial == true &&
        homeData.homeSixCategoryList.length == 0) {
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
    } else if (homeData.homeSixCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchStationary();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeSixCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeSixCategoryList[index].id,
                  image: homeData.homeSixCategoryList[index].thumbnailImage,
                  name: homeData.homeSixCategoryList[index].name,
                  main_price: homeData.homeSixCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeSixCategoryList[index].strokedPrice,
                  has_discount: homeData.homeSixCategoryList[index].hasDiscount,
                  is_wholesale: homeData.homeSixCategoryList[index].isWholesale,
                  discount: homeData.homeSixCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  Widget buildSevenCategoryData(HomePresenter homeData) {
    if (homeData.isSevenInitial == true &&
        homeData.homeSevenCategoryList.length == 0) {
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
    } else if (homeData.homeSevenCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchPatanjali();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeSevenCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeSevenCategoryList[index].id,
                  image: homeData.homeSevenCategoryList[index].thumbnailImage,
                  name: homeData.homeSevenCategoryList[index].name,
                  main_price: homeData.homeSevenCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeSevenCategoryList[index].strokedPrice,
                  has_discount:
                      homeData.homeSevenCategoryList[index].hasDiscount,
                  is_wholesale:
                      homeData.homeSevenCategoryList[index].isWholesale,
                  discount: homeData.homeSevenCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  Widget buildEightCategoryData(HomePresenter homeData) {
    if (homeData.isEightInitial == true &&
        homeData.homeEightCategoryList.length == 0) {
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
    } else if (homeData.homeEightCategoryList.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 220,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                homeData.fetchHomeKitchen();
              }
              return true;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(18.0),
              separatorBuilder: (context, index) => SizedBox(
                width: 14,
              ),
              itemCount: homeData.homeEightCategoryList.length,
              scrollDirection: Axis.horizontal,
              //itemExtent: 135,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemBuilder: (context, index) {
                return MiniProductCard(
                  id: homeData.homeEightCategoryList[index].id,
                  image: homeData.homeEightCategoryList[index].thumbnailImage,
                  name: homeData.homeEightCategoryList[index].name,
                  main_price: homeData.homeEightCategoryList[index].mainPrice,
                  stroked_price:
                      homeData.homeEightCategoryList[index].strokedPrice,
                  has_discount:
                      homeData.homeEightCategoryList[index].hasDiscount,
                  is_wholesale:
                      homeData.homeEightCategoryList[index].isWholesale,
                  discount: homeData.homeEightCategoryList[index].discount,
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
            AppLocalizations.of(context)!.no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  // Widget buildHomeMenuRow1(BuildContext context, HomePresenter homeData) {
  //   return Row(
  //     children: [
  //       if (homeData.isTodayDeal)
  //         Flexible(
  //           flex: 1,
  //           fit: FlexFit.tight,
  //           child: GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) {
  //                   return TodaysDealProducts();
  //                 }),
  //               );
  //             },
  //             child: Container(
  //               height: 90,
  //               decoration: BoxDecorations.buildBoxDecoration_1(),
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(16.0),
  //                     child: Container(
  //                         height: 20,
  //                         width: 20,
  //                         child: Image.asset("assets/todays_deal.png")),
  //                   ),
  //                   Text(AppLocalizations.of(context)!.todays_deal_ucf,
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                           color: Color.fromRGBO(132, 132, 132, 1),
  //                           fontWeight: FontWeight.w300)),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       if (homeData.isTodayDeal && homeData.isFlashDeal) SizedBox(width: 14.0),
  //       if (homeData.isFlashDeal)
  //         // Flexible(
  //         //   flex: 1,
  //         //   fit: FlexFit.tight,
  //         //   child: GestureDetector(
  //         //     onTap: () {
  //         //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         //         return FlashDealList();
  //         //       }));
  //         //     },
  //         //     child: Container(
  //         //       height: 90,
  //         //       decoration: BoxDecorations.buildBoxDecoration_1(),
  //         //       child: Column(
  //         //         children: [
  //         //           Padding(
  //         //             padding: const EdgeInsets.all(16.0),
  //         //             child: Container(
  //         //                 height: 20,
  //         //                 width: 20,
  //         //                 child: Image.asset("assets/flash_deal.png")),
  //         //           ),
  //         //           Text(
  //         //             AppLocalizations.of(context)!.flash_deal_ucf,
  //         //             textAlign: TextAlign.center,
  //         //             style: TextStyle(
  //         //                 color: Color.fromRGBO(132, 132, 132, 1),
  //         //                 fontWeight: FontWeight.w300),
  //         //           ),
  //         //         ],
  //         //       ),
  //         //     ),
  //         //   ),
  //         // )
  //     ],
  //   );
  // }

  Widget buildHomeMenuRow2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /* Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryList(
                  is_top_category: true,
                );
              }));
            },
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width / 3 - 4,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/top_categories.png")),
                  ),
                  Text(
                    AppLocalizations.of(context).home_screen_top_categories,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ),*/
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Filter(
                  selected_filter: "brands",
                );
              }));
            },
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width / 3 - 4,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset("assets/brands.png"),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.brands_ucf,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (vendor_system.$)
          SizedBox(
            width: 10,
          ),
        if (vendor_system.$)
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return TopSellingProducts();
                  }),
                );
              },
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width / 3 - 4,
                decoration: BoxDecorations.buildBoxDecoration_1(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/top_sellers.png")),
                    ),
                    Text(AppLocalizations.of(context)!.top_sellers_ucf,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1),
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildHomeCarouselSlider(context, HomePresenter homeData) {
    if (homeData.isCarouselInitial && homeData.carouselImageList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 22, right: 22, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (homeData.carouselImageList.length > 0) {
      return CarouselSlider(
        // options: CarouselOptions(
        //     aspectRatio: 338 / 140,
        //     viewportFraction: 0.8,
        //     initialPage: 0,
        //     reverse: false,
        //     autoPlay: true,
        //     autoPlayInterval: Duration(seconds: 5),
        //     autoPlayAnimationDuration: Duration(milliseconds: 1000),
        //     autoPlayCurve: Curves.fastOutSlowIn,
        //     enlargeCenterPage: false,
        //     scrollDirection: Axis.horizontal,
        //     onPageChanged: (index, reason) {
        //       homeData.incrementCurrentSlider(index);
        //     }),
        options: CarouselOptions(
            aspectRatio: 330 / 140,
            autoPlay: true,
            padEnds: false,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              homeData.incrementCurrentSlider(index);
            }),
        items: homeData.carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 6, right: 6, top: 0, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 20,
                  child: AIZImage.radiusImage(i, 6),
                ),
              );
            },
          );
        }).toList(),
      );
    } else if (!homeData.isCarouselInitial &&
        homeData.carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildHomeBannerOne(context, HomePresenter homeData) {
    if (homeData.isBannerOneInitial &&
        homeData.bannerOneImageList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (homeData.bannerOneImageList.length > 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 9.0, right: 9.0),
        child: CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 270 / 120,
              viewportFraction: 1,
              initialPage: 0,
              padEnds: false,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                // setState(() {
                //   homeData.current_slider = index;
                // });
              }),
          items: homeData.bannerOneImageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, right: 9, top: 20.0, bottom: 20),
                  child: Container(
                    //color: Colors.amber,
                    width: double.infinity,
                    child: AIZImage.radiusImage(i, 6),
                  ),
                );
              },
            );
          }).toList(),
        ),
      );
    } else if (!homeData.isBannerOneInitial &&
        homeData.bannerOneImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildHomeBannerTwo(context, HomePresenter homeData) {
    if (homeData.isBannerTwoInitial &&
        homeData.bannerTwoImageList.length == 0) {
      return Padding(
          padding:
              const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 10),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (homeData.bannerTwoImageList.length > 0) {
      return Padding(
        padding: app_language_rtl.$!
            ? const EdgeInsets.only(right: 9.0)
            : const EdgeInsets.only(left: 9.0),
        child: CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 270 / 120,
              viewportFraction: 0.7,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInExpo,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                // setState(() {
                //   homeData.current_slider = index;
                // });
              }),
          items: homeData.bannerTwoImageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, right: 9, top: 20.0, bottom: 10),
                  child: Container(
                      width: double.infinity,
                      child: AIZImage.radiusImage(i, 6)),
                );
              },
            );
          }).toList(),
        ),
      );
    } else if (!homeData.isCarouselInitial &&
        homeData.carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)!.no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyTheme.accent_color,
      centerTitle: false,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Filter();
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.start,
              enabled: false,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search...',
                hintStyle: TextStyle(color: Color(0XFFa9a9a9)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0XFFa9a9a9),
                ),
                contentPadding: EdgeInsets.only(top: 5),
                suffixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Image.asset(
                    'assets/voice_search.png',
                    fit: BoxFit.contain,
                    height: 20,
                    width: 20,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildHomeSearchBox(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecorations.buildBoxDecoration_1(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.search_anything,
              style: TextStyle(fontSize: 13.0, color: MyTheme.textfield_grey),
            ),
            Image.asset(
              'assets/search.png',
              height: 16,
              //color: MyTheme.dark_grey,
              color: MyTheme.dark_grey,
            )
          ],
        ),
      ),
    );
  }

  Container buildProductLoadingContainer(HomePresenter homeData) {
    return Container(
      height: homeData.showAllLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(
            homeData.totalAllProductData == homeData.allProductList.length
                ? AppLocalizations.of(context)!.no_more_products_ucf
                : AppLocalizations.of(context)!.loading_more_products_ucf),
      ),
    );
  }
}
