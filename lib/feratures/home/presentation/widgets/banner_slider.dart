import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  final List<String> banners;
  const BannerSlider({super.key, this.banners = const []});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late ScrollController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.banners
              .map((e) => Container(
                    height: 100,
                    margin: const EdgeInsets.only(left: 24),
                    child: Image.asset(e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
