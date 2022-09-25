import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/register_cubit/register_cubit.dart';

import '../../constants/const.dart';
import '../../constants/namepage.dart';
import '../../data/sheard_pref/sheard_pref.dart';
import '../widgets/conaitionalbuilder.dart';
import '../widgets/mybuttons.dart';
import '../widgets/mytextfailed.dart';
import '../widgets/toast.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopRegisterCubit>(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccess) {
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
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "REGISTER now to browse our hot offers ",
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
                          validator: (name) {
                            if (name!.isEmpty || name.length < 3) {
                              return "Please enter your Name ";
                            }
                            return null;
                          },
                          label: "Name",
                          controller: nameController,
                          prefix: const Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 15,
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
                          isPassword: false,
                          validator: (phone) {
                            if (phone!.isEmpty || phone.length <= 9) {
                              return "Please enter your phone ";
                            }
                            return null;
                          },
                          label: "Phone",
                          controller: phoneController,
                          prefix: const Icon(Icons.phone),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFailed(
                          isPassword:ShopRegisterCubit.get(context).isPassword,
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
                            icon: Icon(ShopRegisterCubit.get(context).icon),
                            onPressed: () =>
                                ShopRegisterCubit.get(context).onChanged(),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          conditional: state is! ShopRegisterLoading,
                          builder: (context) => MyButton1(
                              onTap: () {
                                bool isval = formKey.currentState!.validate();
                                if (isval) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              label: "REGISTER"),
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
                            Text("Do you have an account?",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(
                              width: 10,
                            ),
                            MyButton2(onPressed: () {Navigator.pushReplacementNamed(context, loginScreen); }, label: 'LOGIN'),
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
