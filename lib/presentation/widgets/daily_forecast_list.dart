import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/weather_code_mapper.dart';
import '../../domain/entities/daily_forecast_entity.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({super.key, required this.daily});

  final List<DailyForecastEntity> daily;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: List.generate(daily.length, (i) {
            final item = daily[i];
            return Column(
              children: [
                _DailyRow(item: item, index: i),
                if (i != daily.length - 1)
                  Divider(height: 1, indent: 20, endIndent: 20),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _DailyRow extends StatelessWidget {
  const _DailyRow({required this.item, required this.index});

  final DailyForecastEntity item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 250 + index * 60),
      curve: Curves.easeOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(offset: Offset((1 - value) * 20, 0), child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 92,
              child: Text(
                DateFormatter.dayLabel(item.date),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            Text(
              WeatherCodeMapper.icon(item.weatherCode),
              style: const TextStyle(fontSize: 22),
            ),
            const Spacer(),
            if (item.precipitationProbability > 0) ...[
              Icon(Icons.water_drop_rounded, size: 14, color: AppColors.skyBlue),
              const SizedBox(width: 2),
              Text(
                '${item.precipitationProbability}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.skyBlue,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              '${item.maxTemp.round()}°',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14),
            ),
            const SizedBox(width: 6),
            Text(
              '${item.minTemp.round()}°',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
