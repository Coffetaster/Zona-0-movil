import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:zona0_apk/presentation/widgets/buttons/buttons.dart';
import 'package:zona0_apk/presentation/widgets/wallet/balance_card.dart';
import 'package:zona0_apk/presentation/widgets/wallet/wallet.dart';

class WalletPage2 extends StatefulWidget {
  WalletPage2({Key? key}) : super(key: key);

  @override
  _WalletPage2State createState() => _WalletPage2State();
}

class _WalletPage2State extends State<WalletPage2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeInUp(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Text("Mi billetera",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 20,
                ),
                const BalanceCard(),
                const SizedBox(
                  height: 50,
                ),
                Text("Operaciones",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 10,
                ),
                _operationsWidget(),
                const SizedBox(
                  height: 40,
                ),
                Text("Transaciones",
                    style: Theme.of(context).textTheme.titleLarge),
                _transactionList(),
                Center(
                    child:
                        CustomFilledButton(label: "Ver todas", onPressed: () {})),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
    );
  }

  Widget _operationsWidget() {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 8,
        runSpacing: 8,
        children: [
          IconSubtextButton(
              icon: Icons.payment_outlined, label: "Comprar ZOP", onTap: () {}),
          IconSubtextButton(
              icon: Icons.swap_horiz_outlined,
              label: "Cambiar ZOP",
              onTap: () {}),
          IconSubtextButton(
              icon: Icons.transfer_within_a_station_outlined,
              label: "Transferir",
              onTap: () {}),
          IconSubtextButton(
              icon: Icons.qr_code_scanner_outlined,
              label: "Qr Pagar",
              onTap: () {}),
          IconSubtextButton(
              icon: Icons.qr_code_outlined, label: "Qr Generar", onTap: () {}),
          IconSubtextButton(
              icon: Icons.play_arrow_outlined,
              label: "Ganar ZOP",
              onTap: () {}),
        ],
      ),
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
}
