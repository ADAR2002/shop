import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/data/model/search_model.dart';

import '../../constants/end_point.dart';
import '../../data/api/api_serveces.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  SearchedModel? searchModel;
  static SearchCubit get(context) => BlocProvider.of(context);

  void search({required String text}) {
    emit(SearchLoading());

    ApiServes.postData(url: SEARCH, data: {
      'text': text,
    }).then((req) {
      //  print(req);
      final data = json.decode(req.toString()) as Map<String, dynamic>;
      searchModel = SearchedModel.fromJson(data);
      print(searchModel!.data);
      emit(SearchSuccess());
    }).catchError((error) {
      emit(SearchError());
    });
  }
}
