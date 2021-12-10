import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:share/share.dart';

import 'drawer_button_widget.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Strings.text_translator_page_bg),
                fit: BoxFit.cover)),
        child: ListView(padding: EdgeInsets.zero, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Strings.drawerHeaderImage),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 10,
          ),
          DrawerButtonWidget(
            onTap: () {
              final AndroidIntent intent = AndroidIntent(
                  action: 'action_view',
                  data: Uri.encodeFull(
                      "https://play.google.com/store/apps/developer?id=Skipe+Apps"),
                  package:
                  "https://play.google.com/store/apps/developer?id=Skipe+Apps");
              intent.launch();
            },
            title: 'More Apps',
            iconPath: Strings.drawerMoreAppsButtonIcon,
          ),
          Divider(),
          DrawerButtonWidget(
            onTap: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                  "https://play.google.com/store/apps/details?com.skipeapps.translate.alllanguagetranslator.speaktranslate.cameratranslator&hl=en",
                  sharePositionOrigin:
                  box.localToGlobal(Offset.zero) & box.size);
            },
            title: 'Share',
            iconPath: Strings.drawerShareAppButtonIcon,
          ),
          Divider(),
          DrawerButtonWidget(
            onTap: () {
              final AndroidIntent intent = AndroidIntent(
                  action: 'action_view',
                  data: Uri.encodeFull(
                      Strings.privacyPolicyLink),
                  package: Strings.privacyPolicyLink);
              intent.launch();
            },
            title: 'Privacy Policy',
            iconPath: Strings.drawerPrivacyPolicyButtonIcon,
          ),
          Divider(),
          DrawerButtonWidget(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LicensePage(
                  applicationName: 'Translator App',
                );
              }));
            },
            title: 'Licence',
            iconPath: Strings.drawerLicenceButtonIcon,
          ),
          Divider(),
          DrawerButtonWidget(
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            title: 'Exit',
            iconPath: Strings.drawerExitButtonIcon,
          ),
          Divider(),
        ]),
      ),
    );
  }
}
