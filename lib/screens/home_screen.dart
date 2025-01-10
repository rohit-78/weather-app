import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/climate_provider.dart';
import '../widgets/data_table_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedRegion;
  String? selectedParameter;
  final List<String> region = [
    'UK',
    'England',
    'Wales',
    'Scotland',
    'Northern Ireland',
    'England & Wales',
    'England N',
    'England S',
    'Scotland N',
    'Scotland E',
    'Scotland W',
    'England E & NE',
    'England NW/Wales N',
    'Midlands',
    'East Anglia',
    'England SW/Wales S',
    'England SE/Central S'
  ];
  final List<String> parameter = [
    'Tmax',
    'Tmin',
    'Tmean',
    'Sunshine',
    'Rainfall',
    'Raindays1mm',
    'AirFrost',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'HomeScreen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Region', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                    border: Border.all(width: 0.5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: SizedBox(
                      child: DropdownButton<String>(
                        value: selectedRegion,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Region',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                        iconSize: 30,
                        dropdownColor: Colors.teal[50],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        items: region.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRegion = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Parameter', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                    border: Border.all(width: 0.5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: SizedBox(
                      child: DropdownButton<String>(
                        value: selectedParameter,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Parameter',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                        iconSize: 30,
                        dropdownColor: Colors.teal[50],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        items: parameter.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedParameter = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (selectedRegion == null || selectedParameter == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select both Region and Parameter'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    Provider.of<ClimateDataProvider>(context, listen: false)
                        .fetchClimateData(selectedParameter!, selectedRegion!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('Submit'),
              ),
            Expanded(child: ClimateDataTable()),
          ],
        ),
      ),
    );
  }
}
