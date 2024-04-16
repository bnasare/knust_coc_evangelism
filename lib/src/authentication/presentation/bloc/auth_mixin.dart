import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../../shared/presentation/widgets/snackbar.dart';
import 'auth_bloc.dart';

mixin AuthMixin {
  final bloc = sl<AuthBloc>();

  Future<void> loginUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final result = await bloc.loginUser(
      email,
      password,
    );
    return result.fold(
        (l) => SnackBarHelper.showErrorSnackBar(context, l.message), (r) => r);
    // NavigationHelper.navigateToAndRemoveUntil(context, const NavBar()));
  }

  Future<void> logoutUser({required BuildContext context}) async {
    final result = await bloc.logoutUser();
    return result.fold(
      (l) => l,
      (r) => r,
    );
  }
}
