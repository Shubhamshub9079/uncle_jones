import 'dart:developer';
import 'package:UncleJons/custom/box_decorations.dart';
import 'package:UncleJons/custom/btn.dart';
import 'package:UncleJons/custom/useful_elements.dart';
import 'package:UncleJons/data_model/category_response.dart';
import 'package:UncleJons/data_model/sub_category_response.dart';
import 'package:UncleJons/helpers/shimmer_helper.dart';
import 'package:UncleJons/presenter/bottom_appbar_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/screens/category_products.dart';
import 'package:UncleJons/repositories/category_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryList extends StatefulWidget {
  CategoryList(
      {Key? key,
      this.parent_category_id = 0,
      this.parent_category_name = "",
      this.is_base_category = false,
      this.is_top_category = false,
      this.bottomAppbarIndex})
      : super(key: key);

  final int parent_category_id;
  final String parent_category_name;
  final bool is_base_category;
  final bool is_top_category;
  final BottomAppbarIndex? bottomAppbarIndex;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  var selectedItem = 0;
  var selectedItemId = "5";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xfffcfcfd),
        appBar: buildAppBar(context),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: const BoxDecoration(
                    color: Color(0xFFffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 5  horizontally
                          1.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: buildTopCategoryList()),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                height: MediaQuery.of(context).size.height,
                child: buildSubCategoryList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyTheme.accent_color,
      leading: widget.is_base_category
          ? Builder(
              builder: (context) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: UsefulElements.backToMain(context,
                    go_back: false, color: "white"),
              ),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
      title: Text(
        getAppBarTitle(),
        style: TextStyle(
            fontSize: 16, color: MyTheme.white, fontWeight: FontWeight.bold),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  String getAppBarTitle() {
    String name = widget.parent_category_name == ""
        ? (widget.is_top_category
            ? AppLocalizations.of(context)!.top_categories_ucf
            : AppLocalizations.of(context)!.categories_ucf)
        : widget.parent_category_name;

    return name;
  }

  buildTopCategoryList() {
    var data = CategoryRepository().getTopCategories();

    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(child: buildShimmer());
          }
          if (snapshot.hasError) {
            //snapshot.hasError
            print("category list error");
            print(snapshot.error.toString());
            return Container(
              height: 10,
            );
          } else if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: snapshot.data!.categories!.length,
                padding: EdgeInsets.symmetric(vertical: 15),
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildCategoryItemCard(snapshot.data, index);
                },
              ),
            );
          } else {
            return SingleChildScrollView(child: buildShimmer());
          }
        });
  }

  buildSubCategoryList() {
    log("selectedItemId - " + selectedItemId.toString());
    var data = CategoryRepository().getSubCategories(selectedItemId);
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<SubCategory> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(child: buildShimmerGrid());
          }
          if (snapshot.hasError) {
            //snapshot.hasError
            print("category list error");
            print(snapshot.error.toString());
            return Container(
              height: 10,
            );
          } else if (snapshot.hasData) {
            return Container(
                margin: EdgeInsets.only(bottom: 60),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data!.length,
                  // Number of items in the grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CategoryProducts(
                                category_id: snapshot.data!.data![index].id,
                                category_name: snapshot.data!.data![index].name,
                              );
                            },
                          ),
                        );
                      },
                      child: Center(
                        // Centering each item
                        child: Container(
                          decoration: BoxDecorations.buildBoxDecoration_1(),
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      topLeft: Radius.circular(6)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeholder.png',
                                    image: snapshot.data!.data![index].banner!,
                                    fit: BoxFit.fitWidth,
                                    height: 60,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.data![index].name!,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Color(0XFF2a2a2a),
                                      fontSize: 12,
                                      height: 1.6,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ));
          } else {
            return SingleChildScrollView(child: buildShimmerGrid());
          }
        });
  }

  Widget buildCategoryItemCard(categoryResponse, index) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
          bottom: 10, left: 15, right: index == selectedItem ? 0 : 15),
      decoration: buildBoxDecoration_2(selected: index == selectedItem),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedItem = index;
          });
          selectedItemId = categoryResponse.categories[index].id.toString();
        },
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6), topLeft: Radius.circular(6)),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png',
                image: categoryResponse.categories[index].banner,
                fit: BoxFit.cover,
                height: 80,
                width: 80,
              ),
            ),
            Text(
              categoryResponse.categories[index].name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: Color(0XFF212121),
                  fontSize: 11,
                  height: 1.6,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubCategoryItemCard(categoryResponse, index) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecorations.buildBoxDecoration_1(),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          // selectedItemId = categoryResponse.id.toString();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return CategoryProducts(
          //         category_id: categoryResponse.categories[index].id,
          //         category_name: categoryResponse.categories[index].name,
          //       );
          //     },
          //   ),
          // );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6), topLeft: Radius.circular(6)),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.png',
                image: categoryResponse.data[index].banner,
                fit: BoxFit.fitWidth,
                height: 60,
              ),
            ),
            Text(
              categoryResponse.data[index].name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: Color(0XFF2a2a2a),
                  fontSize: 12,
                  height: 1.6,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      height: widget.is_base_category ? 0 : 80,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 32),
                height: 40,
                child: Btn.basic(
                  minWidth: MediaQuery.of(context).size.width,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    AppLocalizations.of(context)!.all_products_of_ucf +
                        " " +
                        widget.parent_category_name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryProducts(
                        category_id: widget.parent_category_id,
                        category_name: widget.parent_category_name,
                      );
                    }));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildShimmerGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
        crossAxisCount: 2,
      ),
      itemCount: 18,
      padding: EdgeInsets.only(
          left: 18, right: 18, bottom: widget.is_base_category ? 30 : 0),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecorations.buildBoxDecoration_1(),
          child: ShimmerHelper().buildBasicShimmer(),
        );
      },
    );
  }

  Widget buildShimmer() {
    return ListView.builder(
      itemCount: 18,
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 50),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
          decoration: buildBoxDecoration_2(),
          child: Shimmer.fromColors(
            baseColor: MyTheme.shimmer_base,
            highlightColor: MyTheme.shimmer_highlighted,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecorations.buildBoxDecoration_1(radius: 6),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration buildBoxDecoration_2({double radius = 6.0, selected = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      image: DecorationImage(
          image: AssetImage('assets/background_item.png'),
          fit: BoxFit.cover,
          opacity: selected ? 1 : 0),
      border:
          Border.all(color: selected ? Colors.transparent : Color(0Xfff2f2f2)),
    );
  }
}

class CenteredGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12, // Number of items in the grid
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
      ),
      itemBuilder: (BuildContext context, int index) {
        return Center(
          // Centering each item
          child: Container(
            margin: EdgeInsets.all(8),
            color: Colors.blue,
            height: 100,
            width: 100,
            child: Center(
              child: Text(
                'Item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
