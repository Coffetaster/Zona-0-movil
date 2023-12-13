import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/wallet/balance_card.dart';
import 'package:zona0_apk/presentation/widgets/wallet/wallet.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    //*si no login
    if (!AppTheme.isLogin) {
      return const NoLoginPage();
    }

    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
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
                CustomTitle(AppLocalizations.of(context)!.transaciones),
                _transactionList(),
                Center(
                    child: CustomFilledButton(
                        label: AppLocalizations.of(context)!.verTodas,
                        onPressed: () {})),
                const SizedBox(
                  height: 80,
                ),
              ],
            )),
      ),
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
                    icon: Icons.attach_money_outlined,
                    label: AppLocalizations.of(context)!.comprarZOP,
                    onTap: () {}),
                IconSubtextButton(
                    icon: Icons.payment_outlined,
                    label: AppLocalizations.of(context)!.cambiarZOP,
                    onTap: () {}),
                IconSubtextButton(
                    icon: Icons.swap_horiz_outlined,
                    label: AppLocalizations.of(context)!.transferir,
                    onTap: () {
                      context.push(RouterPath.WALLET_TRANSFER_PAGE);
                    }),
                IconSubtextButton(
                    icon: Icons.qr_code_scanner_outlined,
                    label: AppLocalizations.of(context)!.pagarQr,
                    onTap: () {}),
                IconSubtextButton(
                    icon: Icons.qr_code_outlined,
                    label: AppLocalizations.of(context)!.generarQr,
                    onTap: () {}),
                IconSubtextButton(
                    icon: Icons.play_arrow_outlined,
                    label: AppLocalizations.of(context)!.ganarZOP,
                    onTap: () {}),
              ])),
    );
  }

  Widget _transactionList() {
    return const Column(
      children: <Widget>[
        TransactionItem(
            text: "Compra de 6 productos", time: "24 Nov 2023", monto: -6578),
        TransactionItem(
            text: "Tranferencia a alexkiller",
            time: "22 Nov 2023",
            monto: -1000),
        TransactionItem(
            text: "Regalo de lili80", time: "21 Nov 2023", monto: 4500),
        TransactionItem(
            text: "Ganaste en PPT", time: "20 Nov 2023", monto: 79.5),
        TransactionItem(
            text: "Perdiste en PPT", time: "20 Nov 2023", monto: -54.5),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
