import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? selectedDate;
  final Function()? onTap;

  const SectionHeader({
    required this.title,
    this.selectedDate,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // My Project header
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const Spacer(),

        // Picked date shows
        if (selectedDate != null) // Ensure selectedDate is not null
          Text(selectedDate!),
        const SizedBox(width: 8),

        // Custom add button
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
