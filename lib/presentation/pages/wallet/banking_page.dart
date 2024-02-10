import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/banking/banking_form_provider.dart';
import 'package:zona0_apk/presentation/providers/banking/banking_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class BankingPage extends StatelessWidget {
  BankingPage({super.key});

  final AnimatedListGIController<Deposit> _controllerDepositsList =
      AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bancarizar),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const BankingFormView(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTitle(AppLocalizations.of(context)!.depositos),
                      Consumer(
                        builder: (context, ref, child) {
                          return CustomIconButton(
                              icon: Icons.refresh_outlined,
                              onPressed: () {
                                ref
                                    .read(bankingProvider.notifier)
                                    .getDeposits();
                              });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, ref, child) {
                      final bankingState = ref.watch(bankingProvider);
                      return CustomCard(
                          padding: const EdgeInsets.all(8),
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              child: bankingState.isLoading
                                  ? const SizedBox(
                                      width: double.infinity,
                                      height: 300,
                                      child: LoadingLogo())
                                  : bankingState.deposits.isEmpty
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: 300,
                                          child: Center(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .noDepositos)),
                                        )
                                      : AnimatedListGIWidget<Deposit>(
                                          items: bankingState.deposits,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: _controllerDepositsList,
                                          builder: (context, index) =>
                                              DepositItem(
                                                  deposit: bankingState
                                                      .deposits[index]))));
                    },
                  ),
                  const SizedBox(height: 20),
                ]),
          ),
        ),
      ),
    );
  }
}

class BankingFormView extends ConsumerWidget {
  const BankingFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankingFormState = ref.watch(bankingFormProvider);

    void onSubmit() async {
      final code = await ref.read(bankingFormProvider.notifier).onSubmit();

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
        SnackBarGI.showWithIcon(context,
            icon: Icons.check, text: "Depósito creado satisfactoriamente");
        ref.read(bankingFormProvider.notifier).reset();
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomCard(
          padding: const EdgeInsets.all(8),
          child: Column(children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.entreMonto,
                style: context.titleMedium),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.bancarizarContent1,
                style: context.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 8),
            CustomFilledButton(
              label: "Caluladora",
              icon: Icons.calculate_outlined,
              onPressed: () {
                DialogGI.showCustomDialog(context,
                    dialog: const DialogCalcBank());
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.bancarizarContent2,
                style: context.bodySmall.copyWith(color: context.primary),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: ref.read(bankingFormProvider.notifier).controllerForm,
              keyboardType: TextInputType.number,
              suffix: Text(AppLocalizations.of(context)!.osp),
              label: AppLocalizations.of(context)!.monto,
              enabled: bankingFormState.formStatus == FormStatus.invalid,
              onFieldSubmitted: (_) {
                if (bankingFormState.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged: ref.read(bankingFormProvider.notifier).amountChanged,
              errorMessage: bankingFormState.isFormDirty
                  ? bankingFormState.amount.errorMessage(context)
                  : null,
            ),
            const SizedBox(height: 8),
          ]),
        ),
        const SizedBox(height: 16),
        bankingFormState.formStatus == FormStatus.invalid
            ? CustomFilledButton(
                label: AppLocalizations.of(context)!.depositar,
                onPressed: () {
                  onSubmit();
                },
              )
            : const LoadingLogo(),
      ],
    );
  }
}
