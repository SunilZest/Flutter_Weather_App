import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../bloc/weather_state.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.type,
    required this.message,
    required this.onRetry,
  });

  final WeatherErrorType type;
  final String message;
  final VoidCallback onRetry;

  ({IconData icon, String title, String subtitle}) get _content {
    switch (type) {
      case WeatherErrorType.noInternet:
        return (
          icon: Icons.wifi_off_rounded,
          title: 'Unable to fetch weather',
          subtitle: 'Please check your internet connection\nand try again.',
        );
      case WeatherErrorType.locationNotFound:
        return (
          icon: Icons.location_off_rounded,
          title: 'Location not found',
          subtitle: 'We couldn\'t find that city.\nTry a different search.',
        );
      case WeatherErrorType.server:
        return (
          icon: Icons.cloud_off_rounded,
          title: 'Server error',
          subtitle: 'Our weather service is having issues.\nPlease try again shortly.',
        );
      case WeatherErrorType.unknown:
        return (
          icon: Icons.error_outline_rounded,
          title: 'Something went wrong',
          subtitle: message,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _content;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(c.icon, color: AppColors.red, size: 40),
            ),
            const SizedBox(height: 24),
            Text(
              c.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              c.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.lightTextSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
