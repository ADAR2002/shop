import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/shop_cubit/shop_cubit.dart';
import 'package:shop/constants/namepage.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Salla"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, searchScreen);
                  },
                  icon: const Icon(Icons.search_outlined))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changedScreenInBottomNav(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_max_outlined,
                    ),
                    label: "Products"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined), label: "Category"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: "Favorites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_applications_outlined),
                    label: "Settings"),
              ]),
        );
      },
    );
  }
}
