import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/models/social_app/post_model.dart';
import 'package:flutter_app/shared/styles/colors.dart';
import 'package:flutter_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 &&  SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/close-up-young-handsome-man-isolated_273609-35826.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10.0,
                  margin: EdgeInsets.all(8.0),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context , index) => buildPostItem(SocialCubit.get(context).posts[index] , context , index),
                  separatorBuilder: (context , index) => SizedBox(height: 8.0),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem (PostModel model , context , index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    '${model.image}',),
                radius: 25.0,
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${model.name}",
                          style: TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.check_circle,
                          size: 14.0,
                          color: defaultColor,
                        ),
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(height: 1.3),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 16.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1.0,
            ),
          ),
          Text(
            "${model.text}",
            style: TextStyle(height: 1.4),
          ),
          // Padding(
          //   padding: const EdgeInsetsDirectional.only (bottom: 10.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 10.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               onPressed: () {},
          //               child: Text(
          //                 "#Software",
          //                 style: Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               onPressed: () {},
          //               child: Text(
          //                 "#flutter",
          //                 style: Theme.of(context).textTheme.caption.copyWith(color: defaultColor),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '')
            Padding(
            padding: const EdgeInsets.only(top : 15.0),
            child: Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${model.postImage}',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0),
                          Text("${SocialCubit.get(context).likes[index]}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0),
                          Text("0 comment",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              color: Colors.grey[300],
              width: double.infinity,
              height: 1.0,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel.image}'),
                        radius: 18.0,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        "write a comment ...",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(IconBroken.Heart,
                      size: 16.0,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5.0),
                    Text("Like",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              )
            ],
          ),
        ],
      ),
    ),
  );
}
