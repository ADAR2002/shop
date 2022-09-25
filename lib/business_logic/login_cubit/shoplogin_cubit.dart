import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/end_point.dart';
import '../../data/api/api_serveces.dart';
import '../../data/model/login_model.dart';

part 'shoplogin_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitial());
  late LoginModel loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoading());

    ApiServes.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((req) {
      //  print(req);
      final data = json.decode(req.toString()) as Map<String, dynamic>;

      loginModel = LoginModel.fromJson(data);
      emit(ShopLoginSuccess(loginModel));
    }).catchError((error) {
      // print(error);
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
