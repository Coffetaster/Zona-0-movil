import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zona0_apk/config/constants/constants.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/transfer/transfer.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class ReceiveItemDataPage extends ConsumerWidget {
  const ReceiveItemDataPage(
      {super.key,
      required this.id,
      required this.canEdit,
      this.transactionReceived});

  final String id;
  final bool canEdit;
  final TransactionReceived? transactionReceived;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TransactionReceived? transaction = transactionReceived ??
        ref.read(transferProvider.notifier).getTransaction(id);
    if (transaction == null) {
      Future.delayed(Duration.zero, () => context.pop());
      return Container();
    }
    deleteTransaction() async {
      bool isOpenDialog = true;
      Utils.showDialogIsLoading(context).then((value) => isOpenDialog = false);
      final code = await ref
          .read(transferProvider.notifier)
          .deleteUnpaidReceive(transaction.id);
      if (isOpenDialog) {
        context.pop();
      }
      if (code == 200) {
        context.pop();
        SnackBarGI.showWithIcon(context,
            icon: Icons.check_outlined,
            text: AppLocalizations.of(context)!.reciboCancelado);
      } else if (code == 498) {
        Utils.showSnackbarCompruebeConexion(context);
      } else {
        Utils.showSnackbarEnDesarrollo(context);
      }
    }

    showDialogDeleteTransaction() {
      DialogGI.showAlertDialog(context,
          title: AppLocalizations.of(context)!.dialog_title_receive_cancel,
          content: AppLocalizations.of(context)!.dialog_content_receive_cancel,
          actionOk: () {
        context.pop();
        deleteTransaction();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detallesRecibo),
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
                  const SizedBox(height: 16),
                  SizedBox(
                      width: context.width * .7,
                      height: context.width * .7,
                      child: QrImageView(
                        data: transaction.code,
                        version: QrVersions.auto,
                        gapless: false,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: context.secondary,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: context.secondary,
                        ),
                        embeddedImage: AssetImage(ImagesPath.logo.path),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(
                              context.width * .7 / 4, context.width * .7 / 4),
                        ),
                      )),
                  const SizedBox(height: 16),
                  CustomCard(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.detalles,
                              style: context.titleMedium),
                          const SizedBox(height: 8),
                          ListTile(
                            title:
                                Text(AppLocalizations.of(context)!.codigoPago),
                            subtitle: Text(transaction.code),
                            trailing: CustomIconButton(
                                icon: Icons.copy_outlined,
                                onPressed: () async {
                                  await Utils.copyToClipboard(transaction.code);
                                  SnackBarGI.showWithIcon(context,
                                      icon: Icons.check,
                                      text: AppLocalizations.of(context)!
                                          .codigoCopiado);
                                }),
                          ),
                          ListTile(
                            title:
                                Text(AppLocalizations.of(context)!.montoPagar),
                            subtitle: Text(
                                '${transaction.amount.toStringAsFixed(2)} ${Constants.namePoints}'),
                          ),
                          if (!canEdit)
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(context)!.usuario),
                              subtitle: Text(transaction.user),
                            ),
                          ListTile(
                            title: Text(AppLocalizations.of(context)!.estado),
                            subtitle: Text(
                                transaction.state.toLowerCase() == "paid"
                                    ? AppLocalizations.of(context)!.efectuado
                                    : AppLocalizations.of(context)!.pendiente),
                          ),
                          ListTile(
                            title: Text(AppLocalizations.of(context)!.fecha),
                            subtitle: Text(
                                "${transaction.date}, ${transaction.time.split(".")[0]}"),
                          ),
                        ],
                      )),
                  const SizedBox(height: 8),
                  if (transaction.state.toLowerCase() != "paid" && canEdit)
                    CustomCard(
                      child: SettingOption(
                        icon: Icons.cancel_outlined,
                        title: AppLocalizations.of(context)!.cancelarReciboPago,
                        onTap: () {
                          showDialogDeleteTransaction();
                        },
                      ),
                    ),
                  const SizedBox(height: 20)
                ]),
          ),
        ),
      ),
    );
  }
}
