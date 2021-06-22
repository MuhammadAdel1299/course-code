import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/social_layout.dart';
import 'package:flutter_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:flutter_app/modules/social_app/social_register/social_register_screen.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              message: state.error.toString(),
              state: ToastState.ERROR,
            );
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
              key: "uId",
              value: state.uId,
            ).then((value) {
              navigateAndFinish(context , SocialLayout());
            });
          }
        },
        builder: (BuildContext context, state) {
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
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Colors.black,
                              ),
                          // TextStyle(
                          //   fontSize: 35.0,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
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
                              SocialLoginCubit.get(context).isPasswordShown,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        SizedBox(height: 30.0),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                // SocialLoginCubit.get(context).userLogin(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                // );
                              }
                            },
                            text: "login",
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
                              "Don\'t have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              child: Text(
                                'REGISTER NOW ',
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
