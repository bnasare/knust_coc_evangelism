import 'dart:developer';

import '../../../../injection_container.dart';
import '../../domain/entities/locales.dart';
import 'locale_bloc.dart';
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

  Stream<Locales> getALocale() {
    final result = bloc.getALocale();
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
