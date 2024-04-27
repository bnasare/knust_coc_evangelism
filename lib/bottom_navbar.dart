import 'package:evangelism_admin/core/prospect/presentation/interface/pages/register_prospect.dart';
import 'package:evangelism_admin/src/locales/presentation/interface/pages/location_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'shared/presentation/theme/extra_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> _buildScreens() {
    return [
      RegisterProspectPage(),
      LocationPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: Theme.of(context).textTheme.bodyLarge,
        icon: const Icon(IconlyLight.add_user),
        title: 'Register',
        activeColorPrimary: ExtraColors.link,
        inactiveColorPrimary: ExtraColors.linkLight,
      ),
      PersistentBottomNavBarItem(
        textStyle: Theme.of(context).textTheme.bodyLarge,
        icon: const Icon(IconlyLight.location),
        title: 'Locale',
        activeColorPrimary: ExtraColors.link,
        inactiveColorPrimary: ExtraColors.linkLight,
      ),
    ];
  }

  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0,
          color: ExtraColors.primaryText,
        ),
        Flexible(
          child: PersistentTabView(
            navBarHeight: 80,
            padding: const NavBarPadding.only(
                left: 0, right: 0, bottom: 10, top: 20),
            context,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: ExtraColors.background,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 700),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 700),
            ),
            navBarStyle: NavBarStyle.style8,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: false,
            decoration: const NavBarDecoration(
              border: Border(top: BorderSide(color: ExtraColors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
