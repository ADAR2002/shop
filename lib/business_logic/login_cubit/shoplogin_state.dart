part of 'shoplogin_cubit.dart';


abstract class ShopLoginState {}

class ShopLoginInitial extends ShopLoginState {}

class ShopLoginLoading extends ShopLoginState {}

class ShopLoginSuccess extends ShopLoginState {
  final LoginModel loginModel;
  ShopLoginSuccess(this.loginModel);
}

class ShopLoginError extends ShopLoginState {}

class IconsPasswordChanged extends ShopLoginState {}
