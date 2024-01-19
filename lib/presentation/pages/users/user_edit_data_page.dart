import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/helpers/show_image.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/client.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/shared/widgets_gi.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class UserEditDataPage extends StatelessWidget {
  const UserEditDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editarDatos),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 8),
                Consumer(
                  builder: (context, ref, child) {
                    final accountState = ref.watch(accountProvider);
                    return SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (accountState.imagePath.isNotEmpty) {
                                ShowImage.fromNetwork(
                                    context: context,
                                    imagePath: accountState.imagePath,
                                    heroTag: HeroTags.imageProfile2(
                                        accountState.id));
                              }
                            },
                            child: Hero(
                              tag: HeroTags.imageProfile2(accountState.id),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: WidgetsGI.CacheImageNetworkGI(
                                      accountState.imagePath,
                                      placeholderPath:
                                          ImagesPath.pic_profile.path,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: accountState.changingProfileImage
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : FloatingActionButton.small(
                                    onPressed: () {
                                      selectImagen(context, ref);
                                    },
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                AppTheme.borderRadius))),
                                    child: const Icon(
                                        Icons.add_photo_alternate_outlined),
                                  ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                UserEditDataView(context),
                const SizedBox(height: 20),
              ]),
        ),
      ),
    );
  }

  Widget UserEditDataView(BuildContext context) {
    return Consumer(
      builder: (_, ref, child) {
        var isLoading =
            ref.watch(usersProvider.select((value) => value.isLoading));
        if (isLoading) {
          return const SizedBox(
            width: double.infinity,
            height: 300,
            child: Center(child: LoadingLogo()),
          );
        }
        final client = ref.read(usersProvider.select((value) => value.client));
        if (client != null) {
          return FadeInUp(child: FormUpdateClient(context, client));
        }
        final company =
            ref.read(usersProvider.select((value) => value.company));
        if (company != null) {
          return FadeInUp(child: FormUpdateCompany(context, company));
        }
        Future.delayed(Duration.zero, () {
          Utils.showSnackbarHaOcurridoError(context);
          context.pop();
        });
        return Container();
      },
    );
  }

  Widget FormUpdateClient(BuildContext context, Client client) {
    return Consumer(
      builder: (context, ref, child) {
        final updateFormClientStatus = ref.watch(updateFormClientProvider);
        if (updateFormClientStatus.id == null) {
          Future.delayed(Duration.zero, () {
            ref.read(updateFormClientProvider.notifier).initWithClient(client);
          });
        }
        void onSubmit() async {
          String code =
              await ref.read(updateFormClientProvider.notifier).onSubmit();
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
                icon: Icons.check_outlined,
                text: AppLocalizations.of(context)!.datosActualizadosExitos);
            context.pop();
          }
        }

        return Column(
          children: [
            CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.datosPersonales,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: AppLocalizations.of(context)!.usuario,
                      initialValue: client.username,
                      enabled: updateFormClientStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .usernameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.username
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: AppLocalizations.of(context)!.nombre,
                      initialValue: client.name,
                      enabled: updateFormClientStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .nameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.name.errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: AppLocalizations.of(context)!.apellidos,
                      initialValue: client.last_name,
                      enabled: updateFormClientStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .lastNameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.lastName
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                      prefix: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("(+53)",
                            style: TextStyle(color: Colors.grey.shade500)),
                      ),
                      label: AppLocalizations.of(context)!.telefono,
                      initialValue: client.movil,
                      enabled: updateFormClientStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .telephoneChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.telephone
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      label: AppLocalizations.of(context)!.ci,
                      initialValue: client.ci,
                      enabled: updateFormClientStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged:
                          ref.read(updateFormClientProvider.notifier).ciChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.ci.errorMessage(context)
                          : null,
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            updateFormClientStatus.formStatus != FormStatus.validating
                ? CustomFilledButton(
                    label: AppLocalizations.of(context)!.actualizar,
                    onPressed: () {
                      onSubmit();
                    },
                  )
                : ZoomIn(child: const LoadingLogo())
          ],
        );
      },
    );
  }

  Widget FormUpdateCompany(BuildContext context, Company company) {
    return Consumer(
      builder: (context, ref, child) {
        final updateFormClientStatus = ref.watch(updateFormClientProvider);
        final updateFormCompanyStatus = ref.watch(updateFormCompanyProvider);
        if (updateFormClientStatus.id == null) {
          Future.delayed(Duration.zero, () {
            ref
                .read(updateFormClientProvider.notifier)
                .initWithCompany(company);
            ref
                .read(updateFormCompanyProvider.notifier)
                .initWithCompany(company);
          });
        }
        void onSubmit() async {
          String code = await ref
              .read(updateFormCompanyProvider.notifier)
              .onSubmit(ref.read(updateFormClientProvider.notifier));
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
                icon: Icons.check_outlined,
                text: AppLocalizations.of(context)!.datosActualizadosExitos);
            context.pop();
          }
        }

        return Column(
          children: [
            CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.datosPersonales,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: AppLocalizations.of(context)!.usuario,
                      initialValue: company.username,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .usernameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.username
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: AppLocalizations.of(context)!.nombre,
                      initialValue: company.name,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .nameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.name.errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: AppLocalizations.of(context)!.apellidos,
                      initialValue: company.last_name,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .lastNameChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.lastName
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                      prefix: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("(+53)",
                            style: TextStyle(color: Colors.grey.shade500)),
                      ),
                      label: AppLocalizations.of(context)!.telefono,
                      initialValue: company.movil,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormClientProvider.notifier)
                          .telephoneChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.telephone
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      label: AppLocalizations.of(context)!.ci,
                      initialValue: company.ci,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormClientStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged:
                          ref.read(updateFormClientProvider.notifier).ciChanged,
                      errorMessage: updateFormClientStatus.isFormDirty
                          ? updateFormClientStatus.ci.errorMessage(context)
                          : null,
                    ),
                    const Divider(height: 30),
                    Text(AppLocalizations.of(context)!.datosCompany,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      label: AppLocalizations.of(context)!.company,
                      initialValue: company.company_name,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormCompanyStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormCompanyProvider.notifier)
                          .companyChanged,
                      errorMessage: updateFormCompanyStatus.isFormDirty
                          ? updateFormCompanyStatus.company
                              .errorMessage(context)
                          : null,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      label: AppLocalizations.of(context)!.codigoCompany,
                      initialValue: company.company_code,
                      enabled: updateFormCompanyStatus.formStatus !=
                          FormStatus.validating,
                      onFieldSubmitted: (_) {
                        if (updateFormCompanyStatus.formStatus !=
                            FormStatus.validating) {
                          onSubmit();
                        }
                      },
                      onChanged: ref
                          .read(updateFormCompanyProvider.notifier)
                          .companyCodeChanged,
                      errorMessage: updateFormCompanyStatus.isFormDirty
                          ? updateFormCompanyStatus.companyCode
                              .errorMessage(context)
                          : null,
                    ),
                    CustomDropdownButton<CompanyType>(
                      value: company.company_type.isEmpty
                          ? null
                          : CompanyType(company.company_type),
                      hint: AppLocalizations.of(context)!.tipoCompany,
                      items: Utils.companyTypes,
                      onChanged: updateFormCompanyStatus.formStatus !=
                              FormStatus.validating
                          ? (CompanyType? newValue) {
                              if (newValue != null) {
                                ref
                                    .read(updateFormCompanyProvider.notifier)
                                    .companyTypeChanged(newValue.titleDrop);
                              }
                            }
                          : null,
                      error: updateFormCompanyStatus.isFormDirty &&
                              updateFormCompanyStatus.companyType.value.isEmpty
                          ? updateFormCompanyStatus.companyType
                              .errorMessage(context)
                          // ? AppLocalizations.of(context)!.validForm_campoRequerido
                          : null,
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            updateFormCompanyStatus.formStatus != FormStatus.validating
                ? CustomFilledButton(
                    label: AppLocalizations.of(context)!.actualizar,
                    onPressed: () {
                      onSubmit();
                    },
                  )
                : ZoomIn(child: const LoadingLogo())
          ],
        );
      },
    );
  }

  Future<void> selectImagen(BuildContext context, WidgetRef ref) async {
    final imagePath = await Utils.selectAndCropImage(context);
    if (imagePath != null) {
      ref.read(accountProvider.notifier).imageChange(imagePath);
    }
  }
}
