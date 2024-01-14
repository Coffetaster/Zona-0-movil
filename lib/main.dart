
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

void main() async {

  //para preservar el splash y removerlo cuando yo quiera
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FlutterNativeSplash.remove();

  //para poner la apk potrait
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //* cargar todo el enviroment
  await dotenv.load(fileName: ".env");

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
          title: 'Orca Store',
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
