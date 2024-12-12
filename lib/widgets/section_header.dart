import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? selectedDate;
  final Function()? onTap;
  final bool showButton;

  const SectionHeader({
    required this.title,
    this.selectedDate,
    this.onTap,
    this.showButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title header
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),

        // Display selected date if provided
        if (selectedDate != null) Text(selectedDate!),
        const SizedBox(width: 8),

        // Optional custom add button
        if (showButton)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFF754BE5),
              ),
            ),
          ),
      ],
    );
  }
}
