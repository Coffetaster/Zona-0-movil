import 'dart:math';

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
  final AnimatedListGIController<Donation>
      _controllerDonationsList = AnimatedListGIController(
          removePlaceholder: const SizedBox(
    width: double.infinity,
    height: 80,
  ));

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isLogin = ref.watch(accountProvider.select((value) => value.isLogin));
    //*si no login
    if (!isLogin) {
      return const NoLoginPage();
    }

    // ignore: unused_local_variable
    final keepAlive_institutionsProvider = ref.watch(institutionsProvider.select((value) => value.isLoading));
    // ignore: unused_local_variable
    final keepAlive_bankingProvider = ref.watch(bankingProvider.select((value) => value.isLoading));

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
                        CustomTitle(
                            AppLocalizations.of(context)!.ultimasOperaciones),
                        CustomIconButton(
                            icon: Icons.refresh_outlined,
                            onPressed: () {
                              ref
                                  .read(transferProvider.notifier)
                                  .getAllTransactions();
                            })
                      ],
                    );
                  },
                ),
                CustomCard(
                  child: _listReceiveAndSentWidget(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 80),
              ],
            )),
      ),
    );
  }

  Widget _listReceiveAndSentWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final transferState = ref.watch(transferProvider);
        if (transferState.isLoading) {
          return const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: LoadingLogo()));
        }
        int maxLength1 = max(transferState.listPaidReceive.length,
            transferState.listUnpaidReceive.length);
        int maxLength2 = max(transferState.listTransactionsSent.length,
            transferState.donationsList.length);
        int maxLength = max(maxLength1, maxLength2);
        if (maxLength == 0) maxLength = 1;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: double.infinity,
          height: (maxLength * 84) + 130,
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
                          label: AppLocalizations.of(context)!.recibos,
                        ),
                        SegmentTab(
                          label: AppLocalizations.of(context)!.envios,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _listReceivePaidAndUnpaidWidget(context),
                          _listSentTransferAndDonateWidget(context),
                        ]),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget _listReceivePaidAndUnpaidWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final transferState = ref.watch(transferProvider);
        int maxLength = transferState.listPaidReceive.length >
                transferState.listUnpaidReceive.length
            ? transferState.listPaidReceive.length
            : transferState.listUnpaidReceive.length;
        if (maxLength == 0) maxLength = 1;
        return DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: context.primary,
                labelColor: context.primary,
                unselectedLabelColor: context.secondary,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    text:
                        "${AppLocalizations.of(context)!.efectuados}(${transferState.listPaidReceive.length})",
                  ),
                  Tab(
                    text:
                        "${AppLocalizations.of(context)!.pendientes}(${transferState.listUnpaidReceive.length})",
                  ),
                ],
              ),
              SizedBox(
                height: (maxLength * 84),
                child: TabBarView(
                  children: <Widget>[
                    transferState.listPaidReceive.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .noSolRecibosEfectuados))
                        : _animatedListWidgetOfTransactionsReceived(
                            _controllerPaidList, transferState.listPaidReceive),
                    transferState.listUnpaidReceive.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .noSolRecibosPendientes))
                        : _animatedListWidgetOfTransactionsReceived(
                            _controllerUnpaidList,
                            transferState.listUnpaidReceive)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _listSentTransferAndDonateWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final transferState = ref.watch(transferProvider);
        int maxLength = max(transferState.listTransactionsSent.length,
            transferState.donationsList.length);
        if (maxLength == 0) maxLength = 1;
        return DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: context.primary,
                labelColor: context.primary,
                unselectedLabelColor: context.secondary,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    text:
                        "${AppLocalizations.of(context)!.transferidos}(${transferState.listTransactionsSent.length})",
                  ),
                  Tab(
                    text:
                        "${AppLocalizations.of(context)!.donados}(${transferState.donationsList.length})",
                  ),
                ],
              ),
              SizedBox(
                height: (maxLength * 84),
                child: TabBarView(
                  children: <Widget>[
                    transferState.listTransactionsSent.isEmpty
                        ? Center(
                            child:
                                Text(AppLocalizations.of(context)!.noSolEnvio))
                        : _animatedListWidgetOfTransactionsSent(
                            _controllerTransactionsSentList,
                            transferState.listTransactionsSent),
                    transferState.donationsList.isEmpty
                        ? Center(
                            child:
                                Text(AppLocalizations.of(context)!.noDonaciones))
                        : _animatedListWidgetOfDonations(
                            _controllerDonationsList,
                            transferState.donationsList),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _operationsWidget(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          shrinkWrap: true,
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
                icon: Icons.credit_card_outlined,
                label: AppLocalizations.of(context)!.descuento,
                onTap: () {
                  context.push(RouterPath.WALLET_PLAY_GAME_PAGE);
                }),
            // IconSubtextButton(
            //     icon: Icons.play_arrow_outlined,
            //     label: AppLocalizations.of(context)!.jugar,
            //     onTap: () {
            //       context.push(RouterPath.WALLET_PLAY_GAME_PAGE);
            //     }),
            IconSubtextButton(
                icon: Icons.volunteer_activism_outlined,
                label: AppLocalizations.of(context)!.donar,
                onTap: () {
                  context.push(RouterPath.WALLET_DONATE_PAGE);
                }),
          ]),
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

  Widget _animatedListWidgetOfDonations(
      AnimatedListGIController<Donation> controller,
      List<Donation> donations) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: AnimatedListGIWidget<Donation>(
            items: donations,
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            builder: (context, index) =>
                DonationItem(donation: donations[index])));
  }

  @override
  bool get wantKeepAlive => true;
}
