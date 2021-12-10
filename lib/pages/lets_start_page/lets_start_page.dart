import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/home_page/home_page.dart';
import 'package:mediation_test/mediation_test.dart';

class LetsStartPage extends StatefulWidget {

  static const routeName = '/lets_start_page';

  @override
  _LetsStartPageState createState() => _LetsStartPageState();
}

class _LetsStartPageState extends State<LetsStartPage> {

  static const platform = const MethodChannel(
      "com.flutter.actimi/mHcService");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // runHcService();
  }

  void runHcService() async {
    String value;
    try {
      value = await platform.invokeMethod("run HCService");
    } catch (e) {
      print("Channel Error $e");
    }
  }

  void callChannel() async {
    const platform =
    const MethodChannel('com.example.nativespecificcodeproject/browser');
    final result = await platform.invokeMethod("setRingtone", <String, String>{
      'path': "path"
      // '/storage/emulated/0/Download/audio_clip.mp3'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Strings.lets_start_page_bg),
                fit: BoxFit.cover
          )
        ),
        child:
    // Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Text('Lets Start Page')),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: IconButton(
              iconSize: 90,
              // color: Colors.red,
              icon: Image.asset(Strings.lets_start_buttonIcon,),
              onPressed: () {
                // callChannel();
                Navigator.pushReplacementNamed(context, HomePage.ROUTE_NAME);
                // MediationTest.presentTestSuite();
              },
            ),
          ),
        ),
      ),
    );
  }
}
