import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool obscurePassword = true;
  static const String titleLogin = "Connexion";
  static const String hintTextEmail = "Ruddy@gmail.com";
  static const String labelTextEmail = "Email";
  static const String hintTextPassword = "********";
  static const String labelTextPassword = "Mot de passe";
  static const String labelButton = "Se connecter";
  static const String messageResultLogin = "Connexion réussie";
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();

  void _submit() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    ref.read(authControllerProvider.notifier).login(email!, password!);
  }

  @override
  Widget build(BuildContext context) {
    // On écoute les changements d'état pour afficher les SnackBars et
    // naviguer, sans reconstruire tout l'écran à chaque frame.
    ref.listen<AsyncValue<dynamic>>(authControllerProvider, (previous, next) {
      final messenger = ScaffoldMessenger.of(context);
      next.when(
        data: (user) {
          if (user == null) return; // état initial, rien à faire
          messenger.showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 0, 175, 17),
              content: Text(
                messageResultLogin,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
          // TODO: rediriger vers l'écran d'accueil une fois qu'il existera,
          // ex: context.go('/home');
        },
        loading: () {},
        error: (error, stack) {
          messenger.showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 175, 158, 0),
              content: Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      );
    });

    final isLoading = ref.watch(authControllerProvider).isLoading;

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

                    CustomTextfield(
                      hintTextValue: hintTextEmail,
                      fontWeight: FontWeight.w300,
                      radius: context.radius,
                      labelText: labelTextEmail,
                      spacing: context.fieldSpacing,
                      onSavedFunction: (value) => email = value,
                      validatorFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        if (!value.contains('@')) {
                          return "Format email invalide";
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      obscureText: obscurePassword,
                      isFieldPassword: true,
                      onPressedFunction: () {
                        setState(() => obscurePassword = !obscurePassword);
                      },
                      onSavedFunction: (value) => password = value,
                      hintTextValue: hintTextPassword,
                      fontWeight: FontWeight.w300,
                      radius: context.radius,
                      labelText: labelTextPassword,
                      spacing: context.fieldSpacing,
                      validatorFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez remplir ce champ";
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: context.buttonHeight,
                      width: context.formWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                labelButton,
                                style: TextStyle(
                                  fontSize: context.bodyFontSize,
                                ),
                              ),
                      ),
                    ),

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
