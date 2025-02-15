import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/views/desktop/send/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  final Config config;
  IntroScreen(this.config);

  @override
  IntroScreenState createState() => new IntroScreenState(config);
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  final Config config;
  IntroScreenState(this.config);

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
          title: END_TO_END_ENCRYPTION,
          titleTextFontSize: 44.0,
          subTitleTextFontSize: 24.0,
          desktopActionButtonEnabled: true,
          description:
              SEND_AND_RECEIVE_FILES_SECURELY_WITH_SIMPLICITY_AND_SPEED,
          btnTitle: NEXT,
          pathImage: INTRO_LOGO,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: NO_SIGN_UP,
          titleTextFontSize: 44.0,
          subTitleTextFontSize: 24.0,
          desktopActionButtonEnabled: true,
          description: SEND_AND_RECEIVE_FILES_WITH_NO_NEED_TO_SIGN_UP,
          pathImage: PRIVACY_IMG,
          backgroundColor: Colors.black,
          btnTitle: NEXT,
          heightImage: 300.0),
    );
    slides.add(
      new Slide(
          title: DEVICE_TO_DEVICE,
          titleTextFontSize: 44.0,
          subTitleTextFontSize: 24.0,
          desktopActionButtonEnabled: true,
          description: SEND_AND_RECEIVE_FROM_AND_TO_YOUR_DEVICE_WITHOUT_STORING,
          btnTitle: GET_STARTED,
          maxLineTextDescription: 3,
          pathImage: DEVICE_TO_DEVICE_IMG,
          backgroundColor: Colors.black,
          heightImage: 300.0),
    );
  }

  Future setSeenToTrue() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SEEN, true);
  }

  void onDonePress() async {
    await setSeenToTrue();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendScreen()),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      showSkipBtn: false,
      showNextBtn: false,
      showPrevBtn: false,
      showDoneBtn: false,
      desktopActionButtonEnabled: true,
      termsLink: TERMS_LINK,
      onDonePress: this.onDonePress,
      colorDot: Theme.of(context).scaffoldBackgroundColor,
      colorActiveDot: Theme.of(context).colorScheme.secondary,
      sizeDot: 13.0,
      hideStatusBar: false,
      backgroundColorAllSlides: Colors.grey,
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
