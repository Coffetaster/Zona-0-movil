import 'package:animate_do/animate_do.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/wallet/balance_card.dart';
import 'package:zona0_apk/presentation/widgets/wallet/wallet.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class WalletView extends ConsumerStatefulWidget {
  const WalletView({super.key});

  @override
  ConsumerState<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends ConsumerState<WalletView>
    with AutomaticKeepAliveClientMixin {
  final AnimatedListGIController<TransactionReceived> _controllerUnpaidList =
      AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));
  final AnimatedListGIController<TransactionReceived> _controllerPaidList =
      AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));
  final AnimatedListGIController<TransactionSent>
      _controllerTransactionsSentList = AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final accountState = ref.watch(accountProvider);
    //*si no login
    if (!accountState.isLogin) {
      return const NoLoginPage();
    }

    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTitle(AppLocalizations.of(context)!.miBilletera),
                const SizedBox(
                  height: 20,
                ),
                const BalanceCard(),
                const SizedBox(
                  height: 50,
                ),
                CustomTitle(AppLocalizations.of(context)!.operaciones),
                const SizedBox(
                  height: 10,
                ),
                _operationsWidget(context),
                const SizedBox(
                  height: 40,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(AppLocalizations.of(context)!.recibos),
                        CustomIconButton(
                            icon: Icons.refresh_outlined,
                            onPressed: () {
                              ref
                                  .read(transferProvider.notifier)
                                  .getListPaidAndUnpaidReceive();
                            })
                      ],
                    );
                  },
                ),
                CustomCard(
                  child: _listReceivePaidAndUnpaidWidget(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTitle(AppLocalizations.of(context)!.envios),
                        CustomIconButton(
                            icon: Icons.refresh_outlined,
                            onPressed: () {
                              ref
                                  .read(transferProvider.notifier)
                                  .getListSendTransfer();
                            })
                      ],
                    );
                  },
                ),
                CustomCard(child: _listTransactionsSentWidget(context)),
                const SizedBox(height: 80),
              ],
            )),
      ),
    );
  }

  Widget _listReceivePaidAndUnpaidWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final transferState = ref.watch(transferProvider);
        if (transferState.isLoading) {
          return const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: LoadingLogo()));
        }
        int maxLength = transferState.listPaidReceive.length >
                transferState.listUnpaidReceive.length
            ? transferState.listPaidReceive.length
            : transferState.listUnpaidReceive.length;
        if (maxLength == 0) maxLength = 1;
        return SizedBox(
          width: double.infinity,
          height: (maxLength * 84) + 100,
          child: DefaultTabController(
              length: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SegmentedTabControl(
                      radius: const Radius.circular(AppTheme.borderRadius),
                      backgroundColor: context.secondaryContainer,
                      indicatorColor: context.primary,
                      tabTextColor: context.secondary,
                      selectedTabTextColor: context.onPrimary,
                      squeezeIntensity: 2,
                      height: 45,
                      tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                      textStyle: context.titleSmall,
                      selectedTextStyle: context.titleMedium,
                      tabs: [
                        SegmentTab(
                          label:
                              "${AppLocalizations.of(context)!.efectuados}(${transferState.listPaidReceive.length})",
                        ),
                        SegmentTab(
                          label:
                              "${AppLocalizations.of(context)!.pendientes}(${transferState.listUnpaidReceive.length})",
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          transferState.listPaidReceive.isEmpty
                              ? Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .noSolRecibosEfectuados))
                              : _animatedListWidgetOfTransactionsReceived(
                                  _controllerPaidList,
                                  transferState.listPaidReceive),
                          // : _transactionList(transferState.listPaidReceive),
                          transferState.listUnpaidReceive.isEmpty
                              ? Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .noSolRecibosPendientes))
                              : _animatedListWidgetOfTransactionsReceived(
                                  _controllerUnpaidList,
                                  transferState.listUnpaidReceive)
                          // : _transactionList(
                          //     transferState.listUnpaidReceive),
                        ]),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _listTransactionsSentWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final transferState = ref.watch(transferProvider);
        if (transferState.isLoading) {
          return const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: LoadingLogo()));
        }
        int maxLength = transferState.listTransactionsSent.length;
        if (maxLength == 0) maxLength = 2;
        return SizedBox(
          width: double.infinity,
          height: (maxLength * 84),
          child: transferState.listPaidReceive.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noSolEnvio))
              : _animatedListWidgetOfTransactionsSent(
                  _controllerTransactionsSentList,
                  transferState.listTransactionsSent),
        );
      },
    );
  }

  Widget _operationsWidget(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: double.infinity,
          height: 220,
          child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                IconSubtextButton(
                    icon: Icons.file_download_outlined,
                    label: AppLocalizations.of(context)!.recibirOSP,
                    onTap: () {
                      context.push(RouterPath.WALLET_RECEIVE_OSP_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.file_upload_outlined,
                    label: AppLocalizations.of(context)!.enviarOSP,
                    onTap: () {
                      context.push(RouterPath.WALLET_SEND_OSP_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.balance_outlined,
                    label: AppLocalizations.of(context)!.bancarizar,
                    onTap: () {
                      context.push(RouterPath.WALLET_BANKING_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.local_activity_outlined,
                    label: AppLocalizations.of(context)!.canjear_codigo,
                    onTap: () {
                      context.push(RouterPath.WALLET_REDEEM_CODE_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.play_arrow_outlined,
                    label: AppLocalizations.of(context)!.jugar,
                    onTap: () {
                      context.push(RouterPath.WALLET_PLAY_GAME_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.volunteer_activism_outlined,
                    label: AppLocalizations.of(context)!.donar,
                    onTap: () {
                      context.push(RouterPath.WALLET_DONATE_PAGE);
                    }),
              ])),
    );
  }

  Widget _animatedListWidgetOfTransactionsReceived(
      AnimatedListGIController<TransactionReceived> controller,
      List<TransactionReceived> transactions) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: AnimatedListGIWidget<TransactionReceived>(
            items: transactions,
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            builder: (context, index) =>
                TransactionReceivedItem(transaction: transactions[index])));
  }

  Widget _animatedListWidgetOfTransactionsSent(
      AnimatedListGIController<TransactionSent> controller,
      List<TransactionSent> transactions) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: AnimatedListGIWidget<TransactionSent>(
            items: transactions,
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            builder: (context, index) =>
                TransactionSentItem(transaction: transactions[index])));
  }

  @override
  bool get wantKeepAlive => true;
}
