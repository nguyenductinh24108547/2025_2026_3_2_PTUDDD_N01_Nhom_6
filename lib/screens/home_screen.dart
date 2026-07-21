import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Khai báo thông tin người dùng
  final String userName = 'MAI VĂN TÍNH';

  // Khai báo số từ vựng để tự động tính toán tiến độ học tập
  final int totalWords = 10;
  final int completedWords = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền xám nhạt hiện đại giúp nổi bật các thẻ bên trong
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Phần thông tin tài khoản và Avatar
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chào ngày mới, 👋',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                  // Avatar người dùng với viền màu xanh
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Thanh tìm kiếm từ vựng (Sử dụng TextField cơ bản kết hợp đổ bóng nhẹ)
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm từ vựng, chủ đề...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. Banner hiển thị tiến độ học tập trong ngày (Sử dụng dải màu chuyển sắc)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF1D4ED8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tiến độ học hôm nay',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Công thức tự động tính toán tỷ lệ phần trăm thực tế
                    Text(
                      'Đã hoàn thành ${((completedWords / totalWords) * 100).toInt()}% ($completedWords/$totalWords từ)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      child: LinearProgressIndicator(
                        value: completedWords / totalWords,
                        backgroundColor: Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation<
                              Color
                            >(Colors.white),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 4. Tiêu đề danh mục lối tắt
              const Text(
                'Lối tắt học tập',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),

              // 5. Grid phân bổ các tính năng chính của ứng dụng
              GridView.count(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:
                    1.4, // Tỷ lệ tối ưu hiển thị cân đối trên cả Web và Mobile
                children: [
                  _buildMenuCard(
                    Icons.style,
                    'Flashcard',
                    'Học từ vựng',
                    Colors.orange,
                  ),
                  _buildMenuCard(
                    Icons.quiz,
                    'Trắc nghiệm',
                    'Luyện tập nhanh',
                    Colors.green,
                  ),
                  _buildMenuCard(
                    Icons.leaderboard,
                    'Xếp hạng',
                    'Thi đua nhóm',
                    Colors.purple,
                  ),
                  _buildMenuCard(
                    Icons.analytics,
                    'Thống kê',
                    'Tiến độ học tập',
                    Colors.teal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm bổ trợ thiết kế các ô chức năng (Được đặt trong class HomeScreen)
  Widget _buildMenuCard(
    IconData icon,
    String title,
    String desc,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Vòng tròn màu nền mờ bao quanh icon tạo điểm nhấn thiết kế phẳng
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
