import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../cores/constants/app_color.dart';
import '../../../cores/routing/app_route.dart';
import 'blocs/news/news_bloc.dart';
import 'cubits/cubit/shrimp_news_cubit.dart';
import 'widgets/news_container.dart';

class ShrimpNewsTab extends StatefulWidget {
  const ShrimpNewsTab({super.key});

  @override
  State<ShrimpNewsTab> createState() => _ShrimpNewsTabState();
}

class _ShrimpNewsTabState extends State<ShrimpNewsTab> {
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
        var state = context.read<ShrimpNewsCubit>().state;
        if (state.isLoading == false) {
          context.read<NewsBloc>().add(NewsGetEvent(
                page: (state.meta?.currentPage ?? 0) + 1,
                perPage: 15,
              ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocListener<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is NewsLoadingState) {
          context.read<ShrimpNewsCubit>().updateLoadingTrue();
        }
        if (state is NewsSuccessState) {
          context.read<ShrimpNewsCubit>().updateShrimpNews(
                page: state.metaData?.currentPage ?? 1,
                news: state.data,
                metaData: state.metaData,
              );
        }
        if (state is NewsFailureState) {
          context.read<ShrimpNewsCubit>().updateErrorTrue();
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
                t.lblLatestNews,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: clrBlue00),
              ),
            ),
            BlocBuilder<ShrimpNewsCubit, ShrimpNewsState>(
              builder: (context, state) {
                if (state.news.isEmpty) {
                  if (state.isLoading) {
                    return _loadingWidget(state.news.isEmpty);
                  }
                  return _emptyWidget(t);
                }
                final bool isLastPage = state.meta?.currentPage == state.meta?.lastPage;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.news.length + (isLastPage ? 0 : 1),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == state.news.length) {
                      if (state.isError) {
                        return Center(
                          child: _errorWidget(t, state.news.isEmpty),
                        );
                      }
                      return _loadingWidget(state.news.isEmpty);
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: NewsContainer(
                        imageUrl: "https://app.jala.tech/storage/${state.news[index].image ?? ''}",
                        shareLink: "https://app.jala.tech/posts/${state.news[index].id}",
                        title: state.news[index].title ?? '-',
                        body: state.news[index].body ?? '-',
                        date: state.news[index].createdAt ?? '-',
                        onTap: () {
                          context.goNamed(AppRoute.shrimpNews, pathParameters: {
                            "id": state.news[index].id != null ? state.news[index].id.toString() : ""
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
            var state = context.read<ShrimpNewsCubit>().state;
            context.read<NewsBloc>().add(NewsGetEvent(
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
