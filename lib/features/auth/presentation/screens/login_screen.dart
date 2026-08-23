import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
import 'package:app_e_commerce/features/exceptions/auth_exception.dart';
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
  static const String titleLogin = "Connexion";
  // static const String textButtonValue = "Connectez-vous";
  static const String hintTextEmail = "Ruddy@gmail.com";
  static const String labelTextEmail = "Email";
  static const String hintTextPassword = "********";
  static const String labelTextPassword = "Mot de passe";
  static const String labelButton = "Se connecter";
  static const String messageResultLogin = "Connexion réussie";
  String? email;
  String? password;
  var formKey = GlobalKey<FormState>();
  var authDataRepository = AuthDataRepository();

  Future validator(ScaffoldMessengerState messenger) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await authDataRepository.login(email!, password!);
        messenger.showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 0, 175, 17),
            content: Text(
              messageResultLogin,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } on AuthException catch (e) {
        messenger.showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(255, 175, 158, 0),
            content: Text(
              e.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
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
                        onPressed: () {
                          if (!context.mounted) return;
                          validator(ScaffoldMessenger.of(context));
                        },
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
