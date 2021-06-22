import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_app/layout/shop_app/cubit/states.dart';
import 'package:flutter_app/models/shop_app/favorites_model.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context , index) => buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product , context),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
