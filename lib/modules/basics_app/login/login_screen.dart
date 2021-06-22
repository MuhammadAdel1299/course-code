import 'package:flutter/material.dart';
import 'package:flutter_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  prefix: Icons.email,
                  label: "E-Mail Address",
                  validate: (String value){
                    if(value.isEmpty || !value.contains('@')){
                      return 'Enter A Valid Email';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 15),
                defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock_rounded,
                    label: "Password",
                    validate: (String value){
                      if(value.isEmpty ){
                        return 'You Must Enter A Password';
                      }
                      return null;
                    },
                  isPassword: isPassword,
                  suffix:  isPassword ? Icons.remove_red_eye : Icons.visibility_off,
                  suffixPressed: (){
                      setState(() {
                        isPassword = !isPassword;
                      });
                  }
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t Have An Account ?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Register Now.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
