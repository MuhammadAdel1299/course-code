import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/models/social_app/user_model.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).users [index]),
            separatorBuilder: (context , index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem (SocialUserModel model) => InkWell(
    onTap: (){},
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
            '${model.image}'  ,
            ),
            radius: 25.0,
          ),
          SizedBox(width: 15.0),
          Text(
            '${model.name}' ,
            style: TextStyle(
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
