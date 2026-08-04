import 'package:flutter/material.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> members = [
      {
        'name': 'Mai Anh Tú',
        'role': 'Trưởng nhóm',
        'task': 'Thiết kế giao diện chính, Quản lý BottomNavigationBar',
      },
      {
        'name': 'Lê Văn Hoàn',
        'role': 'Thành viên',
        'task': 'Màn hình Học Flashcard, Thông tin nhóm, Dummy Data',
      },
      {
        'name': 'Nguyễn Đức Tính',
        'role': 'Thành viên',
        'task': 'Màn hình Trắc nghiệm/Ôn tập, Xử lý logic điểm số',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Thông Tin Nhóm'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            const Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.groups, size: 50, color: Colors.white),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Text(
                          'NHÓM 6 - PTUDDD',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ứng dụng Quản lý & Học từ vựng',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Danh sách thành viên:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${index + 1}')),
                      title: Text(
                        member['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAlignment.start,
                        children: [
                          Text('Vai trò: ${member['role']}'),
                          Text('Nhiệm vụ: ${member['task']}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
