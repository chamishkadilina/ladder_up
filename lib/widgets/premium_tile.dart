import 'package:flutter/material.dart';

class PremiumTile extends StatelessWidget {
  const PremiumTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Outer gradient border
        Container(
          height: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF754BE5),
                Color(0xFFF83EFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Inner solid background container
        Container(
          height: 60,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color(0xFFF1ECFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Image.asset('assets/icons/ic_crown.png', scale: 4),
                const SizedBox(width: 12),
                const Text(
                  'Upgrade to Progress Premium',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
