
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/router/router.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/l10n/l10n.dart';
import 'package:zona0_apk/presentation/providers/language/locale_provider.dart';

//* cambio de idioma
//? Nota: este archivo se genera luego de compilar
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zona0_apk/presentation/providers/theme/theme_provider.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
Instalar en dependencias
animate_do, dio, flutter_riverpod, go_router, intl, cached_network_image

Para cambiar de lenguaje: /////////////////////////////
+En el archivo: pubspec.yaml
-Poner en dependencias
flutter_localizations:
    sdk: flutter

-Poner en flutter
  generate: true

+Crear archivo: l10n.yaml
-Copiar dentro:
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

//////////////////////////////////////////////////

En caso de pedir permisos: permission_handler

En caso de usar map: flutter_osm_plugin

Variables de entorno: flutter_dotenv

Para isar db:
  dependencias: isar, isar_flutter_libs, path_provider
  dev dependencias: build_runner, isar_generator

Para paginar listas: fl_paging (probar)

*/

void main() async {

  //para poner la apk potrait
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //para saltarse protocolos de red
  // HttpOverrides.global = MyHttpOverrides();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final locale = ref.watch(localeProvider);
        final theme = ref.watch(themeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Zona 0',
          theme: AppTheme(isDark: theme.isDark).theme(),
          darkTheme: AppTheme().themeDark(),
          themeMode: ThemeMode.system,
          routerConfig: appRouter,

          //para el idioma
          locale: locale.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
