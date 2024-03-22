import 'package:UncleJons/custom/btn.dart';
import 'package:UncleJons/custom/lang_text.dart';
import 'package:UncleJons/custom/toast_component.dart';
import 'package:UncleJons/custom/useful_elements.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/helpers/shimmer_helper.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/repositories/address_repository.dart';
import 'package:UncleJons/screens/address.dart';
import 'package:UncleJons/screens/shipping_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

import '../custom/text_styles.dart';

class SelectAddress extends StatefulWidget {
  int? owner_id;

  SelectAddress({Key? key, this.owner_id}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  ScrollController _mainScrollController = ScrollController();

  // integer type variables
  int? _seleted_shipping_address = 0;

  // list type variables
  List<dynamic> _shippingAddressList = [];

  // List<PickupPoint> _pickupList = [];
  // List<City> _cityList = [];
  // List<Country> _countryList = [];

  // String _shipping_cost_string = ". . .";

  // Boolean variables
  bool isVisible = true;
  bool _faceData = false;

  //double variables
  double mWidth = 0;
  double mHeight = 0;

  fetchAll() {
    if (is_logged_in.$ == true) {
      fetchShippingAddressList();
      //fetchPickupPoints();
    }
    setState(() {});
  }

  fetchShippingAddressList() async {
    var addressResponse = await AddressRepository().getAddressList();
    _shippingAddressList.addAll(addressResponse.addresses);
    if (_shippingAddressList.length > 0) {
      _seleted_shipping_address = _shippingAddressList[0].id;

      _shippingAddressList.forEach((address) {
        if (address.set_default == 1) {
          _seleted_shipping_address = address.id;
        }
      });
    }
    _faceData = true;
    setState(() {});

    // getSetShippingCost();
  }

  reset() {
    _shippingAddressList.clear();
    _faceData = false;
    _seleted_shipping_address = 0;
  }

  Future<void> _onRefresh() async {
    reset();
    if (is_logged_in.$ == true) {
      fetchAll();
    }
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  afterAddingAnAddress() {
    reset();
    fetchAll();
  }

  onPressProceed(context) async {
    if (_seleted_shipping_address == 0) {
      ToastComponent.showDialog(
          LangText(context).local!.choose_an_address_or_pickup_point,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    late var addressUpdateInCartResponse;

    if (_seleted_shipping_address != 0) {
      print(_seleted_shipping_address.toString() + "dddd");
      addressUpdateInCartResponse = await AddressRepository()
          .getAddressUpdateInCartResponse(
              address_id: _seleted_shipping_address);
    }
    if (addressUpdateInCartResponse.result == false) {
      ToastComponent.showDialog(addressUpdateInCartResponse.message,
          gravity: Toast.center, duration: Toast.lengthLong);
      return;
    }

    ToastComponent.showDialog(addressUpdateInCartResponse.message,
        gravity: Toast.center, duration: Toast.lengthLong);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShippingInfo();
    })).then((value) {
      onPopped(value);
    });
    // } else if (_seleted_shipping_pickup_point != 0) {
    //   print("Selected pickup point ");
    // } else {
    //   print("..........something is wrong...........");
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (is_logged_in.$ == true) {
      fetchAll();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: buildAppBarmy(context),
        // AppBar(
        //     elevation: 0,
        //     leading: UsefulElements.backButton(context,color: 'white'),
        //     centerTitle: true,
        //     backgroundColor: MyTheme.black,title: buildAppbarTitle(context),),
        backgroundColor: Colors.white,
        bottomNavigationBar: buildBottomAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  AppBar buildAppBarmy(BuildContext context) {
    return AppBar(
      backgroundColor: MyTheme.accent_color,
      leading: Builder(
        builder: (context) =>
            UsefulElements.backButton(context, color: 'white'),
      ),
      centerTitle: true,
      title: Text(
        "${LangText(context).local!.shipping_info}",
        style: TextStyles.buildAppBarTexStyleWhite(),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  RefreshIndicator buildBody(BuildContext context) {
    return RefreshIndicator(
      color: MyTheme.accent_color,
      backgroundColor: Colors.white,
      onRefresh: _onRefresh,
      displacement: 0,
      child: Container(
        child: buildBodyChildren(context),
      ),
    );
  }

  Widget buildBodyChildren(BuildContext context) {
    return buildShippingListContainer(context);
  }

  Container buildShippingListContainer(BuildContext context) {
    return Container(
      child: CustomScrollView(
        controller: _mainScrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildShippingInfoList()),
            buildAddOrEditAddress(context),
            SizedBox(
              height: 100,
            )
          ]))
        ],
      ),
    );
  }

  Widget buildAddOrEditAddress(BuildContext context) {
    return Container(
      height: 55,
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Address(
                from_shipping_info: true,
              );
            })).then((value) {
              onPopped(value);
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,5, 5, 10),
            child: Container(
              height: 95,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: MyTheme.green),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'To Add Or Edit Address',
                      style: TextStyle(
                          fontSize: 13,
                          //  decoration: TextDecoration.underline,height: 1,
                          color: MyTheme.white,
                          fontWeight: FontWeight.w900),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: MyTheme.white,size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "${LangText(context).local!.shipping_cost_ucf}",
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildShippingInfoList() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            LangText(context).local!.you_need_to_log_in,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else if (!_faceData && _shippingAddressList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_shippingAddressList.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _shippingAddressList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: buildShippingInfoItemCard(index),
            );
          },
        ),
      );
    } else if (_faceData && _shippingAddressList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            LangText(context).local!.no_address_is_added,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  GestureDetector buildShippingInfoItemCard(index) {
    return GestureDetector(
      onTap: () {
        if (_seleted_shipping_address != _shippingAddressList[index].id) {
          _seleted_shipping_address = _shippingAddressList[index].id;

          // onAddressSwitch();
        }
        //detectShippingOption();
        setState(() {});
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: _seleted_shipping_address == _shippingAddressList[index].id
              ? BorderSide(color: MyTheme.accent_color, width: 2.0)
              : BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildShippingInfoItemChildren(index),
        ),
      ),
    );
  }

  Column buildShippingInfoItemChildren(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildShippingInfoItemAddress(index),
        buildShippingInfoItemCity(index),
        buildShippingInfoItemState(index),
        buildShippingInfoItemCountry(index),
        buildShippingInfoItemPostalCode(index),
        buildShippingInfoItemPhone(index),
      ],
    );
  }

  Padding buildShippingInfoItemPhone(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.phone_ucf,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Text(
              _shippingAddressList[index].phone,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildShippingInfoItemPostalCode(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.postal_code,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Text(
              _shippingAddressList[index].postal_code,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildShippingInfoItemCountry(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.country_ucf,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Text(
              _shippingAddressList[index].country_name,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildShippingInfoItemState(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.state_ucf,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Text(
              _shippingAddressList[index].state_name,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildShippingInfoItemCity(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.city_ucf,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 200,
            child: Text(
              _shippingAddressList[index].city_name,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildShippingInfoItemAddress(index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 75,
            child: Text(
              LangText(context).local!.address_ucf,
              style: TextStyle(
                color: MyTheme.grey_153,
              ),
            ),
          ),
          Container(
            width: 175,
            child: Text(
              _shippingAddressList[index].address,
              maxLines: 2,
              style: TextStyle(
                  color: MyTheme.dark_grey, fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(),
          buildShippingOptionsCheckContainer(
              _seleted_shipping_address == _shippingAddressList[index].id)
        ],
      ),
    );
  }

  Container buildShippingOptionsCheckContainer(bool check) {
    return check
        ? Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Icon(Icons.check, color: Colors.white, size: 10),
            ),
          )
        : Container();
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
              child: Btn.minWidthFixHeight(
                minWidth: MediaQuery.of(context).size.width * 0.9,
                height: 40,
                color: MyTheme.accent_color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  LangText(context).local!.continue_to_delivery_info_ucf,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  onPressProceed(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: MyTheme.white,
              child: Row(
                children: [
                  buildAppbarBackArrow(),
                ],
              ),
            ),
            // container for gaping into title text and title-bottom buttons
            Container(
              padding: EdgeInsets.only(top: 2),
              width: mWidth,
              color: MyTheme.light_grey,
              height: 1,
            ),
            //buildChooseShippingOption(context)
          ],
        ),
      ),
    );
  }

  Container buildAppbarTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      child: Text(
        "${LangText(context).local!.shipping_info}",
        style: TextStyle(
          fontSize: 16,
          color: MyTheme.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buildAppbarBackArrow() {
    return Container(
      width: 40,
      child: UsefulElements.backButton(context),
    );
  }

/*
  Widget buildChooseShippingOption(BuildContext context) {
    // if(carrier_base_shipping.$){
    if (true) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        width: DeviceInfo(context).width,
        alignment: Alignment.center,
        child: Text(
          "Choose Shipping Area",
          style: TextStyle(
              color: MyTheme.dark_grey,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
      );
    }
    return Visibility(
      visible: pick_up_status.$,
      child: ScrollToHideWidget(
        child: Container(
          color: MyTheme.white,
          //MyTheme.light_grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildAddresOption(context),
              Container(
                width: 0.5,
                height: 30,
                color: MyTheme.grey_153,
              ),
              buildPockUpPointOption(context),
            ],
          ),
        ),
        scrollController: _mainScrollController,
        childHeight: 40,
      ),
    );
  }*/
/*
  FlatButton buildPockUpPointOption(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        setState(() {
          changeShippingOption(false);
        });
      },
      child: Container(
        color: MyTheme.white,
        alignment: Alignment.center,
        height: 50,
        width: (mWidth / 2) - 1,
        child: Text(
          LangText(context).local.pickup_point,
          style: TextStyle(
              color: _shippingOptionIsAddress
                  ? MyTheme.medium_grey_50
                  : MyTheme.dark_grey,
              fontWeight: !_shippingOptionIsAddress
                  ? FontWeight.w700
                  : FontWeight.normal),
        ),
      ),
    );
  }


  FlatButton buildAddresOption(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        setState(() {
          changeShippingOption(true);
        });
      },
      child: Container(
        color: MyTheme.white,
        height: 50,
        width: (mWidth / 2) - 1,
        alignment: Alignment.center,
        child: Text(
          LangText(context).local.address_screen_address,
          style: TextStyle(
              color: _shippingOptionIsAddress
                  ? MyTheme.dark_grey
                  : MyTheme.medium_grey_50,
              fontWeight: _shippingOptionIsAddress
                  ? FontWeight.w700
                  : FontWeight.normal),
        ),
      ),
    );
  }
  */
}
