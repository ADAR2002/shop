import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logic/search_cubit/search_cubit.dart';
import 'package:shop/view/widgets/conaitionalbuilder.dart';
import 'package:shop/view/widgets/mytextfailed.dart';

import '../../widgets/mylist.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
        create: ((context) => SearchCubit()),
        child: BlocConsumer<SearchCubit, SearchState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                  MyTextFailed(
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          SearchCubit.get(context)
                              .search(text: textController.text);
                        },
                      ),
                      label: "Search",
                      controller: textController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return " You don't searched ";
                        }
                        return null;
                      },
                      isPassword: false),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is SearchLoading)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SearchCubit.get(context).searchModel != null)
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 1,
                        ),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data
                            .data
                            .length,
                        itemBuilder: (BuildContext context, int index) =>
                            MyList(
                          product: SearchCubit.get(context)
                              .searchModel!
                              .data
                              .data[index],
                          isSearch: true,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              );
            },
            listener: (context, state) {}));
  }
}
