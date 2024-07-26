import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/screens/auth/states/auth_state.dart';
import '/components/list_tile/divider_list_tile.dart';
import '../../../constants/styles.dart';

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _authState = Get.put(AuthState());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: ListView(
          children: [
            Obx(() {
              return ProfileCard(
                name: "Gaston",
                email: _authState.currentUser.value!.phoneNumber!,
                imageSrc: "assets/icons/profil-2.png",
                press: () {
                  Navigator.pop(context);
                },
              );
            }),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                "Compte",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            ProfileMenuListTile(
              text: "History",
              svgSrc: "assets/icons/Order.svg",
              press: () {
                //Navigator.pushNamed(context, ordersScreenRoute);
              },
            ),

            ProfileMenuListTile(
              text: "Addresses",
              svgSrc: "assets/icons/Address.svg",
              press: () {
                //Navigator.pushNamed(context, addressesScreenRoute);
              },
            ),
            ProfileMenuListTile(
              text: "Payment",
              svgSrc: "assets/icons/card.svg",
              press: () {
                //Navigator.pushNamed(context, emptyPaymentScreenRoute);
              },
            ),
            ProfileMenuListTile(
              text: "Wallet",
              svgSrc: "assets/icons/Wallet.svg",
              press: () {
                //Navigator.pushNamed(context, walletScreenRoute);
              },
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Personnalisation",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            DividerListTileWithTrilingText(
              svgSrc: "assets/icons/Notification.svg",
              title: "Notification",
              trilingText: "Off",
              press: () {
                //Navigator.pushNamed(context, enableNotificationScreenRoute);
              },
            ),
            ProfileMenuListTile(
              text: "Preferences",
              svgSrc: "assets/icons/Preferences.svg",
              press: () {
                //Navigator.pushNamed(context, preferencesScreenRoute);
              },
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Paramètres",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ProfileMenuListTile(
              text: "Language",
              svgSrc: "assets/icons/Language.svg",
              press: () {
                //Navigator.pushNamed(context, selectLanguageScreenRoute);
              },
            ),
            ProfileMenuListTile(
              text: "Location",
              svgSrc: "assets/icons/Location.svg",
              press: () {},
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Aide & Support",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ProfileMenuListTile(
              text: "Aide",
              svgSrc: "assets/icons/Help.svg",
              press: () {
                //Navigator.pushNamed(context, getHelpScreenRoute);
              },
            ),
            ProfileMenuListTile(
              text: "FAQ",
              svgSrc: "assets/icons/FAQ.svg",
              press: () {},
              isShowDivider: false,
            ),
            const SizedBox(height: defaultPadding),

            // Log Out
            ListTile(
              onTap: () {},
              minLeadingWidth: 24,
              leading: SvgPicture.asset(
                "assets/icons/Logout.svg",
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  errorColor,
                  BlendMode.srcIn,
                ),
              ),
              title: const Text(
                "Déconnexion",
                style: TextStyle(color: errorColor, fontSize: 14, height: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
