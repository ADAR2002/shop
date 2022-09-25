import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/end_point.dart';
import '../../data/api/api_serveces.dart';
import '../../data/model/login_model.dart';

part 'register_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitial());
  late LoginModel registerModel;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoading());

    ApiServes.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((req) {
      //  print(req);
      final data = json.decode(req.toString()) as Map<String, dynamic>;

      registerModel = LoginModel.fromJson(data);
      emit(ShopRegisterSuccess(registerModel));
    }).catchError((error) {
      // print(error);
      emit(ShopRegisterError(error));
    });
  }

  bool isPassword = false;
  IconData icon = Icons.visibility_off_outlined;
  void onChanged() {
    isPassword = !isPassword;
    icon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(IconsPasswordChanged());
  }
}
