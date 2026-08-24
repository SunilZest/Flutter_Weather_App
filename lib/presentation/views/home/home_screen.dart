import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_event.dart';
import '../../bloc/weather_state.dart';
import '../../viewmodel/theme_viewmodel.dart';
import '../../widgets/current_weather_card.dart';
import '../../widgets/daily_forecast_list.dart';
import '../../widgets/error_view.dart';
import '../../widgets/hourly_forecast_list.dart';
import '../../widgets/loading_view.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/search_bar_widget.dart';
import '../../widgets/section_title.dart';
import '../../widgets/weather_header.dart';
import '../../widgets/weather_stats_row.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(
          const FetchWeather(
            lat: AppConstants.defaultLat,
            lon: AppConstants.defaultLon,
            cityName: AppConstants.defaultCity,
            country: 'India',
          ),
        );
  }

  Future<void> _onRefresh() async {
    context.read<WeatherBloc>().add(const RefreshWeather());
    await context.read<WeatherBloc>().stream.firstWhere(
          (s) => s is WeatherLoaded || s is WeatherError,
        );
  }

  @override
  Widget build(BuildContext context) {
    final themeVm = context.watch<ThemeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WeatherHeader(
                isDark: themeVm.isDark,
                onToggleTheme: () => context.read<ThemeViewModel>().toggleTheme(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SearchBarWidget(
                      onSubmitted: (query) =>
                          context.read<WeatherBloc>().add(SearchWeather(query)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(14),
                        child: Icon(Icons.travel_explore_rounded, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: _buildBody(context, state),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WeatherState state) {
    if (state is WeatherInitial || (state is WeatherLoading && state.previousWeather == null)) {
      return const LoadingView(key: ValueKey('loading'));
    }

    if (state is WeatherError && state.previousWeather == null) {
      return ErrorView(
        key: const ValueKey('error'),
        type: state.type,
        message: state.message,
        onRetry: () => context.read<WeatherBloc>().add(const RefreshWeather()),
      );
    }

    final weather = state is WeatherLoaded
        ? state.weather
        : state is WeatherLoading
            ? state.previousWeather
            : state is WeatherError
                ? state.previousWeather
                : null;

    if (weather == null) {
      return const LoadingView(key: ValueKey('loading-fallback'));
    }

    final isLoading = state is WeatherLoading;

    return RefreshIndicator(
      key: const ValueKey('loaded'),
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state is WeatherError)
              _InlineErrorBanner(message: state.message),
            CurrentWeatherCard(weather: weather),
            const SizedBox(height: 20),
            const SectionTitle('Weather Details'),
            WeatherStatsRow(weather: weather),
            const SizedBox(height: 24),
            const SectionTitle('Hourly Forecast'),
            HourlyForecastList(hourly: weather.hourlyForecast),
            const SizedBox(height: 24),
            const SectionTitle('7-Day Forecast'),
            DailyForecastList(daily: weather.dailyForecast),
            const SizedBox(height: 24),
            RefreshButton(
              isLoading: isLoading,
              onPressed: () => context.read<WeatherBloc>().add(const RefreshWeather()),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _InlineErrorBanner extends StatelessWidget {
  const _InlineErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded,
              color: Theme.of(context).colorScheme.error, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
