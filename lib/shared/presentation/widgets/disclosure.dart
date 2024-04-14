import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/theme/extra_colors.dart';

class DisclosureAndAgreements extends StatelessWidget {
  const DisclosureAndAgreements({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disclosure and Agreements'.toUpperCase(),
          style: theme.textTheme.titleMedium!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: ExtraColors.lightGrey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Botr Terms Of Usage'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please read through the Botr Terms Of Usage "Agreement", '
                'including the important information',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF616161),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
