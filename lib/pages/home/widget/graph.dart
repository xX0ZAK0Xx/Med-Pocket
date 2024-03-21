import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/styles/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  const Graph({
    super.key,
  });

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: false, );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
      primaryXAxis: const CategoryAxis(
        autoScrollingDelta: 8,
        autoScrollingMode: AutoScrollingMode.end,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <ColumnSeries<dynamic, String>>[
        ColumnSeries<dynamic, String>(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15) ),
          gradient: redGradient(),
          width: 0.1,
          dataSource: DataList.allBMI,
          xValueMapper: (data, _) => data[0],
          yValueMapper: (data, _) => data[1],
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    ));
  }
}
