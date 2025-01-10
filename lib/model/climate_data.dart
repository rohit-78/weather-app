class ClimateData {
  final int year;
  final Map<String, double> monthlyTemperatures;
  final double winterTotal;
  final double springTotal;
  final double summerTotal;
  final double autumnTotal;
  final double annualTotal;

  ClimateData({
    required this.year,
    required this.monthlyTemperatures,
    required this.winterTotal,
    required this.springTotal,
    required this.summerTotal,
    required this.autumnTotal,
    required this.annualTotal,
  });

  factory ClimateData.fromJson(Map<String, dynamic> json) {
    Map<String, double> temperatures = {};
    for (var month in json.keys) {
      if (month != 'year' && month != 'win' && month != 'spr' && month != 'sum' && month != 'aut' && month != 'ann') {
        temperatures[month] = double.tryParse(json[month].toString()) ?? 0.0;
      }
    }
    return ClimateData(
      year: json['year'],
      monthlyTemperatures: temperatures,
      winterTotal: double.tryParse(json['win'].toString()) ?? 0.0,
      springTotal: double.tryParse(json['spr'].toString()) ?? 0.0,
      summerTotal: double.tryParse(json['sum'].toString()) ?? 0.0,
      autumnTotal: double.tryParse(json['aut'].toString()) ?? 0.0,
      annualTotal: double.tryParse(json['ann'].toString()) ?? 0.0,
    );
  }
}
