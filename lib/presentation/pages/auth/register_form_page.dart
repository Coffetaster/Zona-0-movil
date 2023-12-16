import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zona0_apk/config/constants/images_path.dart';
import 'package:zona0_apk/config/helpers/snackbar_gi.dart';
import 'package:zona0_apk/config/helpers/utils.dart';
import 'package:zona0_apk/config/router/router_path.dart';
import 'package:zona0_apk/config/theme/app_theme.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/domain/inputs/inputs.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/providers/register/register_form_company_provider.dart';
import 'package:zona0_apk/presentation/widgets/backgrounds/bezier_background.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

class RegisterFormPage extends ConsumerWidget {
  const RegisterFormPage({super.key, required this.isClient});

  final bool isClient;
  final String idConfirmExitProvider = "RegisterClientPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final confirmExit = ref.watch(confirmExitProvider(idConfirmExitProvider));
    if (confirmExit == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.pop();
        context.pop();
      });
    } else if (confirmExit == 2) {
      Future.delayed(Duration(milliseconds: 0), () {
        context.go(RouterPath.AUTH_VERIFY_CODE_PAGE);
        SnackBarGI.showWithIcon(context,
            icon: Icons.check,
            text: AppLocalizations.of(context)!.registroCorrecto);
      });
    }

    //* registerClientProvider
    final registerClientStatus = ref.watch(registerFormClientProvider);
    //* registerCompanyProvider
    final registerCompanyStatus = ref.watch(registerFormCompanyProvider);

    void onSubmit() async {
      String code;
      if (isClient) {
        code = await ref.read(registerFormClientProvider.notifier).onSubmit();
      } else {
        code = await ref
            .read(registerFormCompanyProvider.notifier)
            .onSubmit(ref.read(registerFormClientProvider.notifier));
      }
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
          case "499":
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: AppLocalizations.of(context)!.debeSeleccionarImagen);
            break;
          default:
            SnackBarGI.showWithIcon(context,
                icon: Icons.error_outline,
                text: code.isEmpty
                    ? AppLocalizations.of(context)!.haOcurridoError
                    : code);
        }
      } else {
        ref.read(confirmExitProvider(idConfirmExitProvider).notifier).state = 2;
      }
    }

    bool verifyForm() => (isClient
        ? registerClientStatus.formStatus == FormStatus.validating
        : registerCompanyStatus.formStatus == FormStatus.validating);

    return BezierBackground(
      btnBack: !verifyForm(),
      // btnBack: registerClientStatus.formStatus == FormStatus.invalid,
      onPressed: () =>
          Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider),
      child: FadeInUp(
        child: PopScope(
          canPop: confirmExit != 0 && !verifyForm(),
              // registerClientStatus.formStatus == FormStatus.invalid,
          onPopInvoked: (canPop) {
            if (!verifyForm())
            // if (registerClientStatus.formStatus == FormStatus.invalid)
              Utils.showDialogConfirmSalir(context, ref, idConfirmExitProvider);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * .2),
                  _title(context),
                  const SizedBox(
                    height: 50,
                  ),
                  verifyForm()
                      ? ZoomIn(
                          child: SizedBox(
                              width: double.infinity,
                              child: LoadingPage(
                                  message: AppLocalizations.of(context)!
                                      .enviandoEsperePlis)),
                        )
                      : StepsWidgetGI(
                          textFinish: AppLocalizations.of(context)!.registrar,
                          onTapFinish: () {
                            onSubmit();
                          },
                          children: [
                            widgetStep1(
                                context, ref, registerClientStatus, onSubmit),
                            widgetStep2(
                                context, ref, registerClientStatus, onSubmit),
                            if (!isClient)
                              widgetStep3(context, ref, registerCompanyStatus,
                                  onSubmit),
                          ],
                        ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.registro,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget widgetStep1(BuildContext context, WidgetRef ref,
      RegisterFormClientStatus registerClientStatus, VoidCallback onSubmit) {
    return CustomCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.datosPersonales,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            CustomTextFormField(
              keyboardType: TextInputType.name,
              label: AppLocalizations.of(context)!.nombre,
              initialValue: registerClientStatus.name.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).nameChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.name.errorMessage(context)
                  : null,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.name,
              label: AppLocalizations.of(context)!.apellidos,
              initialValue: registerClientStatus.lastName.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).lastNameChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.lastName.errorMessage(context)
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
              initialValue: registerClientStatus.telephone.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged: ref
                  .read(registerFormClientProvider.notifier)
                  .telephoneChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.telephone.errorMessage(context)
                  : null,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              maxLength: 11,
              label: AppLocalizations.of(context)!.ci,
              initialValue: registerClientStatus.ci.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).ciChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.ci.errorMessage(context)
                  : null,
            ),
          ],
        ));
  }

  Widget widgetStep2(BuildContext context, WidgetRef ref,
      RegisterFormClientStatus registerClientStatus, VoidCallback onSubmit) {
    return CustomCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.datosUsuario,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: registerClientStatus.imagePath == null
                            ? Image.asset(ImagesPath.user_placeholder.path,
                                width: 120, height: 120, fit: BoxFit.cover)
                            : Image.file(File(registerClientStatus.imagePath!),
                                width: 120, height: 120, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: FloatingActionButton.small(
                      onPressed: () {
                        selectImagen(ref);
                      },
                      child: Icon(Icons.add_photo_alternate_outlined),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppTheme.borderRadius))),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            CustomTextFormField(
              keyboardType: TextInputType.text,
              label: AppLocalizations.of(context)!.usuario,
              initialValue: registerClientStatus.username.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).usernameChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.username.errorMessage(context)
                  : null,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.emailAddress,
              label: AppLocalizations.of(context)!.correo,
              initialValue: registerClientStatus.email.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).emailChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.email.errorMessage(context)
                  : null,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: registerClientStatus.isObscurePassword,
              hint: "* * * * * *",
              suffix: CustomIconButton(
                  onPressed: ref
                      .read(registerFormClientProvider.notifier)
                      .toggleObscurePassword,
                  icon: registerClientStatus.isObscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
              label: AppLocalizations.of(context)!.password,
              initialValue: registerClientStatus.password.value,
              onFieldSubmitted: (_) {
                if (registerClientStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormClientProvider.notifier).passwordChanged,
              errorMessage: registerClientStatus.isFormDirty
                  ? registerClientStatus.password.errorMessage(context)
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: LinearProgressIndicator(
                value: registerClientStatus.percentSecurePassword,
                minHeight: 20,
                borderRadius:
                    BorderRadius.all(Radius.circular(AppTheme.borderRadius)),
                semanticsLabel: AppLocalizations.of(context)!.passwordSecure,
              ),
            ),
            Text(AppLocalizations.of(context)!.passwordSecure +
                " (${registerClientStatus.percentSecurePassword * 100}%)"),
            if (registerClientStatus.isFormDirty &&
                registerClientStatus.password.errorMessage(context) != null &&
                registerClientStatus.password.errorMessage(context)!.isNotEmpty)
              FadeIn(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value:
                                registerClientStatus.passwordRequired1 ? 0 : -1,
                            groupValue: 0,
                            onChanged: (_) {},
                            toggleable: false),
                        Text(AppLocalizations.of(context)!.passwordSecureReq1)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value:
                                registerClientStatus.passwordRequired2 ? 1 : -1,
                            groupValue: 1,
                            onChanged: (_) {},
                            toggleable: false),
                        Text(AppLocalizations.of(context)!.passwordSecureReq2)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value:
                                registerClientStatus.passwordRequired3 ? 2 : -1,
                            groupValue: 2,
                            onChanged: (_) {},
                            toggleable: false),
                        Text(AppLocalizations.of(context)!.passwordSecureReq3)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<int>(
                            value:
                                registerClientStatus.passwordRequired4 ? 3 : -1,
                            groupValue: 3,
                            onChanged: (_) {},
                            toggleable: false),
                        Text(AppLocalizations.of(context)!.passwordSecureReq4)
                      ],
                    ),
                  ],
                ),
              )
          ],
        ));
  }

  Widget widgetStep3(BuildContext context, WidgetRef ref,
      RegisterFormCompanyStatus registerCompanyStatus, VoidCallback onSubmit) {
    return CustomCard(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.datosCompany,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            CustomTextFormField(
              keyboardType: TextInputType.text,
              label: AppLocalizations.of(context)!.company,
              initialValue: registerCompanyStatus.company.value,
              onFieldSubmitted: (_) {
                if (registerCompanyStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged:
                  ref.read(registerFormCompanyProvider.notifier).companyChanged,
              errorMessage: registerCompanyStatus.isFormDirty
                  ? registerCompanyStatus.company.errorMessage(context)
                  : null,
            ),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              label: AppLocalizations.of(context)!.codigoCompany,
              initialValue: registerCompanyStatus.companyCode.value,
              onFieldSubmitted: (_) {
                if (registerCompanyStatus.formStatus != FormStatus.validating) {
                  onSubmit();
                }
              },
              onChanged: ref
                  .read(registerFormCompanyProvider.notifier)
                  .companyCodeChanged,
              errorMessage: registerCompanyStatus.isFormDirty
                  ? registerCompanyStatus.companyCode.errorMessage(context)
                  : null,
            ),
            CustomDropdownButton<CompanyType>(
              value: registerCompanyStatus.companyType.value.isEmpty
                  ? null
                  : CompanyType(registerCompanyStatus.companyType.value),
              hint: AppLocalizations.of(context)!.tipoCompany,
              items: Utils.companyTypes,
              onChanged: (CompanyType? newValue) {
                if (newValue != null) {
                  ref
                      .read(registerFormCompanyProvider.notifier)
                      .companyTypeChanged(newValue.titleDrop);
                }
              },
              error: registerCompanyStatus.isFormDirty &&
                      registerCompanyStatus.companyType.value.isEmpty
                  ? registerCompanyStatus.companyType.errorMessage(context)
                  // ? AppLocalizations.of(context)!.validForm_campoRequerido
                  : null,
            ),
          ],
        ));
  }

  Future<void> selectImagen(WidgetRef ref) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(registerFormClientProvider.notifier).imageSelect(image.path);
    }
  }
}
