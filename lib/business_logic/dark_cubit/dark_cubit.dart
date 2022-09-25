import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/sheard_pref/sheard_pref.dart';

part 'dark_state.dart';

class DarkCubit extends Cubit<DarkState> {
  DarkCubit() : super(DarkInitial());

  static DarkCubit get(context) => BlocProvider.of(context);
  bool isDark = true;

  void onChangedMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppThemeMode());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark);
      emit(AppThemeMode());
    }
  }
}
