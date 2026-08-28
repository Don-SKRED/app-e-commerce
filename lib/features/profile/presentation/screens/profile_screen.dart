import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/shared/services/theme_provider.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final user = ref.watch(authControllerProvider).asData?.value;

    final avatarRadius = context.isDesktop
        ? 65.0
        : context.isTablet
        ? 55.0
        : 45.0;

    final avatarIconSize = context.isDesktop
        ? 55.0
        : context.isTablet
        ? 45.0
        : 35.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(context.padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.isDesktop
                    ? 650
                    : context.isTablet
                    ? 550
                    : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.spacing / 2),
                  // Avatar et infos utilisateur
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person,
                      size: avatarIconSize,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  SizedBox(height: context.spacing / 2),
                  Text(
                    user?.username ?? "Utilisateur",
                    style: TextStyle(
                      fontSize: context.titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (user?.email != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      user!.email,
                      style: TextStyle(
                        fontSize: context.bodyFontSize,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  SizedBox(height: context.spacing * 1.5),

                  // Liste d'options sous forme de cartes
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.radius),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            "Compte",
                            style: TextStyle(
                              fontSize: context.bodyFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "Voir toutes les informations vous concernant",
                            style: TextStyle(
                              fontSize: context.bodyFontSize - 2,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.push("/about");
                          },
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.color_lens_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          title: Text(
                            "Mode sombre",
                            style: TextStyle(
                              fontSize: context.bodyFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Switch(
                            value: themeMode == ThemeMode.dark,
                            onChanged: (value) {
                              ref
                                  .read(themeControllerProvider.notifier)
                                  .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                            },
                          ),
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          title: Text(
                            "Déconnexion",
                            style: TextStyle(
                              fontSize: context.bodyFontSize,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          subtitle: Text(
                            "Déconnecter votre compte de l'application",
                            style: TextStyle(
                              fontSize: context.bodyFontSize - 2,
                            ),
                          ),
                          onTap: () {
                            ref.read(authControllerProvider.notifier).logout();
                            context.go("/login");
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.spacing),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

