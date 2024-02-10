import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/banking/calc_bank_provider.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class DialogCalcBank extends ConsumerStatefulWidget {
  const DialogCalcBank({super.key});

  @override
  ConsumerState<DialogCalcBank> createState() => _DialogCalcBankState();
}

class _DialogCalcBankState extends ConsumerState<DialogCalcBank> {
  final TextEditingController _controller = TextEditingController(text: "30");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calcBankState = ref.watch(calcBankProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.calculadora,
            style: context.titleLarge,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: context.primary.withOpacity(.1),
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppTheme.borderRadius))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.montoTotal,
                        style: context.titleMedium),
                    Text(calcBankState.isvalid
                        ? calcBankState.amountTotal.toStringAsFixed(2)
                        : "--"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.ganancia,
                        style: context.titleSmall),
                    Text(calcBankState.isvalid
                        ? (calcBankState.amountTotal -
                                calcBankState.amount.realValue)
                            .toStringAsFixed(2)
                        : "--"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              CustomIconButton(
                iconButtonType: IconButtonType.filledTonal,
                icon: Icons.horizontal_rule_outlined,
                onPressed: () {
                  final daysValue = ref.read(calcBankProvider.notifier).decrementDay();
                  if(daysValue != null) {
                    _controller.text = daysValue.toString();
                  }
                },
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  label: AppLocalizations.of(context)!.dias,
                  onChanged:
                      ref.read(calcBankProvider.notifier).daysChanged,
                  errorMessage: calcBankState.days.errorMessage(context),
                ),
              ),
              CustomIconButton(
                iconButtonType: IconButtonType.filledTonal,
                icon: Icons.add_outlined,
                onPressed: () {
                  final daysValue = ref.read(calcBankProvider.notifier).incrementDay();
                  if(daysValue != null) {
                    _controller.text = daysValue.toString();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomTextFormField(
            initialValue: "0",
            keyboardType: TextInputType.number,
            label: AppLocalizations.of(context)!.entreMonto,
            onChanged:
                ref.read(calcBankProvider.notifier).amountChanged,
            errorMessage: calcBankState.amount.errorMessage(context),
          ),
          const SizedBox(height: 12),
          Center(
            child: CustomFilledButton(
              label: AppLocalizations.of(context)!.cerrar,
              onPressed: context.pop,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
