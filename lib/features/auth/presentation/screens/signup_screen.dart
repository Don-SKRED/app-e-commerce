import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showConfirmPassword = true;
  bool showPassword = true;
  var formKey = GlobalKey<FormState>();
  String titleLogin = "Inscription";
  String textButtonValue = "Connectez-vous";
  String hintTextUsername = "Skred";
  String labelTextUsername = "Nom d'utilisateur";
  String hintTextEmail = "Ruddy@gmail.com";
  String labelTextEmail = "Email";
  String hintTextPassword = "********";
  String labelTextPassword = "Mot de passe";
  String hintTextConfirmPassword = "*********";
  String labelTextConfirmPassword = "Confirme le mot de passe";
  String labelButton = "S'inscrire";
  String? emailValue;
  String? usernameValue;
  String? passwordvalue;
  String? confirmPasswordvalue;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Center(
              child: SizedBox(
                width: context.formWidth,
                child: Column(
                  spacing: context.spacing,
                  children: [
                    //titre de la page
                    Text(
                      titleLogin,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.titleFontSize,
                      ),
                    ),

                    //les inputs d'inscription
                    Column(
                      spacing: context.fieldSpacing * 2,
                      children: [
                        CustomTextfield(
                          hintTextValue: hintTextUsername,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextUsername,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value! == "" || value.isEmpty) {
                              return "Veuillez remplir ce champ";
                            }
                            if (value.length < 5) return "Nom trop court";
                            return null;
                          },
                          onSavedFunction: (value) {
                            setState(() {
                              usernameValue = value;
                            });
                          },
                        ),
                        CustomTextfield(
                          hintTextValue: hintTextEmail,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextEmail,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value! == "" || value.isEmpty) {
                              return "Veuillez remplir ce champ";
                            }
                            if (!value.contains('@')) {
                              return "Format email invalide";
                            }
                            return null;
                          },
                          onSavedFunction: (value) {
                            setState(() {
                              emailValue = value;
                            });
                          },
                        ),
                        CustomTextfield(
                          controller: passwordController,
                          showPassword: showPassword,
                          isFieldPassword: true,
                          onPressedFunction: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          onSavedFunction: (value) {
                            setState(() {
                              passwordvalue = value;
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
                            if (value.length < 8) {
                              return "Mot de passe trop court";
                            }
                            return null;
                          },
                        ),
                        CustomTextfield(
                          controller: confirmPasswordController,
                          showPassword: showConfirmPassword,
                          isFieldPassword: true,
                          onPressedFunction: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                          hintTextValue: hintTextConfirmPassword,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextConfirmPassword,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value! == "" || value.isEmpty) {
                              return "Veuillez remplir ce champ";
                            }
                            if (value.length < 8) {
                              return "Mot de passe trop court";
                            }
                            if (passwordController.value.text != value) {
                              return "le mot de passe ne se ressemble pas";
                            }
                            return null;
                          },
                          onSavedFunction: (value) {
                            setState(() {
                              confirmPasswordvalue = value;
                            });
                          },
                        ),
                      ],
                    ),

                    //Le bouton d'inscription
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

                    //Lien vers le login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous avez déjà un compte?",
                          style: TextStyle(fontSize: context.bodyFontSize),
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text(
                            textButtonValue,
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
