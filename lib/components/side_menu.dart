import 'package:fanimation/components/info_card.dart';
import 'package:fanimation/components/side_menu_tile.dart';
import 'package:fanimation/models/rive_asset.dart';
import 'package:fanimation/utils/rive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    // var menu;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: 288,
          color: Color(0xFF17203A),
          child: SafeArea(
            child: Column(
              children: [
                const InfoCard(
                  name: "bijoy mandal",
                  profession: "Fullstack developer",
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browser".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sideMenus.map(
                  (menu) => SideMenuTile(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(
                        Duration(seconds: 1),
                        () {
                          menu.input!.change(false);
                        },
                      );
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
