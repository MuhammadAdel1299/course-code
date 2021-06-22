import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_app/layout/shop_app/cubit/states.dart';
import 'package:flutter_app/layout/shop_app/shop_layout.dart';
import 'package:flutter_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:flutter_app/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_app/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context , state){
          if (state is ShopRegisterSuccessState)
          {
            if (state.loginModel.status)
            {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context , ShopLayout());
              });
            } else
            {
              showToast(
                message: state.loginModel.message,
                state: ToastState.ERROR,
              );
            }
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
                          "Register now to browse out hot offers",
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
                          ShopRegisterCubit.get(context).isPasswordShown,
                          onSubmit: (value) {
                          },
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
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
                          condition: state is !ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
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
                                navigateTo(context, ShopLoginScreen());
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
