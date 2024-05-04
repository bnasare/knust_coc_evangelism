import '../../data/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorViewWidget extends StatelessWidget {
  const ErrorViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          SvgPicture.asset(
            SvgAssets.empty,
            height: 400,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
