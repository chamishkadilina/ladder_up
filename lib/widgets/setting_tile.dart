import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final String? option;
  final bool showArrow;

  const SettingTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.option,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Icon with background color
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 8),
            // Title and Option
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  if (option != null)
                    Text(
                      option!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.blue),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Arrow Icon
            if (showArrow)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
