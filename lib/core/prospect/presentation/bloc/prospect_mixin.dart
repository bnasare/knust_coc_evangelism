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

  Stream<Prospect> getAProspect({required String documentID}) async* {
    final result = await bloc.getAProspect(documentID).first;
    yield result.fold(
      (l) => Prospect.initial(),
      (r) => r,
    );
  }

  Stream<List<Prospect>> listAllProspects({required String documentID}) async* {
    final result = await bloc.listAllProspects(documentID).first;
    yield result.fold(
      (l) => List<Prospect>.empty(),
      (r) => r,
    );
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
