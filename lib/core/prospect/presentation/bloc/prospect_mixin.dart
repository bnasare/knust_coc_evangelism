import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_bloc.dart';
import 'package:evangelism_admin/injection_container.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/snackbar.dart';

mixin ProspectMixin {
  final bloc = sl<ProspectBloc>();

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
}
