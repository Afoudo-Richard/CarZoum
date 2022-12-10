import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:carzoum/app.dart';
import 'package:carzoum/src/data/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // use for internationalization checkout: https://pub.dev/packages/easy_localization
  await EasyLocalization.ensureInitialized();
  initializeAwesomeNotification();
  await registerParseServer();
  requestForNotificationPermission();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const App(),
    )),
    storage: storage,
  );
}

registerParseServer() async {
  const keyApplicationId = 'Fg22Ebem2NQ53vltcN7psGw7IJ4ahn4g7m1mHQWN';
  const keyClientKey = 'fb2jMYFRVNd1ZczVQPKnHnCf4RYvjSOeIz3baFKI';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true, // When enabled, prints logs to console
    // liveQueryUrl: keyLiveQueryUrl, // Required if using LiveQuery
    autoSendSessionId: true, // Required for authentication and ACL
    // securityContext: securityContext, // Again, required for some setups
  );

  ParseCoreData().registerUserSubClass(
    (username, password, emailAddress, {client, debug, sessionToken}) => User(
      username: username,
      password: password,
      email: emailAddress,
    ),
  );

  ParseCoreData().registerSubClass(Vehicle.keyTableName, () => Vehicle());
  ParseCoreData().registerSubClass(Brand.keyTableName, () => Brand());
  ParseCoreData()
      .registerSubClass(ConditionType.keyTableName, () => ConditionType());
  ParseCoreData().registerSubClass(FuelType.keyTableName, () => FuelType());
  ParseCoreData().registerSubClass(Model.keyTableName, () => Model());
  ParseCoreData().registerSubClass(
      TransmissionType.keyTableName, () => TransmissionType());
  ParseCoreData().registerSubClass(Store.keyTableName, () => Store());
}

void initializeAwesomeNotification() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );
}

void requestForNotificationPermission() {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
