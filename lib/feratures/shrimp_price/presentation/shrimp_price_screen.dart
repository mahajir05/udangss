import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:udangss/cores/constants/app_color.dart';
import 'package:udangss/cores/extensions/date_extension.dart';
import 'package:udangss/cores/widgets/main_button.dart';

import '../../../cores/utils/app_util.dart';
import '../../../cores/widgets/verify_label.dart';
import 'blocs/detail_shrimp_price/detail_shrimp_price_bloc.dart';

class ShrimpPriceScreen extends StatelessWidget {
  const ShrimpPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocBuilder<DetailShrimpPriceBloc, DetailShrimpPriceState>(
      builder: (context, state) {
        List<Widget>? actions;
        Widget content1 = const SizedBox();
        Widget content2 = const SizedBox();
        Widget content3 = const SizedBox();
        Widget content4 = const SizedBox();
        Widget content5 = const SizedBox();
        if (state is DetailShrimpPriceLoadingState) {
          content1 = _loadingWidget(
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          );
          content2 = _loadingWidget(
            height: 32,
          );
          content3 = _loadingWidget(
            height: 48,
          );
          content4 = _loadingWidget(
            height: 48,
          );
          content5 = _loadingWidget(
            height: 360,
          );
        }
        if (state is DetailShrimpPriceSuccessState) {
          actions = [
            IconButton(
              onPressed: () {
                AppUtils.share("https://app.jala.tech/shrimp_prices/${state.data.id}");
              },
              icon: const Icon(Icons.share),
            ),
          ];
          content1 = Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.data.region?.provinceName ?? "-",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: clrBlack45,
                      ),
                ),
                Text(
                  state.data.region?.regencyName ?? "-",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: clrBlack73,
                      ),
                ),
              ],
            ),
          );
          content2 = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                state.data.date?.toDateLongMonthStr() ?? '-',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: clrBlack73,
                    ),
              ),
              const SizedBox(width: 12),
              VerifyLabel(isVerified: state.data.creator?.buyer ?? false),
            ],
          );
          content3 = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: "https://app.jala.tech/storage/${state.data.creator?.avatar}",
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
                      state.data.creator?.occupation ?? '-',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: clrGreyHintA0,
                          ),
                    ),
                    Text(
                      state.data.creator?.name ?? '-',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: clrBlack45,
                          ),
                    ),
                  ],
                ),
              )
            ],
          );
          content4 = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.lblContact,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: clrGreyHintA0,
                          ),
                    ),
                    Text(
                      state.data.creator?.phone ?? '-',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: clrBlack45,
                          ),
                    ),
                  ],
                ),
              ),
              MainButton(
                label: t.lblCall,
                onPressed: () {
                  if (state.data.creator?.phone != null) {
                    AppUtils.phoneCall(state.data.creator!.phone!);
                  }
                },
              ),
            ],
          );
          content5 = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.lblPriceList,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: clrBlack45,
                    ),
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.data.size.keys
                    .map((e) => Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    e,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${state.data.size[e] ?? '-'}",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ))
                    .toList(),
              ),
            ],
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(t.lblShrimpPrice),
            actions: actions,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content1,
                Container(
                  height: 4,
                  width: double.infinity,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content2,
                      const SizedBox(height: 12),
                      content3,
                      const SizedBox(height: 12),
                      content4,
                      const SizedBox(height: 16),
                      content5,
                      const SizedBox(height: 16),
                      Text(
                        t.lblNotes,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Shimmer _loadingWidget({
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return Shimmer.fromColors(
      baseColor: clrGreyShimmerBase,
      highlightColor: clrGreyShimmerHighlight,
      child: Container(
        width: double.infinity,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: clrWhite,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
