import 'package:flutter/material.dart';

class SettingScreens extends StatefulWidget {
  const SettingScreens({super.key});

  @override
  State<SettingScreens> createState() => _SettingScreensState();
}

class _SettingScreensState extends State<SettingScreens> {
  bool isDarkMode = false;
  bool isEnglish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chế độ tối (Dark Mode)',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ],
            ),

            // Đường kẻ ngang phân cách
            const Divider(height: 40, thickness: 1, color: Colors.grey),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEnglish ? 'Ngôn ngữ: Tiếng Anh' : 'Ngôn ngữ: Tiếng Việt',
                  style: const TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isEnglish,
                  activeThumbColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      isEnglish = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
