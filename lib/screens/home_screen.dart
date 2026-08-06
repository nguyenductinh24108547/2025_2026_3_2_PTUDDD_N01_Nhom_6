import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String userName = 'MAI VĂN TÍNH';
  final int totalWords = 10;

  // Controller để quản lý ô nhập liệu tìm kiếm
  final TextEditingController _searchController =
      TextEditingController();

  // Dữ liệu 10 từ vựng chuẩn theo ứng dụng
  final List<Map<String, String>> _allVocabularies = [
    {'term': 'Apple', 'meaning': 'Quả táo', 'type': 'noun'},
    {
      'term': 'Banana',
      'meaning': 'Quả chuối',
      'type': 'noun',
    },
    {'term': 'Cat', 'meaning': 'Con mèo', 'type': 'noun'},
    {'term': 'Dog', 'meaning': 'Con chó', 'type': 'noun'},
    {
      'term': 'Book',
      'meaning': 'Quyển sách',
      'type': 'noun',
    },
    {'term': 'Car', 'meaning': 'Xe ô tô', 'type': 'noun'},
    {'term': 'Sun', 'meaning': 'Mặt trời', 'type': 'noun'},
    {
      'term': 'Water',
      'meaning': 'Nước uống',
      'type': 'noun',
    },
    {
      'term': 'House',
      'meaning': 'Ngôi nhà',
      'type': 'noun',
    },
    {'term': 'Tree', 'meaning': 'Cái cây', 'type': 'noun'},
  ];

  List<Map<String, String>> _filteredWords = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text
        .toLowerCase()
        .trim();
    setState(() {
      if (query.isEmpty) {
        _filteredWords = [];
      } else {
        _filteredWords = _allVocabularies.where((item) {
          final termMatches = item['term']!
              .toLowerCase()
              .contains(query);
          final meaningMatches = item['meaning']!
              .toLowerCase()
              .contains(query);
          return termMatches || meaningMatches;
        }).toList();
      }
    });
  }

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
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.searchHint,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                _searchController.clear(),
                          )
                        : null,
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

              // Danh sách kết quả tìm kiếm (hiển thị khi có từ khóa gõ vào)
              if (_searchController.text.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(
                        0.2,
                      ),
                    ),
                  ),
                  child: _filteredWords.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(
                            16.0,
                          ),
                          child: Center(
                            child: Text(
                              isEn
                                  ? 'No vocabulary found'
                                  : 'Không tìm thấy từ vựng phù hợp',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: _filteredWords.length,
                          separatorBuilder:
                              (context, index) =>
                                  const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final word =
                                _filteredWords[index];
                            return ListTile(
                              leading: const Icon(
                                Icons.translate,
                                color: Colors.blueAccent,
                              ),
                              title: Text(
                                word['term']!,
                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                word['meaning']!,
                              ),
                              trailing: Text(
                                word['type']!,
                                style: TextStyle(
                                  color:
                                      Colors.grey.shade500,
                                  fontStyle:
                                      FontStyle.italic,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],

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
                  // Flashcard
                  _buildMenuCard(
                    context,
                    Icons.style,
                    'Flashcard',
                    isEn
                        ? 'Learn vocabulary'
                        : 'Học từ vựng',
                    Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FlashcardScreen(),
                        ),
                      );
                    },
                  ),
                  // Trắc nghiệm
                  _buildMenuCard(
                    context,
                    Icons.quiz,
                    isEn ? 'Quiz' : 'Trắc nghiệm',
                    isEn
                        ? 'Quick practice'
                        : 'Luyện tập nhanh',
                    Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const QuizScreen(),
                        ),
                      );
                    },
                  ),
                  // Xếp hạng
                  _buildMenuCard(
                    context,
                    Icons.leaderboard,
                    isEn ? 'Leaderboard' : 'Xếp hạng',
                    isEn
                        ? 'Group competition'
                        : 'Thi đua nhóm',
                    Colors.purple,
                    onTap: () {
                      _showLeaderboardDialog(context, isEn);
                    },
                  ),
                  // Thống kê
                  _buildMenuCard(
                    context,
                    Icons.analytics,
                    isEn ? 'Statistics' : 'Thống kê',
                    isEn
                        ? 'Learning progress'
                        : 'Tiến độ học tập',
                    Colors.teal,
                    onTap: () {
                      _showStatisticsDialog(context, isEn);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị ô Shortcut
  Widget _buildMenuCard(
    BuildContext context,
    IconData icon,
    String title,
    String desc,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
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
        ),
      ),
    );
  }

  // Hộp thoại Xếp hạng thi đua
  void _showLeaderboardDialog(
    BuildContext context,
    bool isEn,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          isEn
              ? 'Group Leaderboard'
              : 'Bảng Xếp Hạng Nhóm 6',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              leading: Text(
                '🥇',
                style: TextStyle(fontSize: 22),
              ),
              title: Text('Mai Anh Tú'),
              trailing: Text(
                '100 pts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                '🥈',
                style: TextStyle(fontSize: 22),
              ),
              title: Text('Lê Văn Hoàn'),
              trailing: Text(
                '80 pts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                '🥉',
                style: TextStyle(fontSize: 22),
              ),
              title: Text('Nguyễn Đức Tính'),
              trailing: Text(
                '70 pts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isEn ? 'Close' : 'Đóng'),
          ),
        ],
      ),
    );
  }

  // Hộp thoại Thống kê lịch sử học
  void _showStatisticsDialog(
    BuildContext context,
    bool isEn,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return ValueListenableBuilder<int>(
          valueListenable: scoreNotifier,
          builder: (context, currentScore, child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                isEn
                    ? 'Learning Statistics'
                    : 'Lịch Sử & Thống Kê',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    isEn
                        ? 'Total correct answers saved:'
                        : 'Số câu trả lời đúng đã lưu:',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$currentScore / $totalWords ${isEn ? "words" : "câu"}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isEn
                        ? 'Accuracy Rate: ${(currentScore / totalWords * 100).toInt()}%'
                        : 'Tỷ lệ hoàn thành: ${(currentScore / totalWords * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(isEn ? 'Close' : 'Đóng'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
