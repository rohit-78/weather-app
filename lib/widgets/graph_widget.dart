import 'package:flutter/material.dart';
import '../screens/climate_graph.dart';
import 'data_table_widget.dart';

class ClimateDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Climate Data'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Table'),
              Tab(text: 'Graph'),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            ClimateDataTable(),
            ClimateGraph(),

          ],
        ),
      ),
    );
  }
}
