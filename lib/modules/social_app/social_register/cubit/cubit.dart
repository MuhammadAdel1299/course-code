import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/social_app/user_model.dart';
import 'package:flutter_app/modules/social_app/social_register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      usersCreate(name: name, email: email, phone: phone, uId: value.user.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void usersCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name : name,
      email: email,
      phone: phone,
      uId:uId,
      image:'https://image.freepik.com/free-vector/hand-drawn-workplace-home-top-view-person-sit-with-laptop-office-objects-stationery-home-plans-coffee_291916-37.jpg',
      cover:'https://image.freepik.com/free-vector/hand-drawn-workplace-home-top-view-person-sit-with-laptop-office-objects-stationery-home-plans-coffee_291916-37.jpg',
      bio: 'write your bio...',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;

    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
