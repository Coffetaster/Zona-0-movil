import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/transfer/send_osp_form_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class SendOSPPage extends ConsumerStatefulWidget {
  const SendOSPPage({super.key});

  @override
  ConsumerState<SendOSPPage> createState() => _SendOSPPageState();
}

class _SendOSPPageState extends ConsumerState<SendOSPPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendOSPFormState = ref.watch(sendOSPFormProvider);

    void onSubmit() async {
      final code = await ref.read(sendOSPFormProvider.notifier).onSubmit();

      if (code != "200") {
        switch (code) {
          case "412":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.camposConError);
            break;
          case "498":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.compruebeConexion);
            break;
          default:
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: code.isEmpty
                    ? AppLocalizations.of(context)!.haOcurridoError
                    : code);
        }
      } else {
        Utils.showSnackbarEnDesarrollo(context);
        // context.pop();
        // SnackBarGI.showWithIcon(context,
        //     icon: Icons.check_outlined,
        //     text: AppLocalizations.of(context)!.reciboCreado);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.enviarOSP),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
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
                      AppLocalizations.of(context)!.enviarOSP_content,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 10,
                    suffixIcon: CustomIconButton(
                      icon: Icons.qr_code_scanner_outlined,
                      onPressed: () async {
                        String? result = await context
                            .push(RouterPath.UTILS_QR_SCANNER_PAGE);
                        if (result != null) {
                          _controller.value =
                              _controller.value.copyWith(text: result);
                        }
                      },
                    ),
                    label: AppLocalizations.of(context)!.codigo,
                    onFieldSubmitted: (_) {
                      if (sendOSPFormState.formStatus !=
                          FormStatus.validating) {
                        onSubmit();
                      }
                    },
                    onChanged:
                        ref.read(sendOSPFormProvider.notifier).codeChanged,
                    errorMessage: sendOSPFormState.isFormDirty
                        ? sendOSPFormState.code.errorMessage(context)
                        : null,
                  ),
                  const SizedBox(height: 8),
                ]),
              ),
              const SizedBox(height: 16),
              CustomFilledButton(
                label: AppLocalizations.of(context)!.verificar,
                onPressed: () {
                  onSubmit();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
