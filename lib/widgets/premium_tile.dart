import 'package:flutter/material.dart';
import 'package:ladder_up/pages/premium_upgrade_page%20.dart';

class PremiumTile extends StatefulWidget {
  const PremiumTile({super.key});

  @override
  State<PremiumTile> createState() => _PremiumTileState();
}

class _PremiumTileState extends State<PremiumTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const PremiumUpgradeScreen();
            },
          ));
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          // Gradient background with depth
          gradient: LinearGradient(
            colors: [
              const Color(0xFF754BE5).withValues(alpha: 0.9),
              const Color(0xFFF83EFF).withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          // Subtle shadow for depth
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Sparkle effect elements
            Positioned(
              top: -10,
              right: -10,
              child: Opacity(
                opacity: 0.5,
                child: Icon(
                  Icons.star,
                  color: Colors.white.withValues(alpha: 0.3),
                  size: 50,
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              left: -10,
              child: Opacity(
                opacity: 0.5,
                child: Icon(
                  Icons.star,
                  color: Colors.white.withOpacity(0.3),
                  size: 30,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Text Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upgrade to Progress Premium',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+ No ads!',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '+ Unlock advanced features',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Crown Icon with a glow effect
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/icons/ic_crown.png',
                      width: 64,
                      height: 64,
                    ),
                  ),

                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
