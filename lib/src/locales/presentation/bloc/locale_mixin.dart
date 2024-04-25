import 'dart:developer';

import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LocaleMixin {
  final bloc = sl<LocaleBloc>();

  Stream<List<Locales>> listAllLocales({required BuildContext context}) {
    final result = bloc.listAllLocales();
    return result.map((either) {
      return either.fold(
        (failure) {
          log('Failed to fetch locales: $failure');
          return [];
        },
        (locales) {
          return locales;
        },
      );
    });
  }

  Stream<Locales> getALocale({
    required String documentID,
  }) {
    final result = bloc.getALocale(documentID);
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
