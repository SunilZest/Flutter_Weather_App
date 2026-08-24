import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/weather_code_mapper.dart';
import '../../domain/entities/hourly_forecast_entity.dart';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({super.key, required this.hourly});

  final List<HourlyForecastEntity> hourly;

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = hourly[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 300 + index * 40),
            curve: Curves.easeOut,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 12),
                child: child,
              ),
            ),
            child: _HourlyTile(item: item, isNow: index == 0),
          );
        },
      ),
    );
  }
}

class _HourlyTile extends StatelessWidget {
  const _HourlyTile({required this.item, required this.isNow});

  final HourlyForecastEntity item;
  final bool isNow;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
      decoration: BoxDecoration(
        color: isNow
            ? AppColors.pink.withValues(alpha: 0.12)
            : Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: isNow ? Border.all(color: AppColors.pink, width: 1.2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isNow ? 'Now' : DateFormatter.hourLabel(item.time),
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: isNow ? FontWeight.w700 : FontWeight.w500,
              color: isNow
                  ? AppColors.pink
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
          ),
          Text(
            WeatherCodeMapper.icon(item.weatherCode, isDay: item.isDay),
            style: const TextStyle(fontSize: 26),
          ),
          Text(
            '${item.temperature.round()}°',
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
