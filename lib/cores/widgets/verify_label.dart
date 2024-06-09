import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants/app_color.dart';
import '../constants/assets.dart';

class VerifyLabel extends StatelessWidget {
  final bool isVerified;
  const VerifyLabel({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isVerified ? clrYellowFFF : clrGreyE5,
        borderRadius: BorderRadius.circular(30),
      ),
      child: isVerified == true
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  icStarYellow,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 2),
                Text(
                  t.lblVerified,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          : Text(
              t.lblUnverified,
              style: Theme.of(context).textTheme.bodySmall,
            ),
    );
  }
}
