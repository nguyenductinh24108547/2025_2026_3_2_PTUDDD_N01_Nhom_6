import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String userName = 'MAI VĂN TÍNH';
  final int totalWords = 10;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEn =
        Localizations.localeOf(context).languageCode ==
        'en';
    final cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Thông tin người dùng
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.goodMorning,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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

              // 2. Ô tìm kiếm
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
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
                    hintText: l10n.searchHint,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    filled: true,
                    fillColor: cardBgColor,
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

              // 3. Tiến độ học tập
              ValueListenableBuilder<int>(
                valueListenable: scoreNotifier,
                builder: (context, completedWords, child) {
                  double progressValue =
                      (completedWords / totalWords).clamp(
                        0.0,
                        1.0,
                      );
                  int percentage = (progressValue * 100)
                      .toInt();

                  return Container(
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
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.todayProgress,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isEn
                              ? 'Completed $percentage% ($completedWords/$totalWords words)'
                              : 'Đã hoàn thành $percentage% ($completedWords/$totalWords từ)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progressValue,
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
                  );
                },
              ),
              const SizedBox(height: 28),

              // 4. Các lối tắt
              Text(
                l10n.shortcuts,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  _buildMenuCard(
                    context,
                    Icons.style,
                    'Flashcard',
                    isEn
                        ? 'Learn vocabulary'
                        : 'Học từ vựng',
                    Colors.orange,
                  ),
                  _buildMenuCard(
                    context,
                    Icons.quiz,
                    isEn ? 'Quiz' : 'Trắc nghiệm',
                    isEn
                        ? 'Quick practice'
                        : 'Luyện tập nhanh',
                    Colors.green,
                  ),
                  _buildMenuCard(
                    context,
                    Icons.leaderboard,
                    isEn ? 'Leaderboard' : 'Xếp hạng',
                    isEn
                        ? 'Group competition'
                        : 'Thi đua nhóm',
                    Colors.purple,
                  ),
                  _buildMenuCard(
                    context,
                    Icons.analytics,
                    isEn ? 'Statistics' : 'Thống kê',
                    isEn
                        ? 'Learning progress'
                        : 'Tiến độ học tập',
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

  Widget _buildMenuCard(
    BuildContext context,
    IconData icon,
    String title,
    String desc,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
