import 'dart:developer';

import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_bloc.dart';
import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/snackbar.dart';

mixin ProspectMixin {
  final bloc = sl<ProspectBloc>();
  final localeBloc = sl<LocaleBloc>();

  Future<void> createAProspect(
      {required BuildContext context, required Prospect prospect}) async {
    final result = await bloc.createAProspect(prospect);
    return result.fold(
        (l) => SnackBarHelper.showErrorSnackBar(context, l.message),
        (r) => SnackBarHelper.showSuccessSnackBar(context,
            "${r.name} has been successfully added to the prospect list! 🎉"));
  }

  Stream<Prospect> getAProspect({required String documentID}) {
    final result = bloc.getAProspect(documentID);
    return result.map((either) {
      return either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return Prospect.initial();
      }, (prospect) {
        return prospect;
      });
    });
  }

  Stream<List<Prospect>> listAllProspects({required String documentID}) {
    final result = bloc.listAllProspects(documentID);
    return result.map((either) {
      return either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return [];
      }, (prospects) {
        return prospects;
      });
    });
  }

  Stream<Locales> getALocale() {
    final result = localeBloc.getALocale();
    return result.map((either) {
      return either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return Locales.initial();
      }, (locales) {
        return locales;
      });
    });
  }
}
