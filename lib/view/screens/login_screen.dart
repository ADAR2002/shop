import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/login_cubit/shoplogin_cubit.dart';
import 'package:shop/constants/const.dart';
import 'package:shop/constants/namepage.dart';
import 'package:shop/data/sheard_pref/sheard_pref.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';
import 'package:shop/view/widgets/mybuttons.dart';
import 'package:shop/view/widgets/mytextfailed.dart';
import 'package:shop/view/widgets/toast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopLoginCubit>(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccess) {
            if (state.loginModel.status) {
              MyToast.showToast(
                  msg: state.loginModel.message!, color: Colors.green);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                Navigator.pushReplacementNamed(context, shopLayout);
              });
            } else {
              MyToast.showToast(
                  msg: state.loginModel.message!, color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "login now to browse our hot offers ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MyTextFailed(
                          isPassword: false,
                          validator: (String? email) {
                            if (email!.isEmpty || !email.contains('@')) {
                              return "Please enter your Email ";
                            }
                            return null;
                          },
                          label: "Email",
                          controller: emailController,
                          prefix: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFailed(
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          validator: (String? pass) {
                            if (pass!.isEmpty || (pass.length < 6)) {
                              return "Your password too weak ";
                            }
                            return null;
                          },
                          label: "Password",
                          controller: passwordController,
                          prefix: const Icon(Icons.password_outlined),
                          suffix: IconButton(
                            icon: Icon(ShopLoginCubit.get(context).icon),
                            onPressed: () =>
                                ShopLoginCubit.get(context).onChanged(),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          conditional: state is! ShopLoginLoading,
                          builder: (context) => MyButton1(
                              onTap: () {
                                bool isval = formKey.currentState!.validate();
                                if (isval) {
                                  BlocProvider.of<ShopLoginCubit>(context)
                                      .userLogin(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                }
                              },
                              label: "LOGIN"),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text("don't have an account?",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              width: 10,
                            ),
                            MyButton2(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, registerScreen);
                                },
                                label: 'REGISTER'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
