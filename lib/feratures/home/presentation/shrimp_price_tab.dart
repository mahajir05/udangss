import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../cores/constants/app_color.dart';
import '../../../cores/constants/assets.dart';
import '../../../cores/widgets/main_textfield.dart';
import '../domain/entities/region_entity.dart';
import 'blocs/regions/regions_bloc.dart';
import 'blocs/shrimp_price/shrimp_price_bloc.dart';
import 'cubits/filter/filter_cubit.dart';
import 'cubits/shrimp_prices/shrimp_prices_cubit.dart';
import 'widgets/banner_slider.dart';
import 'widgets/latest_price_container.dart';

class ShrimpPriceTab extends StatefulWidget {
  const ShrimpPriceTab({super.key});

  @override
  State<ShrimpPriceTab> createState() => _ShrimpPriceTabState();
}

class _ShrimpPriceTabState extends State<ShrimpPriceTab> {
  List<String> banners = [imgAskJaliBanner, imgQuizByJalaBanner];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final maxOffset = _scrollController.position.maxScrollExtent;
      final isOutOfRange = _scrollController.position.outOfRange;

      final hasReachedTheEnd = offset >= (maxOffset - 112) && !isOutOfRange;
      if (hasReachedTheEnd) {
        var state = context.read<ShrimpPricesCubit>().state;
        if (state.isLoading == false) {
          context.read<ShrimpPriceBloc>().add(ShrimpPriceGetEvent(
                page: (state.meta?.currentPage ?? 0) + 1,
                regionId: state.regionId,
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        BlocListener<ShrimpPriceBloc, ShrimpPriceState>(
          listener: (context, state) {
            if (state is ShrimpPriceLoadingState) {
              if (state.isReset) {
                context.read<ShrimpPricesCubit>().resetShrimpPrice();
              }
              context.read<ShrimpPricesCubit>().updateLoadingTrue();
            }
            if (state is ShrimpPriceSuccessState) {
              context.read<ShrimpPricesCubit>().updateShrimpPrice(
                    page: state.metaData?.currentPage ?? 1,
                    shrimpPrices: state.data,
                    metaData: state.metaData,
                    regionId: state.regionId,
                  );
            }
            if (state is ShrimpPriceFailureState) {
              context.read<ShrimpPricesCubit>().updateErrorTrue();
            }
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: Text(
                          t.lblTryOtherFeatures,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 4),
                      BannerSlider(
                        banners: banners,
                      ),
                    ],
                  ),
                  Container(
                    height: 4,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(
                      t.lblLatestPrice,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: clrBlue00),
                    ),
                  ),
                  BlocBuilder<ShrimpPricesCubit, ShrimpPricesState>(
                    builder: (context, state) {
                      if (state.shrimpPrices.isEmpty) {
                        if (state.isLoading) {
                          return _loadingWidget(state.shrimpPrices.isEmpty);
                        }
                        return _emptyWidget(t);
                      }
                      final bool isLastPage = state.meta?.currentPage == state.meta?.lastPage;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.shrimpPrices.length + (isLastPage ? 0 : 1),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == state.shrimpPrices.length) {
                            if (state.isError) {
                              return Center(
                                child: _errorWidget(t, state.shrimpPrices.isEmpty),
                              );
                            }
                            return _loadingWidget(state.shrimpPrices.isEmpty);
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            child: LatestPriceContainer(
                              shrimpPriceEntity: state.shrimpPrices[index],
                              size: state.size,
                              regionId: state.regionId,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buttonFilter(context, t),
          ),
        ],
      ),
    );
  }

  SizedBox _emptyWidget(AppLocalizations t) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            t.lblEmptyData,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Column _loadingWidget(bool isInit) {
    return Column(
      children: (isInit ? [1, 2, 3, 4, 5] : [1, 2])
          .map((e) => Shimmer.fromColors(
                baseColor: clrGreyShimmerBase,
                highlightColor: clrGreyShimmerHighlight,
                child: Container(
                  height: 64,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _errorWidget(AppLocalizations t, bool isInit) {
    if (isInit) {
      return SizedBox(
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              t.lblErrorFetchingData,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const SizedBox(
              height: 4,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.lblErrorFetchingData,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        IconButton(
          onPressed: () {
            var state = context.read<ShrimpPricesCubit>().state;
            context.read<ShrimpPriceBloc>().add(ShrimpPriceGetEvent(
                  page: (state.meta?.currentPage ?? 0) + 1,
                  regionId: state.regionId,
                ));
          },
          icon: const Icon(Icons.refresh),
          iconSize: 16,
        ),
      ],
    );
  }

  Container _buttonFilter(BuildContext context, AppLocalizations t) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _sizeBottomSheet().then((value) {
                if (value != null) {
                  context.read<ShrimpPricesCubit>().updateSize(value);
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: clrBlue00,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.balance,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Size",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        "${context.watch<ShrimpPricesCubit>().state.size}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                _regionBottomSheet(context, t).then((value) {
                  if (value != null) {
                    context.read<FilterCubit>().selectRegion(value);
                    context.read<ShrimpPriceBloc>().add(ShrimpPriceGetEvent(
                          page: 1,
                          regionId: int.tryParse(value.id ?? ""),
                          isReset: true,
                        ));
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: clrBlue,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            context.watch<FilterCubit>().state.selectedRegion?.fullName ?? "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<int?> _sizeBottomSheet() {
    List<int> size = List.generate(21, (index) => index * 10);
    size.removeRange(0, 2);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: clrWhite,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Size",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: size
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            context.pop(e);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Text("$e"),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<RegionEntity?> _regionBottomSheet(BuildContext context, AppLocalizations t) {
    return showModalBottomSheet<RegionEntity?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: clrWhite,
      builder: (_) {
        return SizedBox(
          height: 480,
          child: BlocProvider.value(
            value: context.read<RegionsBloc>(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.lblCityOrDistrict,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            t.lblClose,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: clrBlue),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: MainTextField(
                      prefixIcon: const Icon(Icons.search),
                      hintText: t.lblSearch,
                      onFieldSubmitted: (val) {
                        context.read<RegionsBloc>().add(RegionsSearchEvent(keyword: val));
                      },
                    ),
                  ),
                  const Divider(height: 33),
                  Expanded(
                    child: BlocBuilder<RegionsBloc, RegionsState>(
                      builder: (context, state) {
                        if (state is RegionsLoadingState) {
                          return _loadingWidget(false);
                        }
                        if (state is RegionsSuccessState) {
                          return ListView.builder(
                            itemCount: state.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                title: Text(
                                  state.data[index].fullName ?? "-",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                onTap: () => context.pop(state.data[index]),
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
