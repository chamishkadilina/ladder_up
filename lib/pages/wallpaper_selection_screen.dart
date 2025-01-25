import 'package:flutter/material.dart';
import 'package:ladder_up/providers/setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:ladder_up/services/wallpaper_service.dart';

class WallpaperSelectionScreen extends StatelessWidget {
  const WallpaperSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Select Wallpaper',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: WallpaperService.availableWallpapers.length,
          itemBuilder: (context, index) {
            final wallpaperPath = WallpaperService.availableWallpapers[index];
            final isSelected = wallpaperPath ==
                context.watch<SettingsProvider>().selectedWallpaper;

            return GestureDetector(
              onTap: () {
                context.read<SettingsProvider>().setWallpaper(wallpaperPath);
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? Border.all(
                          color: const Color(0xFF4B6CF5),
                          width: 4,
                        )
                      : null,
                  image: DecorationImage(
                    image: AssetImage(wallpaperPath),
                    fit: BoxFit.fill,
                  ),
                ),
                child: isSelected
                    ? const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF4B6CF5),
                            radius: 12,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
