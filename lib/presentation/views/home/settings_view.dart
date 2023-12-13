import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/providers/theme/theme_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: PageScrollPhysics(),
      // physics: BouncingScrollPhysics(),
      // physics: ClampingScrollPhysics(),
      child: FadeInUp(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),

                //* Perfil
                CustomTitle(AppLocalizations.of(context)!.miPerfil),
                const SizedBox(
                  height: 10,
                ),
                AppTheme.isLogin
                ? profileBloc()
                : const NoLoginAlert(),
                const SizedBox(
                  height: 30,
                ),

                //* Ajustes
                CustomTitle(AppLocalizations.of(context)!.ajustes),
                const SizedBox(
                  height: 10,
                ),
                // settingsBloc(),
                settingsBloc2(),
                const SizedBox(
                  height: 30,
                ),

                //* Info
                CustomTitle(AppLocalizations.of(context)!.informacion),
                const SizedBox(
                  height: 10,
                ),
                infoBloc(),
                infoBloc2(),
                // const SizedBox(
                //   height: 30,
                // ),

                // //* Cuenta
                // CustomTitle("Cuenta"),
                // const SizedBox(
                //   height: 10,
                // ),
                // acountBloc(),
                // acountBloc2(),

                const SizedBox(
                  height: 80,
                ),
              ],
            )),
      ),
    );
  }

  Widget profileBloc() => CustomGradientCard(
        padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundImage:
                            AssetImage('assets/imagen/avatar.jpg'),
                      ),
                      const SizedBox(width: 8),
                      // Text("Hola, "),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('John Doe',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('johndoe@correo.com',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const Divider(thickness: 1, height: 20),
              CustomCard(
                child: SettingOption(
                  icon: Icons.edit_outlined,
                  title: AppLocalizations.of(context)!.editarDatos,
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  onTap: () {},
                ),
              ),
          
              acountBloc(),
              acountBloc2(),
          
              // SizedBox(
              //   width: double.infinity,
              //   child: CustomFilledButton(
              //     label: "Editar datos",
              //     filledButtonType: FilledButtonType.tonal,
              //     icon: Icons.edit_outlined,
              //     onPressed: () {},
              //   ),
              // )
            ],
          ));

  Widget settingsBloc() => CustomCard(
          child: Column(
        children: <Widget>[
          SettingOption(
            icon: Icons.sync_outlined,
            title: AppLocalizations.of(context)!.cambiarContrasena,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
          const Divider(thickness: 1, height: 1),
          SettingOption(
            icon: Icons.logout_outlined,
            title: AppLocalizations.of(context)!.logout,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
        ],
      ));

  Widget settingsBloc2() => CustomCard(
          child: Column(
        children: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              final theme = ref.watch(themeProvider);
              return SettingOption(
                icon: Icons.dark_mode_outlined,
                title: AppLocalizations.of(context)!.modoOscuro,
                subtitle: theme.isDark ? AppLocalizations.of(context)!.cambiarClaro : AppLocalizations.of(context)!.cambiarOscuro,
                trailing: Switch(
                    value: theme.isDark,
                    onChanged: (value) => ref.read(themeProvider.notifier).toggleDark()),
                onTap: () => ref.read(themeProvider.notifier).toggleDark(),
              );
            },
          ),
        ],
      ));

  Widget infoBloc() => CustomCard(
          child: Column(
        children: <Widget>[
          SettingOption(
            icon: Icons.contact_support_outlined,
            title: AppLocalizations.of(context)!.sobreNosotros,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
          const Divider(thickness: 1, height: 1),
          SettingOption(
            icon: Icons.info_outline,
            title: AppLocalizations.of(context)!.acercaDe,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
        ],
      ));

  Widget infoBloc2() => CustomCard(
          child: Column(
        children: <Widget>[
          SettingOption(
            icon: Icons.chat_bubble_outline,
            title: AppLocalizations.of(context)!.enviarComentarios,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
        ],
      ));

  Widget acountBloc() => CustomCard(
          child: Column(
        children: <Widget>[
          SettingOption(
            icon: Icons.sync_outlined,
            title: AppLocalizations.of(context)!.cambiarContrasena,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
          const Divider(thickness: 1, height: 1),
          SettingOption(
            icon: Icons.logout_outlined,
            title: AppLocalizations.of(context)!.logout,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
        ],
      ));

  Widget acountBloc2() => CustomCard(
          child: Column(
        children: <Widget>[
          SettingOption(
            icon: Icons.delete_outline,
            title: AppLocalizations.of(context)!.eliminar,
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {},
          ),
        ],
      ));

  @override
  bool get wantKeepAlive => true;
}
