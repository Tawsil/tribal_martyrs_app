import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tribal_martyrs_app/shared/widgets/search_bar.dart'; // يحتوي الآن على CustomSearchBar

class DataViewerScreen extends StatefulWidget {
  final String category;
  final String title;

  const DataViewerScreen({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  State<DataViewerScreen> createState() => _DataViewerScreenState();
}

class _DataViewerScreenState extends State<DataViewerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSearchBar( // ← تم التغيير هنا
            controller: _searchController,
            onSearch: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(widget.category)
                .where('name', isGreaterThanOrEqualTo: _searchQuery)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('لا توجد بيانات'));
              }

              final data = snapshot.data!.docs;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('الاسم')),
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('التفاصيل')),
                    ],
                    rows: data.map((doc) {
                      final d = doc.data() as Map<String, dynamic>;
                      return DataRow(
                        cells: [
                          DataCell(Text(d['name'] ?? '')),
                          DataCell(Text(d['date'] ?? '')),
                          DataCell(
                            TextButton(
                              onPressed: () {
                                // عرض التفاصيل الكاملة
                              },
                              child: const Text('عرض'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}