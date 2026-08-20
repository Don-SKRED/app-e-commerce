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
      debugPrint("ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = context.isMobile;
    var isTablet = Responsive.isTablet(context);
    var isDesktop = Responsive.isDesktop(context);
    debugPrint(" isMobile: ${isMobile.toString()}");
    debugPrint(" isTablet: ${isTablet.toString()}");
    debugPrint(" isDesktop: ${isDesktop.toString()}");
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              // spacing: 10,
              children: [
                //titre de la page
                Center(
                  child: Text(
                    titleLogin,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                //les inputs de login
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      spacing: 10,
                      children: [
                        CustomTextfield(
                          hintTextValue: hintTextUsername,
                          fontWeight: FontWeight.w300,
                          radius: 10,
                          labelText: labelTextUsername,
                          spacing: 5,
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
                          radius: 10,
                          labelText: labelTextEmail,
                          spacing: 5,
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
                          radius: 10,
                          labelText: labelTextPassword,
                          spacing: 5,
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
                          onPressedFunction: () {},
                          hintTextValue: hintTextConfirmPassword,
                          fontWeight: FontWeight.w300,
                          radius: 10,
                          labelText: labelTextConfirmPassword,
                          spacing: 5,
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
                  ),
                ),
                //Le bouton de connexion
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: validator,
                    child: Text(labelButton),
                  ),
                ),
                //Le bouton d'inscription sur "inscrivez-vous ici"
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vous avez déja un compte?"),
                      TextButton(onPressed: null, child: Text(textButtonValue)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
