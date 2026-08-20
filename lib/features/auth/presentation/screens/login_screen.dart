import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  String titleLogin = "Connexion";
  String textButtonValue = "Connectez-vous";
  String hintTextEmail = "Ruddy@gmail.com";
  String labelTextEmail = "Email";
  String hintTextPassword = "********";
  String labelTextPassword = "Mot de passe";
  String labelButton = "Se connecter";
  String? email;
  String? password;
  var formKey = GlobalKey<FormState>();

  void validator() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.padding),
          child: Form(
            key: formKey,
            child: Center(
              child: SizedBox(
                width: context.formWidth,
                child: Column(
                  spacing: context.spacing,
                  children: [
                    //titre de la page
                    SizedBox(
                      height: context.buttonHeight,
                      width: context.formWidth,
                      child: Center(
                        child: Text(
                          titleLogin,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.titleFontSize,
                          ),
                        ),
                      ),
                    ),

                    //les inputs de login
                    CustomTextfield(
                      hintTextValue: hintTextEmail,
                      fontWeight: FontWeight.w300,
                      radius: context.radius,
                      labelText: labelTextEmail,
                      spacing: context.fieldSpacing,
                      onSavedFunction: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validatorFunction: (value) {
                        if (value! == "" || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        if (!value.contains('@')) {
                          return "Format email invalide";
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      showPassword: showPassword,
                      isFieldPassword: true,
                      onPressedFunction: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      onSavedFunction: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      hintTextValue: hintTextPassword,
                      fontWeight: FontWeight.w300,
                      radius: context.radius,
                      labelText: labelTextPassword,
                      spacing: context.fieldSpacing,
                      validatorFunction: (value) {
                        if (value! == "" || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                    ),

                    //Le bouton de connexion
                    SizedBox(
                      height: context.buttonHeight,
                      width: context.formWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: validator,
                        child: Text(
                          labelButton,
                          style: TextStyle(fontSize: context.bodyFontSize),
                        ),
                      ),
                    ),

                    //Le bouton d'inscription sur "inscrivez-vous ici"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pas de compte?",
                          style: TextStyle(fontSize: context.bodyFontSize),
                        ),
                        TextButton(
                          onPressed: () => context.push("/signup"),
                          child: Text(
                            "Inscrivez-vous ici",
                            style: TextStyle(fontSize: context.bodyFontSize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
