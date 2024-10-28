import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardStaff extends StatefulWidget {
  const DashboardStaff({super.key});

  @override
  State<DashboardStaff> createState() => _DashboardStaffState();
}

class _DashboardStaffState extends State<DashboardStaff> {
  int freeRooms = 2;
  int reservedRooms = 3;
  int pendingRooms = 6;
  int disableRooms = 3;

  @override
  Widget build(BuildContext context) {
    int totalRooms = freeRooms + reservedRooms + pendingRooms + disableRooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SLOT STATUS'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 300, // ขยายขนาดของ PieChart
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 50, 
                    sections: [
                      PieChartSectionData(
                        color: const Color(0xFFE34034), // สีสำหรับ RESERVED
                        value: reservedRooms.toDouble(),
                        title: '',
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        badgeWidget: _buildBadge('RESERVED', reservedRooms),
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFFFCB30), // สีสำหรับ PENDING
                        value: pendingRooms.toDouble(),
                        title: '',
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        badgeWidget: _buildBadge('PENDING', pendingRooms),
                      ),
                      PieChartSectionData(
                        color: const Color(0xFFBCBCBC), // สีสำหรับ DISABLE
                        value: disableRooms.toDouble(),
                        title: '',
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        badgeWidget: _buildBadge('DISABLE', disableRooms),
                      ),
                      PieChartSectionData(
                        color: const Color(0xFF3166B7), // สีสำหรับ FREE
                        value: freeRooms.toDouble(),
                        title: '',
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        badgeWidget: _buildBadge('FREE', freeRooms),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Total: $totalRooms', style: const TextStyle(fontSize: 18)),
              
              // แสดงสัญลักษณ์สีและข้อความ
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend(Color(0xFF3166B7), "FREE"),
                  const SizedBox(width: 10),
                  _buildLegend(Color(0xFFE34034), "RESERVED"),
                  const SizedBox(width: 10),
                  _buildLegend(Color(0xFFFFCB30), "PENDING"),
                  const SizedBox(width: 10),
                  _buildLegend(Color(0xFFBCBCBC), "DISABLE"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างสัญลักษณ์และข้อความ
  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBadge(String title, int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
