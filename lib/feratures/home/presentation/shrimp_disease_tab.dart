import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../cores/constants/app_color.dart';
import '../../../cores/routing/app_route.dart';
import 'blocs/disease/disease_bloc.dart';
import 'cubits/shrimp_disease/shrimp_disease_cubit.dart';
import 'widgets/news_container.dart';

class ShrimpDiseaseTab extends StatefulWidget {
  const ShrimpDiseaseTab({super.key});

  @override
  State<ShrimpDiseaseTab> createState() => _ShrimpDiseaseTabState();
}

class _ShrimpDiseaseTabState extends State<ShrimpDiseaseTab> {
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
        var state = context.read<ShrimpDiseaseCubit>().state;
        if (state.isLoading == false) {
          final bool isLastPage = state.meta?.currentPage == state.meta?.lastPage;
          if (isLastPage != true) {
            context.read<DiseaseBloc>().add(DiseaseGetEvent(
                  page: (state.meta?.currentPage ?? 0) + 1,
                  perPage: 15,
                ));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocListener<DiseaseBloc, DiseaseState>(
      listener: (context, state) {
        if (state is DiseaseLoadingState) {
          context.read<ShrimpDiseaseCubit>().updateLoadingTrue();
        }
        if (state is DiseaseSuccessState) {
          context.read<ShrimpDiseaseCubit>().updateShrimpDisease(
                page: state.metaData?.currentPage ?? 1,
                shrimpDisease: state.data,
                metaData: state.metaData,
              );
        }
        if (state is DiseaseFailureState) {
          context.read<ShrimpDiseaseCubit>().updateErrorTrue();
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                t.lblDiseaseList,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: clrBlue00),
              ),
            ),
            BlocBuilder<ShrimpDiseaseCubit, ShrimpDiseaseState>(
              builder: (context, state) {
                if (state.shrimpDisease.isEmpty) {
                  if (state.isLoading) {
                    return _loadingWidget(state.shrimpDisease.isEmpty);
                  }
                  return _emptyWidget(t);
                }
                final bool isLastPage = state.meta?.currentPage == state.meta?.lastPage;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.shrimpDisease.length + (isLastPage ? 0 : 1),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == state.shrimpDisease.length) {
                      if (state.isError) {
                        return Center(
                          child: _errorWidget(t, state.shrimpDisease.isEmpty),
                        );
                      }
                      return _loadingWidget(state.shrimpDisease.isEmpty);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: NewsContainer(
                        imageUrl: "https://app.jala.tech/storage/${state.shrimpDisease[index].image ?? ''}",
                        shareLink: "https://app.jala.tech/posts/${state.shrimpDisease[index].id}",
                        title: state.shrimpDisease[index].fullName ?? '-',
                        body: state.shrimpDisease[index].metaDescription ?? '-',
                        date: state.shrimpDisease[index].createdAt ?? '-',
                        onTap: () {
                          context.goNamed(AppRoute.shrimpDisease, pathParameters: {
                            "id": state.shrimpDisease[index].id != null ? state.shrimpDisease[index].id.toString() : ""
                          });
                        },
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
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
            var state = context.read<ShrimpDiseaseCubit>().state;
            context.read<DiseaseBloc>().add(DiseaseGetEvent(
                  page: (state.meta?.currentPage ?? 0) + 1,
                  perPage: 15,
                ));
          },
          icon: const Icon(Icons.refresh),
          iconSize: 16,
        ),
      ],
    );
  }
}
