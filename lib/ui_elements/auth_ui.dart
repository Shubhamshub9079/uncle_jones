import 'package:UncleJons/custom/box_decorations.dart';
import 'package:UncleJons/custom/device_info.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/my_theme.dart';
import 'package:flutter/material.dart';

class AuthScreen {
  static Widget buildScreen(
      BuildContext context, String headerText, Widget child) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        //key: _scaffoldKey,
        //drawer: MainDrawer(),
        backgroundColor: Colors.white,
        //appBar: buildAppBar(context),
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                height: DeviceInfo(context).height! / 3,
                width: DeviceInfo(context).width,
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/background_1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            CustomScrollView(
              //controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Image.asset('assets/login_registration_form_logo.png',
                            height: 80,width: 80, fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                        child: Text(
                          headerText,
                          style: TextStyle(
                              color: MyTheme.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration:
                              BoxDecorations.buildBoxDecoration_1(radius: 16),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
