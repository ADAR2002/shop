import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/dark_cubit/dark_cubit.dart';
import 'package:shop/business_logic/shop_cubit/shop_cubit.dart';
import 'package:shop/constants/namepage.dart';
import 'package:shop/data/sheard_pref/sheard_pref.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';
import 'package:shop/view/widgets/mybuttons.dart';
import 'package:shop/view/widgets/mytextfailed.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = DarkCubit.get(context);
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            conditional: ShopCubit.get(context).profileUser != null,
            fallback: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildButtonDarkMode(cubit, context),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No Internet",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ]),
            builder: (context) {
              final profileUser = ShopCubit.get(context).profileUser;
              nameController.text = profileUser!.data!.name;
              emailController.text = profileUser.data!.email;
              phoneController.text = profileUser.data!.phone;

              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildButtonDarkMode(cubit, context),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is ShopUpDateLoadingProfile)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 8,
                      ),
                      MyTextFailed(
                        label: 'Name',
                        controller: nameController,
                        validator: (val) {
                          if (val == null && val!.isEmpty) {
                            return "Your name is empty";
                          }
                          return null;
                        },
                        isPassword: false,
                        prefix: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFailed(
                        label: 'email',
                        controller: emailController,
                        validator: (val) {
                          if (val == null && val!.isEmpty) {
                            return "Your email is empty";
                          }
                          return null;
                        },
                        isPassword: false,
                        prefix: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFailed(
                        label: 'Phone',
                        controller: phoneController,
                        validator: (val) {
                          if (val == null && val!.isEmpty) {
                            return "Your Phone is empty";
                          }
                          return null;
                        },
                        isPassword: false,
                        prefix: const Icon(Icons.phone),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton1(
                          onTap: () {
                            ShopCubit.get(context).updateProfileUser(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          },
                          label: "UPDATE"),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton1(
                          onTap: () {
                            CacheHelper.clearData(kay: 'token').then((value) {
                              Navigator.pushReplacementNamed(
                                  context, loginScreen);
                            });
                          },
                          label: "LOGOUT")
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Row buildButtonDarkMode(DarkCubit cubit, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          cubit.isDark ? 'Light Mode' : 'Dark Mode',
          style: Theme.of(context).textTheme.headline6,
        ),
        IconButton(
            onPressed: () {
              cubit.onChangedMode();
            },
            icon: Icon(cubit.isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined))
      ],
    );
  }
}
