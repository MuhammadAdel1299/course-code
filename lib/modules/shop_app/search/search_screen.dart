import 'package:flutter/material.dart';
import 'package:flutter_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter_app/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Search"),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        prefix: Icons.search,
                        label: "Search",
                        validate: (String value) {
                          if (formKey.currentState.validate()) {
                            if (value.isEmpty) {
                              return 'Enter word to search for....';
                            }
                            return null;
                          }
                        },
                        onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                        }
                    ),
                    SizedBox(height: 10),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index) => buildListProduct(SearchCubit.get(context).model.data.data[index], context, isOldPrice: false),
                        separatorBuilder: (context , index) => myDivider(),
                        itemCount: SearchCubit.get(context).model.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
