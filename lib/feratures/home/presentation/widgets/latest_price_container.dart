import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:udangss/cores/extensions/date_extension.dart';
import 'package:udangss/cores/extensions/currency_extension.dart';

import '../../../../cores/constants/app_color.dart';
import '../../../../cores/routing/app_route.dart';
import '../../../../cores/widgets/main_button.dart';
import '../../../../cores/widgets/verify_label.dart';
import '../../domain/entities/shrimp_price_entity.dart';

class LatestPriceContainer extends StatelessWidget {
  final ShrimpPriceEntity? shrimpPriceEntity;
  final int? size;
  final int? regionId;
  const LatestPriceContainer({super.key, this.shrimpPriceEntity, this.size, this.regionId});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: clrGreyE5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "https://app.jala.tech/storage/${shrimpPriceEntity?.creator?.avatar ?? ""}",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      height: 32,
                      width: 32,
                      errorWidget: (context, url, error) => const CircleAvatar(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shrimpPriceEntity?.creator?.occupation ?? "-",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: clrGrey85,
                                ),
                          ),
                          Text(
                            shrimpPriceEntity?.creator?.name ?? "-",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              VerifyLabel(isVerified: shrimpPriceEntity?.creator?.buyer ?? false),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            shrimpPriceEntity?.date?.toDateLongMonthStr() ?? "-",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: clrGrey85,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            shrimpPriceEntity?.region?.provinceName ?? "-",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            shrimpPriceEntity?.region?.regencyName ?? "-",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "size $size",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: clrGrey85,
                          ),
                    ),
                    Text(
                      "${shrimpPriceEntity?.currencyId} ${(shrimpPriceEntity?.size['size_$size'] as int?)?.toIdr()}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              MainButton(
                label: t.lblSeeDetails.toUpperCase(),
                onPressed: () {
                  context.goNamed(
                    AppRoute.shrimpPrice,
                    pathParameters: {
                      "id": "${shrimpPriceEntity?.id}",
                    },
                    extra: {
                      "regionId": regionId,
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
