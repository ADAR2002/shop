import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/app_router.dart';
import 'package:shop/business_logic/shop_cubit/shop_cubit.dart';
import 'package:shop/constants/namepage.dart';
import 'package:shop/data/sheard_pref/sheard_pref.dart';
import 'package:shop/view/setting_ui/theme.dart';

import 'business_logic/dark_cubit/dark_cubit.dart';
import 'constants/const.dart';
import 'data/api/api_serveces.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  ApiServes.init();

  bool? onBoarding = CacheHelper.getData(key: 'onboarding');
  token = CacheHelper.getData(key: 'token');
  bool? isDark = CacheHelper.getData(key: 'isDark');
  String? homeScreen;

  if (onBoarding != null && onBoarding) {
    if (token != null && token!.isNotEmpty) {
      homeScreen = shopLayout;
    } else {
      homeScreen = loginScreen;
    }
  } else {
    homeScreen = pageViewScreen;
  }

  runApp(MyApp(
    homeScreen: homeScreen,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.homeScreen, required this.isDark})
      : super(key: key);
  final String homeScreen;
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DarkCubit>(
          create: (context) => DarkCubit()..onChangedMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getProfileUser(),
        ),
      ],
      child: BlocConsumer<DarkCubit, DarkState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: BlocProvider.of<DarkCubit>(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: darkTheme,
            onGenerateRoute: AppRouter().generatorRouter,
            initialRoute: homeScreen,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}
