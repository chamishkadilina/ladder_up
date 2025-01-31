import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PremiumUpgradeScreen extends StatefulWidget {
  const PremiumUpgradeScreen({super.key});

  @override
  State<PremiumUpgradeScreen> createState() => _PremiumUpgradeScreenState();
}

class _PremiumUpgradeScreenState extends State<PremiumUpgradeScreen> {
  int _selectedPlanIndex = 1;
  int _currentCarouselIndex = 0;

  final List<CarouselItem> _carouselItems = [
    CarouselItem(image: 'assets/banners/ads.png', title: 'Remove all Ads'),
    CarouselItem(
        image: 'assets/banners/projects.png', title: 'Unlimited Projects'),
    CarouselItem(image: 'assets/banners/themes.png', title: 'Premium Themes'),
  ];

  final List<PricingPlan> _plans = [
    PricingPlan(title: 'Monthly', price: 4.99, perDay: 0.16),
    PricingPlan(
      title: 'Annual',
      price: 29.99,
      perDay: 0.05,
      originalPrice: 49.99,
      savings: '44%',
      isAnnual: true,
    ),
    PricingPlan(
      title: 'Permanent',
      price: 99.99,
      originalPrice: 129.99,
      savings: '27%',
      isPermanent: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
              Colors.orange.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upgrade to Premium',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Unlock all features',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 256,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                    ),
                    items: _carouselItems.map((item) {
                      return Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.scaleDown,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Carousel Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _carouselItems.asMap().entries.map((entry) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentCarouselIndex == entry.key
                              ? const Color(0xFF1A237E)
                              : Colors.grey.withValues(alpha: 0.3),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  // Pricing Plans
                  SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        _plans.length,
                        (index) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 0 : 6,
                              right: index == _plans.length - 1 ? 0 : 6,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedPlanIndex = index),
                              child: _PricingCard(
                                plan: _plans[index],
                                isSelected: _selectedPlanIndex == index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // CTA Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade500,
                          Colors.pink.shade500,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        // Handle trial start
                      },
                      minWidth: double.infinity,
                      height: 56,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Start Free Trial',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '7 days free trial, then \$29.99/Year',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('TERMS',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      const Text('|', style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('PRIVACY POLICY',
                            style: TextStyle(color: Colors.grey)),
                      ),
                      const Text('|', style: TextStyle(color: Colors.grey)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('RESTORE',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'After the free trial period, payment will be charged to your account at the confirmation of purchase.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselItem {
  final String image;
  final String title;

  CarouselItem({
    required this.image,
    required this.title,
  });
}

class PricingPlan {
  final String title;
  final double price;
  final double? perDay;
  final double? originalPrice;
  final String? savings;
  final bool isPermanent;
  final bool isAnnual;

  PricingPlan({
    required this.title,
    required this.price,
    this.perDay,
    this.originalPrice,
    this.savings,
    this.isPermanent = false,
    this.isAnnual = false,
  });
}

class _PricingCard extends StatelessWidget {
  final PricingPlan plan;
  final bool isSelected;

  const _PricingCard({
    required this.plan,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            isSelected ? Border.all(color: Colors.redAccent, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (plan.savings != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Save ${plan.savings}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 4),
          Text(
            plan.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (plan.perDay != null) ...[
            const SizedBox(height: 4),
            Text(
              '\$${plan.perDay!.toStringAsFixed(2)}/Day',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.orange,
              ),
            ),
          ],
          const Spacer(),
          Text(
            '\$${plan.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (plan.originalPrice != null)
            Text(
              '\$${plan.originalPrice!.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          if (plan.isPermanent)
            const Text(
              'Billed onetime',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
