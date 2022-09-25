

part of 'register_cubit.dart';




abstract class ShopRegisterState {}

class ShopRegisterInitial extends ShopRegisterState {}

class ShopRegisterLoading extends ShopRegisterState {}

class ShopRegisterSuccess extends ShopRegisterState {
  final LoginModel loginModel;

  ShopRegisterSuccess(this.loginModel);

}

class ShopRegisterError extends ShopRegisterState {
  final String error;

  ShopRegisterError(this.error);
}

class IconsPasswordChanged extends ShopRegisterState {}
