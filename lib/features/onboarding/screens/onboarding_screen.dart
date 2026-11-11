import 'package:flutter/material.dart';
import 'package:onboarding_screen/core/constants/app_colors.dart';
import 'package:onboarding_screen/core/constants/app_strings.dart';
import 'package:onboarding_screen/core/constants/assets.dart';
import 'package:onboarding_screen/features/home/home_screen.dart';
import 'package:onboarding_screen/features/onboarding/data/items_data.dart';
import 'package:onboarding_screen/features/onboarding/screens/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<ItemsData> itemLists = [];
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
    _addItems();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _moveLastPage() {
    pageController.animateToPage(
      itemLists.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _skipButtonWidget(),
            Expanded(flex: 3, child: _sliderWidget()),
            const SizedBox(height: 28),
            _indicatorWidget(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _skipButtonWidget() {
    final bool isLastPage = currentPage == itemLists.length - 1;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, right: 20),
        child: CustomButton(
          text: isLastPage ? AppStrings.start : AppStrings.skip,
          onTap: () {
            if (isLastPage) {
              _navigateToHome();
            } else {
              _moveLastPage();
            }
          },
        ),
      ),
    );
  }

  Widget _sliderWidget() {
    return PageView.builder(
      controller: pageController,
      itemCount: itemLists.length,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      itemBuilder: (context, index) {
        return _itemWidget(
          image: itemLists[index].image ?? "",
          title: itemLists[index].title ?? "",
          description: itemLists[index].description ?? "",
        );
      },
    );
  }

  Widget _itemWidget({
    required String image,
    required String title,
    required String description,
  }) {
    final bool isFreshImage = image == Assets.freshImage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(isFreshImage ? 20 : 0),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.7),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _addItems() {
    itemLists.addAll([
      ItemsData(
        title: AppStrings.titleFresh,
        description: AppStrings.desFresh,
        image: Assets.freshImage,
      ),
      ItemsData(
        title: AppStrings.titleQuick,
        description: AppStrings.desQuick,
        image: Assets.quickImage,
      ),
      ItemsData(
        title: AppStrings.titleStart,
        description: AppStrings.desStart,
        image: Assets.discoverImage,
      ),
    ]);
  }

  Widget _indicatorWidget() {
    return SmoothPageIndicator(
      controller: pageController,
      count: itemLists.length,
      effect: const WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
        activeDotColor: AppColors.kPrimaryColor,
        dotColor: AppColors.kDotInactiveColor,
      ),
    );
  }
}
