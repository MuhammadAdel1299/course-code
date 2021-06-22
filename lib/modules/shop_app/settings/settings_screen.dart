import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_app/layout/shop_app/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var model = ShopCubit
            .get(context)
            .userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit
              .get(context)
              .userModel != null,
          builder: (context) =>
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateUserState)
                          LinearProgressIndicator(),
                        SizedBox(height: 20.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          label: "Name",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you have to enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                          label: "Email Address",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you have to enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          label: "Phone",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you have to enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        defaultButton(
                          function: () {
                            if(formKey.currentState.validate()){
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,);
                            }
                          },
                          text: "update your data",
                        ),
                        SizedBox(height: 20.0),
                        defaultButton(
                          function: () {
                            signOut(context);
                          },
                          text: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
