import 'package:Nkipay/Screens/Login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:Nkipay/models/header_item.dart';
import 'package:Nkipay/provider/home.dart';
import 'package:Nkipay/provider/theme.dart';
import 'package:Nkipay/routes/routes.dart';
import 'package:Nkipay/utils/constants.dart';
import 'package:Nkipay/utils/globals.dart';
import 'package:Nkipay/utils/screen_helper.dart';
import 'package:Nkipay/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Screens/Welcome/welcome_screen.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, Routes.initial);
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "NK",
                    style: GoogleFonts.josefinSans(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: ref.watch(themeProvider).isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "ipay",
                    style: GoogleFonts.josefinSans(
                      color: kPrimaryColor,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key, required this.themeSwitch}) : super(key: key);
  final Widget themeSwitch;

  static List<NameOnTap> get headerItems => [
        NameOnTap(
          title: "Home",
          iconData: Icons.home,
          onTap: () {},
        ),
        NameOnTap(
          title: "About",
          onTap: () {},
          iconData: Icons.info,
        ),
        // NameOnTap(
        //   title: "Services",
        //   onTap: () {},
        //   iconData: Icons.school,
        // ),
        NameOnTap(
          title: "Our Services",
          onTap: () {},
          iconData: Icons.work,
        ),
        NameOnTap(
          title: "Contact",
          onTap: () {},
          iconData: Icons.contact_mail,
        ),
        // NameOnTap(
        //   title: "Login",
        //   onTap: () {
        //   },
        //   iconData: Icons.login,
        // ),
        NameOnTap(
          title: "Themes",
          onTap: () {
            Utilty.openUrl(AppConstants.mediumUrl);
          },
          iconData: Icons.light_mode_outlined,
          isDarkTheme: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
      visible: false,
      visibleWhen: const [
        Condition.largerThan(name: MOBILE),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          return Row(children: [
            ...headerItems
                .map(
                  (item) => item.title == "Themes"
                      ? const Text("")
                      : MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            margin: const EdgeInsets.only(right: 30.0),
                            child: GestureDetector(
                              onTap: () {
                                item.onTap();
                                HomeProvider _homeProvider =
                                    ref.read(homeProvider);
                                _homeProvider.scrollBasedOnHeader(item);
                              },
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: item.title == "Blogs"
                                      ? kPrimaryColor
                                      : null,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                )
                .toList(),
            themeSwitch,
            TextButton(
              onPressed:
                  // () => Get.rootDelegate.toNamed(Routes.LOGIN),
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.login),
                  Text("Login"),
                  Text("/Signup")
                ],
              ),
            )
          ]);
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.themeSwitch}) : super(key: key);
  final Widget themeSwitch;

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: buildHeader(context, themeSwitch),
      mobile: buildMobileHeader(context),
      tablet: buildHeader(context, themeSwitch),
    );
  }

  // mobile header
  Widget buildMobileHeader(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WelcomeScreen();
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.login),
                  const Text("Login"),
                  const Text("/ Signup")
                ],
              ),
            ),
            const HeaderLogo(),
            GestureDetector(
              onTap: () {
                Globals.scaffoldKey.currentState?.openEndDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lets plan for mobile and smaller width screens
  Widget buildHeader(BuildContext context, Widget themeSwitch) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.isDesktop(context) ? 24 : 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderLogo(),
            HeaderRow(
              themeSwitch: themeSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
