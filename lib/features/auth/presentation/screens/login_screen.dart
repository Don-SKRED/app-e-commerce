import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
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
          padding: const EdgeInsets.all(13.0),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 30,
              children: [
                //titre de la page
                SizedBox(
                  // color: Colors.blueAccent,
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: Center(
                    child: Text(
                      titleLogin,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),

                //les inputs de login
                CustomTextfield(
                  hintTextValue: hintTextEmail,
                  fontWeight: FontWeight.w300,
                  radius: 10,
                  labelText: labelTextEmail,
                  spacing: 5,
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
                  radius: 10,
                  labelText: labelTextPassword,
                  spacing: 5,
                  validatorFunction: (value) {
                    if (value! == "" || value.isEmpty) {
                      return "Veuillez remplir ce champ";
                    }

                    return null;
                  },
                ),

                //Le bouton de connexion
                SizedBox(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: validator,
                    child: Text(labelButton, style: TextStyle(fontSize: 15)),
                  ),
                ),
                //Le bouton d'inscription sur "inscrivez-vous ici"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pas de compte?"),
                    TextButton(
                      onPressed: () => context.push("/signup"),
                      child: Text("Inscrivez-vous ici"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
