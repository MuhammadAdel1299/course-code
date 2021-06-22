import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [
              defaultTextButton(
                function: () {

                  var now = DateTime.now();

                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                },
                text: "post",
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/doubtful-bearded-guy-crosses-hands-points-index-fingers-opposite-sides-has-difficulty-choosing-something-purses-lips-with-hesitation-wears-hoodie-isolated-yellow-wall_273609-42134.jpg'),
                      radius: 25.0,
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      "Muhammad Adel",
                      style: TextStyle(
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "what is on your mind ...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 160.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          IconBroken.Close_Square,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0),
                            Text("add photos"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text("# Tags"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
