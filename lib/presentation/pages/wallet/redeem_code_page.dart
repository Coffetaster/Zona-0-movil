import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RedeemCodePage extends StatelessWidget {
  const RedeemCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.canjear_codigo),
        centerTitle: false,
      ),
      body: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            CustomCard(
              padding: const EdgeInsets.all(8),
              child: Column(children: <Widget>[
                const SizedBox(height: 8),
                Text(AppLocalizations.of(context)!.entreCodigo,
                    style: context.titleMedium),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.canjear_codigo_content,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 10,
                  label: AppLocalizations.of(context)!.codigo,
                  // initialValue:
                  //     accountFormVerifyCodeSate.code.value,
                  // onFieldSubmitted: (_) {
                  //   if (accountFormVerifyCodeSate.formStatus !=
                  //       FormStatus.validating) {
                  //     onSubmit();
                  //   }
                  // },
                  // onChanged: ref
                  //     .read(accountFormVerifyCodeProvider
                  //         .notifier)
                  //     .codeChanged,
                  // errorMessage:
                  //     accountFormVerifyCodeSate.isFormDirty
                  //         ? accountFormVerifyCodeSate.code
                  //             .errorMessage(context)
                  //         : null,
                ),
                const SizedBox(height: 8),
              ]),
            ),
            const SizedBox(height: 16),
            CustomFilledButton(
              label: AppLocalizations.of(context)!.verificar,
              onPressed: () {
                Utils.showSnackbarEnDesarrollo(context);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(ImagesPath.happy_birthday.path,
                  width: double.infinity, height: context.height * .3),
            )
          ]),
        ),
      ),
    );
  }
}
