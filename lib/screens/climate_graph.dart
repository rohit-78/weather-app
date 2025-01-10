import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import '../providers/climate_provider.dart';

class ClimateGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClimateDataProvider>(context);
    // Show a loading indicator while data is being fetched
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show a message when no data is available
    if (provider.climateData.isEmpty) {
      return const Center(
        child: Text(
          'No Data Found',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    // Generate month labels dynamically
    final monthLabels = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    List<ChartData> chartData = [];

    // Prepare the data for the chart by extracting monthly temperatures
    for (var data in provider.climateData) {
      for (int i = 0; i < monthLabels.length; i++) {
        final month = monthLabels[i];
        final temperature = data.monthlyTemperatures[month]?.toDouble() ?? 0.0;

        chartData.add(
          ChartData(
            month: month,
            temperature: temperature,
          ),
        );
      }
    }

    // Return the chart widget wrapped in a SingleChildScrollView to allow horizontal scrolling
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Months'),
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Temperature (°C)'),
          minimum: 0,
          maximum: 50, // Customize the axis range according to your data
        ),
        title: ChartTitle(text: 'Monthly Climate Data'),
        series: <CartesianSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.temperature,
            color: Colors.blue.withOpacity(0.7),
            markerSettings: MarkerSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

// Model class for holding chart data
class ChartData {
  final String month;
  final double temperature;

  ChartData({required this.month, required this.temperature});
}
