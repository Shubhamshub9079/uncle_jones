import 'dart:async';
import 'package:UncleJons/custom/toast_component.dart';
import 'package:UncleJons/repositories/brand_repository.dart';
import 'package:UncleJons/repositories/category_repository.dart';
import 'package:UncleJons/repositories/flash_deal_repository.dart';
import 'package:UncleJons/repositories/product_repository.dart';
import 'package:UncleJons/repositories/sliders_repository.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HomePresenter extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int current_slider = 0;
  ScrollController? allProductScrollController;
  ScrollController? featuredCategoryScrollController;
  ScrollController mainScrollController = ScrollController();

  late AnimationController pirated_logo_controller;
  late Animation pirated_logo_animation;

  var carouselImageList = [];
  var bannerOneImageList = [];
  var bannerTwoImageList = [];
  var featuredCategoryList = [];
  var HomeOneCategoryList = [];
  var HomeTwoCategoryList = [];
  var HomeThreeCategoryList = [];
  var HomeFourCategoryList = [];
  var homeBrandList = [];

  bool isBrandInitial = true;
  bool isCategoryInitial = true;
  bool isCarouselInitial = true;
  bool isBannerOneInitial = true;
  bool isOneInitial = true;
  bool isTwoInitial = true;
  bool isThereInitial = true;
  bool isFourInitial = true;
  bool isBannerTwoInitial = true;

  var featuredProductList = [];
  bool isFeaturedProductInitial = true;
  int? totalFeaturedProductData = 0;
  int featuredProductPage = 1;
  bool showFeaturedLoadingContainer = false;

  bool isTodayDeal = false;
  bool isFlashDeal = false;

  var allProductList = [];
  bool isAllProductInitial = true;
  int? totalAllProductData = 0;
  int allProductPage = 1;
  bool showAllLoadingContainer = false;
  int cartCount = 0;

  fetchAll() {
    fetchCarouselImages();
    fetchBannerOneImages();
    fetchBannerTwoImages();
    fetchFeaturedCategories();
    fetchFeaturedProducts();
    fetchAllProducts();
    fetchTodayDealData();
    fetchFlashDealData();
    fetchDairyBeverages();
    fetchCake();
    fetchPersonalCare();
    fetchHomeKitchen();
    fetchBrandData();
  }

  fetchTodayDealData() async {
    var deal = await ProductRepository().getTodaysDealProducts();
    print(deal.products!.length);
    if (deal.success! && deal.products!.isNotEmpty) {
      isTodayDeal = true;
      notifyListeners();
    }
  }

  fetchFlashDealData() async {
    var deal = await FlashDealRepository().getFlashDeals();

    if (deal.success! && deal.flashDeals!.isNotEmpty) {
      isFlashDeal = true;
      notifyListeners();
    }
  }

  fetchCarouselImages() async {
    var carouselResponse = await SlidersRepository().getSliders();
    carouselResponse.sliders!.forEach((slider) {
      carouselImageList.add(slider.photo);
    });
    isCarouselInitial = false;
    notifyListeners();
  }

  fetchBrandData() async {
    var bannerOneResponse = await BrandRepository().getBrands();
    bannerOneResponse.brands!.forEach((item) {
      homeBrandList.add(item);
    });
    isBrandInitial = false;
    notifyListeners();
  }


  fetchBannerOneImages() async {
    var bannerOneResponse = await SlidersRepository().getBannerOneImages();
    bannerOneResponse.sliders!.forEach((slider) {
      bannerOneImageList.add(slider.photo);
    });
    isBannerOneInitial = false;
    notifyListeners();
  }

  fetchDairyBeverages() async {
    var homeOneResponse = await CategoryRepository().getHomeCategoryDairyBeverage();
    homeOneResponse.data!.forEach((item) {
      HomeOneCategoryList.add(item);
    });
    isOneInitial = false;
    notifyListeners();
  }



  fetchHomeKitchen() async {
    var homeOneResponse = await CategoryRepository().getHomeHomeKitchen();
    homeOneResponse.data!.forEach((item) {
      HomeTwoCategoryList.add(item);
    });
    isTwoInitial= false;
    notifyListeners();
  }


  fetchCake() async {
    var homeOneResponse = await CategoryRepository().getHomeCake();
    homeOneResponse.data!.forEach((item) {
      HomeThreeCategoryList.add(item);
    });
    isThereInitial = false;
    notifyListeners();
  }


  fetchPersonalCare() async {
    var homeOneResponse = await CategoryRepository().getHomePersonalCare();
    homeOneResponse.data!.forEach((item) {
      HomeFourCategoryList.add(item);
    });
    isFourInitial = false;
    notifyListeners();
  }


  fetchBannerTwoImages() async {
    var bannerTwoResponse = await SlidersRepository().getBannerTwoImages();
    bannerTwoResponse.sliders!.forEach((slider) {
      bannerTwoImageList.add(slider.photo);
    });
    isBannerTwoInitial = false;
    notifyListeners();
  }

  fetchFeaturedCategories() async {
    var categoryResponse = await CategoryRepository().getFeturedCategories();
    featuredCategoryList.addAll(categoryResponse.categories!);
    isCategoryInitial = false;
    notifyListeners();
  }

  fetchFeaturedProducts() async {
    var productResponse = await ProductRepository().getFeaturedProducts(
      page: featuredProductPage,
    );
    featuredProductPage++;
    featuredProductList.addAll(productResponse.products!);
    isFeaturedProductInitial = false;
    totalFeaturedProductData = productResponse.meta!.total;
    showFeaturedLoadingContainer = false;
    notifyListeners();
  }

  fetchAllProducts() async {
    var productResponse =
        await ProductRepository().getFilteredProducts(page: allProductPage);
    if (productResponse.products!.isEmpty) {
      ToastComponent.showDialog("No more products!", gravity: Toast.center);
      return;
    }

    allProductList.addAll(productResponse.products!);
    isAllProductInitial = false;
    totalAllProductData = productResponse.meta!.total;
    showAllLoadingContainer = false;
    notifyListeners();
  }

  reset() {
    carouselImageList.clear();
    bannerOneImageList.clear();
    bannerTwoImageList.clear();
    featuredCategoryList.clear();
    HomeOneCategoryList.clear();
    HomeTwoCategoryList.clear();
    HomeThreeCategoryList.clear();
    HomeFourCategoryList.clear();
    homeBrandList.clear();
    isCarouselInitial = true;
    isBrandInitial = true;
    isBannerOneInitial = true;
    isBannerTwoInitial = true;
    isCategoryInitial = true;
    isOneInitial = true;
    isFourInitial = true;
    isTwoInitial = true;
    isThereInitial = true;
    cartCount = 0;

    resetFeaturedProductList();
    resetAllProductList();
  }

  Future<void> onRefresh() async {
    reset();
    fetchAll();
  }

  resetFeaturedProductList() {
    featuredProductList.clear();
    isFeaturedProductInitial = true;
    totalFeaturedProductData = 0;
    featuredProductPage = 1;
    showFeaturedLoadingContainer = false;
    notifyListeners();
  }

  resetAllProductList() {
    allProductList.clear();
    isAllProductInitial = true;
    totalAllProductData = 0;
    allProductPage = 1;
    showAllLoadingContainer = false;
    notifyListeners();
  }

  mainScrollListener() {
    mainScrollController.addListener(() {
      //print("position: " + xcrollController.position.pixels.toString());
      //print("max: " + xcrollController.position.maxScrollExtent.toString());

      if (mainScrollController.position.pixels ==
          mainScrollController.position.maxScrollExtent) {
        allProductPage++;
        ToastComponent.showDialog("More Products Loading...",
            gravity: Toast.center);
        showAllLoadingContainer = true;
        fetchAllProducts();
      }
    });
  }

  initPiratedAnimation(vnc) {
    pirated_logo_controller =
        AnimationController(vsync: vnc, duration: Duration(milliseconds: 2000));
    pirated_logo_animation = Tween(begin: 40.0, end: 60.0).animate(
        CurvedAnimation(
            curve: Curves.bounceOut, parent: pirated_logo_controller));

    pirated_logo_controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        pirated_logo_controller.repeat();
      }
    });

    pirated_logo_controller.forward();
  }

  // incrementFeaturedProductPage(){
  //   featuredProductPage++;
  //   notifyListeners();
  //
  // }

  incrementCurrentSlider(index) {
    current_slider = index;
    notifyListeners();
  }

  // void dispose() {
  //   pirated_logo_controller.dispose();
  //   notifyListeners();
  // }
  //

  @override
  void dispose() {
    // TODO: implement dispose
    pirated_logo_controller.dispose();
    notifyListeners();
    super.dispose();
  }
}
