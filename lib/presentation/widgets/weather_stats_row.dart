import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherStatsRow extends StatelessWidget {
  const WeatherStatsRow({super.key, required this.weather});

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    final stats = <_StatItem>[
      _StatItem('Humidity', '${weather.humidity}%', Icons.water_drop_rounded),
      _StatItem('Wind', '${weather.windSpeed.round()} km/h', Icons.air_rounded),
      _StatItem('Pressure', '${weather.pressure.round()} hPa', Icons.speed_rounded),
      _StatItem(
        'Visibility',
        '${(weather.visibility / 1000).toStringAsFixed(1)} km',
        Icons.visibility_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 380;
        return GridView.count(
          crossAxisCount: isNarrow ? 2 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isNarrow ? 1.8 : 1.15,
          children: stats.map((s) => _StatCard(item: s)).toList(),
        );
      },
    );
  }
}

class _StatItem {
  const _StatItem(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});
  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: AppColors.skyBlue, size: 22),
            const SizedBox(height: 8),
            Text(
              item.value,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              item.label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
