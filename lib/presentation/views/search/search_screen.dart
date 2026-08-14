import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_event.dart';
import '../../widgets/search_bar_widget.dart';

/// Full-screen city search with quick-access chips for popular cities.
/// Reachable from the home screen's search icon; also usable standalone.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void _search(BuildContext context, String query) {
    context.read<WeatherBloc>().add(SearchWeather(query));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search city')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(onSubmitted: (q) => _search(context, q)),
            const SizedBox(height: 24),
            Text(
              'Popular cities',
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppConstants.popularCities.map((city) {
                return ActionChip(
                  label: Text(city, style: GoogleFonts.poppins(fontSize: 13)),
                  backgroundColor: AppColors.skyBlue.withValues(alpha: 0.1),
                  side: BorderSide.none,
                  onPressed: () => _search(context, city),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
