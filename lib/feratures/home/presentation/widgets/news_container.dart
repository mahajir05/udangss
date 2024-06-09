import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../cores/constants/app_color.dart';
import '../../../../cores/utils/app_util.dart';

class NewsContainer extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? body;
  final String? date;
  final String shareLink;
  final Function() onTap;
  const NewsContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.body,
    required this.date,
    required this.shareLink,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: clrGreyE5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const SizedBox(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "-",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body ?? "-",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: clrBlack73,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date ?? "-",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: clrBlack73,
                            ),
                      ),
                      IconButton(
                        onPressed: () {
                          AppUtils.share(shareLink);
                        },
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
