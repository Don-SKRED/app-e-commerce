import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/features/auth/presentation/widget/custom_textfield.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  bool obscureConfirmPassword = true;
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();
  static const String titleLogin = "Inscription";
  static const String textButtonValue = "Connectez-vous";
  static const String hintTextUsername = "Skred";
  static const String labelTextUsername = "Nom d'utilisateur";
  static const String hintTextEmail = "Ruddy@gmail.com";
  static const String labelTextEmail = "Email";
  static const String hintTextPassword = "********";
  static const String labelTextPassword = "Mot de passe";
  static const String hintTextConfirmPassword = "*********";
  static const String labelTextConfirmPassword = "Confirme le mot de passe";
  static const String labelButton = "S'inscrire";
  static const String messageResultSignUp = "Utilisateur créé";
  String? emailValue;
  String? usernameValue;
  String? passwordvalue;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    ref
        .read(authControllerProvider.notifier)
        .signup(usernameValue!, emailValue!, passwordvalue!);
  }

  @override
  Widget build(BuildContext context) {
    // On écoute l'état pour réagir une seule fois par changement
    // (SnackBar + retour au login), au lieu de le faire dans onPressed
    // sans attendre la fin de l'opération asynchrone.
    ref.listen<AsyncValue<dynamic>>(authControllerProvider, (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      if (!wasLoading) return; // on ne réagit qu'à la fin d'une tentative

      final messenger = ScaffoldMessenger.of(context);
      next.when(
        data: (user) {
          messenger.showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromARGB(255, 0, 175, 17),
              content: Text(
                messageResultSignUp,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
          // On ne quitte l'écran qu'après le succès confirmé du signup.
          if (context.canPop()) context.pop();
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Center(
              child: SizedBox(
                width: context.formWidth,
                child: Column(
                  spacing: context.spacing,
                  children: [
                    Text(
                      titleLogin,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.titleFontSize,
                      ),
                    ),

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
                            if (value == null || value.isEmpty) {
                              return "Veuillez remplir ce champ";
                            }
                            if (value.length < 5) return "Nom trop court";
                            return null;
                          },
                          onSavedFunction: (value) => usernameValue = value,
                        ),
                        CustomTextfield(
                          hintTextValue: hintTextEmail,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextEmail,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez remplir ce champ";
                            }
                            if (!value.contains('@')) {
                              return "Format email invalide";
                            }
                            return null;
                          },
                          onSavedFunction: (value) => emailValue = value,
                        ),
                        CustomTextfield(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          isFieldPassword: true,
                          onPressedFunction: () {
                            setState(() => obscurePassword = !obscurePassword);
                          },
                          onSavedFunction: (value) => passwordvalue = value,
                          hintTextValue: hintTextPassword,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextPassword,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value == null || value.isEmpty) {
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
                          obscureText: obscureConfirmPassword,
                          isFieldPassword: true,
                          onPressedFunction: () {
                            setState(() {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            });
                          },
                          hintTextValue: hintTextConfirmPassword,
                          fontWeight: FontWeight.w300,
                          radius: context.radius,
                          labelText: labelTextConfirmPassword,
                          spacing: context.fieldSpacing,
                          validatorFunction: (value) {
                            if (value == null || value.isEmpty) {
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
                          onSavedFunction: (value) {},
                        ),
                      ],
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

                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Vous avez déjà un compte?",
                          style: TextStyle(fontSize: context.bodyFontSize),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
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
