import 'dart:math';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/cards/cards.dart';
import 'package:zona0_apk/presentation/widgets/texts/custom_title.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ManageCardPage extends ConsumerWidget {
  ManageCardPage({super.key});

  final AnimatedListGIController<CardDiscount> _controllerDiscountSendList =
      AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));

  final AnimatedListGIController<CardDiscount> _controllerDiscountReceiveList =
      AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCard = ref.watch(cardProvider.select((value) => value.myCard));
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.gestionaTarjeta),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FadeInUp(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(children: <Widget>[
              const SizedBox(height: 16),
              CustomTitle("Mi tarjeta"),
              const SizedBox(height: 8),
              CustomCard(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Mínimo diario a extraer",
                            style: context.labelLarge,
                          ),
                          Text(
                            myCard != null
                                ? "${myCard.min_withdraw.toStringAsFixed(2)} OSP"
                                : "- - - - - -",
                            style: context.bodyMedium,
                          ),
                        ],
                      ),
                      if (myCard != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Tarjeta ${myCard.active ? "activa" : "inactiva"}",
                              style: context.labelLarge,
                            ),
                            Switch(
                              value: myCard.active,
                              onChanged: (value) async {
                                Utils.waitingLoading(
                                  context,
                                  () async {
                                    final code = await ref
                                        .read(cardProvider.notifier)
                                        .toggleStateActiveCard();
                                    if (code != "200") {
                                      Utils.parseErrorCode(context, code);
                                    }
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Código de descuento",
                            style: context.labelLarge,
                          ),
                          myCard != null
                              ? CustomTextButton(
                                  label: myCard.discount_code,
                                  onPressed: () async {
                                    await Utils.copyToClipboard(
                                        myCard.discount_code);
                                    SnackBarGI.showWithIcon(context,
                                        icon: Icons.check,
                                        text: AppLocalizations.of(context)!
                                            .codigoCopiado);
                                  },
                                )
                              : Text(
                                  "- - - - - -",
                                  style: context.bodyMedium,
                                ),
                        ],
                      ),
                    ],
                  )),
              if (myCard == null)
                CustomFilledButton(
                  label: "Obtener tarjeta",
                  width: double.infinity,
                  onPressed: () async {
                    Utils.waitingLoading(
                      context,
                      () async {
                        final code = await ref
                            .read(cardProvider.notifier)
                            .getCardDetails();
                        if (code != "200") {
                          Utils.parseErrorCode(context, code);
                        }
                      },
                    );
                  },
                ),
              if (myCard != null) ...[
                const SizedBox(height: 16),
                CustomTitle("Opciones"),
                const SizedBox(height: 8),
                CustomFilledButton(
                  label: "Cambiar código de descuento",
                  width: double.infinity,
                  onPressed: () {
                    Utils.waitingLoading(
                      context,
                      () async {
                        final code = await ref
                            .read(cardProvider.notifier)
                            .changeDiscountCode();
                        if (code != "200") {
                          Utils.parseErrorCode(context, code);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                CustomFilledButton(
                  label: "Cambiar límite de extracción",
                  width: double.infinity,
                  onPressed: () {
                    DialogGI.showCustomDialog(context,
                        dialog: const DialogChangeLimitWithdraw());
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTitle(AppLocalizations.of(context)!.descuentos),
                    Consumer(
                      builder: (context, ref, child) {
                        return CustomIconButton(
                            icon: Icons.refresh_outlined,
                            onPressed: () {
                              ref.read(cardProvider.notifier).getDiscountList();
                            });
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    final cardState = ref.watch(cardProvider);
                    if (cardState.isLoading) {
                      return const CustomCard(
                        child: SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Center(child: LoadingLogo())),
                      );
                    }
                    int maxLength = max(cardState.discountsReceive.length,
                        cardState.discountsSend.length);
                    if (maxLength == 0) maxLength = 1;
                    return CustomCard(
                        padding: const EdgeInsets.all(8),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: double.infinity,
                            height: (maxLength * 72) + 65,
                            child: DefaultTabController(
                                length: 2,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: SegmentedTabControl(
                                        radius: const Radius.circular(
                                            AppTheme.borderRadius),
                                        backgroundColor:
                                            context.secondaryContainer,
                                        indicatorColor: context.primary,
                                        tabTextColor: context.secondary,
                                        selectedTabTextColor: context.onPrimary,
                                        squeezeIntensity: 2,
                                        height: 45,
                                        tabPadding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        textStyle: context.titleSmall,
                                        selectedTextStyle: context.titleMedium,
                                        tabs: [
                                          SegmentTab(
                                            label:
                                                "${AppLocalizations.of(context)!.recibidos} (${cardState.discountsReceive.length})",
                                          ),
                                          SegmentTab(
                                            label:
                                                "${AppLocalizations.of(context)!.realizados} (${cardState.discountsSend.length})",
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 70),
                                      child: TabBarView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            cardState.discountsReceive.isEmpty
                                                ? SizedBox(
                                                    width: double.infinity,
                                                    height: 300,
                                                    child: Center(
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .noDescuentos)),
                                                  )
                                                : AnimatedListGIWidget<
                                                        CardDiscount>(
                                                    items: cardState
                                                        .discountsReceive,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    controller:
                                                        _controllerDiscountReceiveList,
                                                    builder: (context, index) =>
                                                        CardDiscountItem(
                                                          cardDiscount: cardState
                                                                  .discountsReceive[
                                                              index],
                                                          isOwn: false,
                                                        )),
                                            cardState.discountsSend.isEmpty
                                                ? SizedBox(
                                                    width: double.infinity,
                                                    height: 300,
                                                    child: Center(
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .noDescuentos)),
                                                  )
                                                : AnimatedListGIWidget<
                                                        CardDiscount>(
                                                    items:
                                                        cardState.discountsSend,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    controller:
                                                        _controllerDiscountSendList,
                                                    builder: (context, index) =>
                                                        CardDiscountItem(
                                                          cardDiscount: cardState
                                                                  .discountsSend[
                                                              index],
                                                          isOwn: true,
                                                        ))
                                          ]),
                                    ),
                                  ],
                                ))));
                  },
                ),
              ],
              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}
