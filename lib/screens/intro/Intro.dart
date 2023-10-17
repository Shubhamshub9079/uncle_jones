import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/custom/device_info.dart';
import 'package:UncleJons/helpers/addons_helper.dart';
import 'package:UncleJons/helpers/auth_helper.dart';
import 'package:UncleJons/helpers/business_setting_helper.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:UncleJons/presenter/currency_presenter.dart';
import 'package:UncleJons/providers/locale_provider.dart';
import 'package:UncleJons/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: AppConfig.app_name,
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPackageInfo();
    getSharedValueHelperData().then((value) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setLocale(app_mobile_language.$!);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Main(
                go_back: false,
              );
            },
          ),
              (route) => false,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return splashScreen();
  }

  Widget splashScreen() {
    return Container(
      width: DeviceInfo(context).height,
      height: DeviceInfo(context).height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/splash_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Hero(
        tag: "splashscreenImage",
        child:  Image.asset(
          "assets/splash_screen_logo.png",
          height: 100,
          width: 100,
        ),
      ),
    );
  }

  Future<String?> getSharedValueHelperData() async {
    access_token.load().whenComplete(() {
      AuthHelper().fetch_and_set();
    });
    AddonsHelper().setAddonsData();
    BusinessSettingHelper().setBusinessSettingData();
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();
    await system_currency.load();
    Provider.of<CurrencyPresenter>(context, listen: false).fetchListData();

    // print("new splash screen ${app_mobile_language.$}");
    // print("new splash screen app_language_rtl ${app_language_rtl.$}");

    return app_mobile_language.$;
  }
}
