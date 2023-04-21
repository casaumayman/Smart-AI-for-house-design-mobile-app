import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.isHome = false, this.openDrawer});
  final bool isHome;
  final Function()? openDrawer;

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Get.theme.primaryColor;
    return AppBar(
      leading: Row(
        children: [
          isHome
              ? Container()
              : BackButton(
                  color: const Color(0xFF002a9c),
                  onPressed: () {
                    Get.back();
                  },
                ),
          Image.asset(
            'lib/assets/tgl_logo.png',
            fit: BoxFit.contain,
          )
        ],
      ),
      backgroundColor: Colors.white,
      leadingWidth: double.infinity,
      elevation: 0,
      // leadingWidth: 200,
      actions: isHome
          ? [
              IconButton(
                onPressed: () {
                  openDrawer?.call();
                },
                icon: const Icon(Icons.menu),
                color: primaryColor,
              )
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
