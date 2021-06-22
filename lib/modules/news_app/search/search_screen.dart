import 'package:flutter/material.dart';
import 'package:flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:flutter_app/layout/news_app/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  prefix: Icons.search,
                  label: "Search",
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "Enter A word To Search For...";
                    }
                    return null;
                  },
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
