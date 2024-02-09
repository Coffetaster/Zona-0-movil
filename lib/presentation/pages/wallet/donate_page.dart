import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';

import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.donar),
        centerTitle: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final institutionsState = ref.watch(institutionsProvider);
          if (institutionsState.isLoading) {
            return ZoomIn(
                child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: LoadingPage()));
          }
          if (institutionsState.institutionsList.isEmpty) {
            return ZoomIn(
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImagesPath.no_data.path,
                            width: context.width * .75,
                            height: context.width * .75,
                            fit: BoxFit.contain),
                        const SizedBox(height: 8),
                        Text(
                            AppLocalizations.of(context)!
                                .noExistenInstituciones,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall),
                      ],
                    )));
          }
          return FadeInUp(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: institutionsState.institutionsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: InstitutionItem(institution: institutionsState.institutionsList[index]),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
