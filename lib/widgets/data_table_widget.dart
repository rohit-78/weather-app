import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/climate_provider.dart';

class ClimateDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClimateDataProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.climateData.isEmpty) {
      return const Center(
        child: Text(
          'No Data Found',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: double.infinity, // To allow vertical scrolling
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Fixed Year Column
                Container(
                  color: Colors.teal[100],
                  child: DataTable(
                    columnSpacing: 25,
                    headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) => Colors.teal[100],
                    ),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Year',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: provider.climateData.map((data) {
                      return DataRow(
                        cells: [
                          DataCell(Text(data.year.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // Scrollable Data Columns
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: DataTable(
                      columnSpacing: 25,
                      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => Colors.teal[100],
                      ),
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columns: const [
                        DataColumn(label: Text('Jan')),
                        DataColumn(label: Text('Feb')),
                        DataColumn(label: Text('Mar')),
                        DataColumn(label: Text('Apr')),
                        DataColumn(label: Text('May')),
                        DataColumn(label: Text('Jun')),
                        DataColumn(label: Text('Jul')),
                        DataColumn(label: Text('Aug')),
                        DataColumn(label: Text('Sep')),
                        DataColumn(label: Text('Oct')),
                        DataColumn(label: Text('Nov')),
                        DataColumn(label: Text('Dec')),
                        DataColumn(label: Text('Winter')),
                        DataColumn(label: Text('Spring')),
                        DataColumn(label: Text('Summer')),
                        DataColumn(label: Text('Autumn')),
                        DataColumn(label: Text('Annual')),
                      ],
                      rows: provider.climateData.map((data) {
                        return DataRow(
                          cells: [
                            DataCell(Text(data.monthlyTemperatures['Jan']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Feb']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Mar']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Apr']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['May']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Jun']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Jul']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Aug']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Sep']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Oct']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Nov']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.monthlyTemperatures['Dec']?.toStringAsFixed(1) ?? '')),
                            DataCell(Text(data.winterTotal.toStringAsFixed(1))),
                            DataCell(Text(data.springTotal.toStringAsFixed(1))),
                            DataCell(Text(data.summerTotal.toStringAsFixed(1))),
                            DataCell(Text(data.autumnTotal.toStringAsFixed(1))),
                            DataCell(Text(data.annualTotal.toStringAsFixed(1))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
