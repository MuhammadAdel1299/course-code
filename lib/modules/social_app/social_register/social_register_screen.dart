import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/social_layout.dart';
import 'package:flutter_app/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:flutter_app/modules/social_app/social_register/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit , SocialRegisterStates>(
        listener: (context , state){
          if (state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          "Register now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          prefix: Icons.person,
                          label: "User Name",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          prefix: Icons.email_outlined,
                          label: "Email Address",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outline,
                          label: "Password",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          isPassword:
                          SocialRegisterCubit.get(context).isPasswordShown,
                          onSubmit: (value) {
                          },
                          suffix: SocialRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                          label: "Phone Number",
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is !SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text
                                );
                              }
                            },
                            text: "register",
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialLoginScreen());
                              },
                              child: Text(
                                'LOGIN ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
