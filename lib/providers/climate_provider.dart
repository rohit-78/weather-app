import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../model/climate_data.dart';

class ClimateDataProvider with ChangeNotifier {
  List<ClimateData> _climateData = [];
  bool _isLoading = false;

  List<ClimateData> get climateData => _climateData;
  bool get isLoading => _isLoading;

  Future<void> fetchClimateData(String region, String parameter) async {
    final url =
        "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/$region/date/${parameter.replaceAll(' ', '_')}.txt";
    _isLoading = true;
    notifyListeners();
    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = _parseClimateData(response.body);
        print('Fetched Data: $data');
        _climateData = data;
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
        _climateData = [];
      }
    } catch (e) {
      print('Error: $e');
      _climateData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ClimateData> _parseClimateData(String responseBody) {
    final lines = responseBody.split('\n');
    List<ClimateData> parsedData = [];

    for (var i = 8; i < lines.length; i++) {
      final line = lines[i];
      if (line.trim().isEmpty) continue;

      final parts = line.split(RegExp(r'\s+'));
      final year = int.tryParse(parts[0]);
      if (year != null && parts.length >= 17) {
        final monthlyData = {
          'Jan': double.tryParse(parts[1]) ?? 0.0,
          'Feb': double.tryParse(parts[2]) ?? 0.0,
          'Mar': double.tryParse(parts[3]) ?? 0.0,
          'Apr': double.tryParse(parts[4]) ?? 0.0,
          'May': double.tryParse(parts[5]) ?? 0.0,
          'Jun': double.tryParse(parts[6]) ?? 0.0,
          'Jul': double.tryParse(parts[7]) ?? 0.0,
          'Aug': double.tryParse(parts[8]) ?? 0.0,
          'Sep': double.tryParse(parts[9]) ?? 0.0,
          'Oct': double.tryParse(parts[10]) ?? 0.0,
          'Nov': double.tryParse(parts[11]) ?? 0.0,
          'Dec': double.tryParse(parts[12]) ?? 0.0,
        };
        final winterTotal = double.tryParse(parts[13]) ?? 0.0;
        final springTotal = double.tryParse(parts[14]) ?? 0.0;
        final summerTotal = double.tryParse(parts[15]) ?? 0.0;
        final autumnTotal = double.tryParse(parts[16]) ?? 0.0;
        final annualTotal = winterTotal + springTotal + summerTotal + autumnTotal;

        parsedData.add(ClimateData(
          year: year,
          monthlyTemperatures: monthlyData,
          winterTotal: winterTotal,
          springTotal: springTotal,
          summerTotal: summerTotal,
          autumnTotal: autumnTotal,
          annualTotal: annualTotal,
        ));
      }
    }
    return parsedData;
  }
}
