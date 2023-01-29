import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: trans(context)!.profile,
        actions: [],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: pagePadding,
          child: Column(
            children: [
              2.h.ph,
              ProfileGroup(
                title: trans(context)!.admin,
                children: [
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.person,
                    title: trans(context)!.verify_ads,
                    onTap: () {
                      Navigator.push(context, StoreDetailPage.route());
                    },
                  ),
                ],
              ),
              2.h.ph,
              ProfileGroup(
                title: trans(context)!.other,
                children: [
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.person,
                    title: trans(context)!.my_store_detail,
                    onTap: () {
                      Navigator.push(context, StoreDetailPage.route());
                    },
                  ),
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.ads_click,
                    title: trans(context)!.manage_my_advert,
                    onTap: () {
                      Navigator.push(context, MyAdvertPage.route());
                    },
                  ),
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.ads_click,
                    title: trans(context)!.language,
                    onTap: () {
                      showModalBottomSheet(
                        barrierColor: primaryColor.withOpacity(0.6),
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return const AllLanguages();
                        },
                      );
                    },
                  ),
                ],
              ),
              2.h.ph,
              ProfileGroup(
                title: trans(context)!.settings,
                children: [
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.person,
                    title: 'Show notification',
                    onTap: () {
                      AwesomeNotifications()
                          .isNotificationAllowed()
                          .then((isAllowed) {
                        if (!isAllowed) {
                          // This is just a basic example. For real apps, you must show some
                          // friendly dialog box before call the request method.
                          // This is very important to not harm the user experience
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications();
                        }
                      });

                      _showWelcomeMessage();
                    },
                  ),
                  ProfileUserItem(
                    iconContainerColor: Colors.blue,
                    icon: Icons.person,
                    title: 'Send push notification',
                    onTap: () async {
                      final ParseCloudFunction function =
                          ParseCloudFunction('sendPushFromApp');
                      final ParseResponse parseResponse =
                          await function.execute();
                      if (parseResponse.success &&
                          parseResponse.result != null) {
                        print(parseResponse.result);
                      }
                    },
                  ),
                ],
              ),
              2.h.ph,
              ProfileGroup(
                title: trans(context)!.other,
                children: [
                  ProfileUserItem(
                    iconContainerColor: Colors.indigo,
                    icon: Icons.support,
                    title: trans(context)!.support,
                  ),
                  ProfileUserItem(
                    iconContainerColor: Colors.indigo,
                    icon: Icons.bookmarks_rounded,
                    title: trans(context)!.about_app,
                    onTap: () {
                      Navigator.push(context, AboutAppPage.route());
                    },
                  ),
                ],
              ),
              2.h.ph,
              ProfileGroup(
                title: trans(context)!.information,
                children: const [
                  ProfileUserItem(
                    iconContainerColor: Colors.indigo,
                    icon: Icons.support,
                    title: 'Privacy Policy',
                  ),
                ],
              ),
              5.h.ph,
              ProfileGroup(
                children: [
                  ProfileUserItem(
                    iconContainerColor: Colors.red,
                    icon: Icons.logout,
                    title: trans(context)!.logout,
                    onTap: () async {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLogoutRequested(),
                      );
                    },
                  )
                ],
              ),
              3.h.ph,
            ],
          ),
        ),
      ),
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

class ProfileGroup extends StatelessWidget {
  const ProfileGroup({
    Key? key,
    this.title,
    this.children = const [],
  }) : super(key: key);
  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              )
            : const SizedBox.shrink(),
        0.5.h.ph,
        CustomContainer(
          boxShadow: [],
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          backgroundColor: Colors.grey.withOpacity(0.3),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }
}
