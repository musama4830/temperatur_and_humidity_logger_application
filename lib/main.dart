import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/home_page_screen.dart';
import './screens/settings_screen.dart';
import './widgets/select_device.dart';
import './widgets/select_internet.dart';
import '../providers/items_provider.dart';
import '../providers/setting_options_provider.dart';

import '../helper/colors.dart' as color;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ItemssProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SettingOptionsProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: color.AppColor.pageTitleFirstColor),
                bodyText2: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    color: color.AppColor.pageTitleSecondColor)),
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color.AppColor.pageTitleFirstColor)),
          ),
          home: const HomePageScreen(),
          routes: {
            '/select_device': (ctx) => SelectDevice(),
            '/select_internet': (ctx) => SelectInternet(),
            '/setting_screen': (ctx) => SettingsScreen(),
          }),
    );
  }
}
