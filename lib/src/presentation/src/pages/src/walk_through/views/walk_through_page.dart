import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carzoum/carzoum.dart';

class WalkThroughPage extends StatelessWidget {
  WalkThroughPage({
    super.key,
  });

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WalkThroughPage());
  }

  final List<OnbordingData> list = [
    onbordingDateWrapper(
      image: SvgPicture.asset(
        'assets/images/others/wm5.svg',
        height: 30.h,
        width: 30.w,
      ),
      title: "welcome",
      description: "welcome_splash_message",
    ),
    onbordingDateWrapper(
      image: SvgPicture.asset(
        'assets/images/others/wm2.svg',
        height: 30.h,
        width: 30.w,
      ),
      title: "Reduce",
      description:
          "Let's reduce the amount of waste we emit to our environment",
    ),
    onbordingDateWrapper(
      image: SvgPicture.asset(
        'assets/images/others/wm3.svg',
        height: 30.h,
        width: 30.w,
      ),
      title: "Reuse",
      description: "Learn to reuse our waste and give use to it.",
    ),
    onbordingDateWrapper(
      image: SvgPicture.asset(
        'assets/images/others/wm4.svg',
        height: 30.h,
        width: 30.w,
      ),
      title: "Recycle",
      description:
          "Don't reinvent the wheel. Recyle your waste and keep your enviroment clean.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      selectedDotColor: primaryColor,
      navigatorPadding: SizerUtil.deviceType == DeviceType.mobile
          ? EdgeInsets.symmetric(horizontal: 28.sp, vertical: 10)
          : EdgeInsets.symmetric(horizontal: 14.sp, vertical: 10),
      colors: const [
        //list of colors for per pages
        Colors.white,
        primaryColor,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      nextButton: CustomContainer(
        borderRadius: BorderRadius.circular(5),
        padding: const EdgeInsets.all(10),
        backgroundColor: secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "next",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Icon(
              Icons.arrow_forward,
              size: 12,
              color: Colors.black,
            ),
          ],
        ),
      ),
      lastButton: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            const AuthenticationHasWalkedThroughChanged(
              hasWalkedThrough: true,
            ),
          );
          _showWelcomeMessage();
        },
        child: CustomContainer(
          borderRadius: BorderRadius.circular(5),
          padding: EdgeInsets.all(10),
          backgroundColor: secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Start Now",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                width: 100.w * 0.02,
              ),
              Icon(
                Icons.arrow_forward,
                size: 12,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      skipButton: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            const AuthenticationHasWalkedThroughChanged(
              hasWalkedThrough: true,
            ),
          );
          _showWelcomeMessage();
        },
        child: Text(
          "skip",
          style: TextStyle(
            color: Color(0XFF7B7879),
            fontSize: 14,
          ),
        ),
      ),
      unSelectdDotColor: Colors.grey,
    );
  }
}

_showWelcomeMessage() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'CarZoum',
        body:
            'Hey welcome to CarZoum. Browse and post vehicles for sale and sell fast.',
        actionType: ActionType.Default),
  );
}

OnbordingData onbordingDateWrapper({
  required Widget image,
  required String title,
  required String description,
}) {
  return OnbordingData(
    image: image,
    titleText: SizedBox(
      width: SizerUtil.deviceType == DeviceType.mobile ? 80.sp : 45.sp,
      child: Image.asset("assets/images/others/logo.png"),
    ),
    descText: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 24.sp : 13.sp,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          description,
          style: TextStyle(
            color: Color(0XFF7B7879),
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 6.sp,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    imageHeight: 55.h,
    descPadding: SizerUtil.deviceType == DeviceType.mobile
        ? EdgeInsets.symmetric(horizontal: 25.sp)
        : EdgeInsets.symmetric(horizontal: 14.sp),
  );
}
