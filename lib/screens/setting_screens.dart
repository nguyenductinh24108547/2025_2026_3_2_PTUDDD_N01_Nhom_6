import 'package:flutter/material.dart';
import '../main.dart'; // Sử dụng themeNotifier và appLocaleNotifier

class SettingScreens extends StatefulWidget {
  const SettingScreens({super.key});

  @override
  State<SettingScreens> createState() =>
      _SettingScreensState();
}

class _SettingScreensState extends State<SettingScreens> {
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        appLocaleNotifier.value.languageCode == 'en';
    bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEnglish ? 'Settings' : 'Cài đặt'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin người dùng
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MAI VĂN TÍNH',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isEnglish
                            ? 'Group Member'
                            : 'Thành viên nhóm',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Divider(height: 40, thickness: 1),

              // Switch Đổi ngôn ngữ
              SwitchListTile(
                title: Text(
                  isEnglish
                      ? 'English Language'
                      : 'Ngôn ngữ Tiếng Anh',
                  style: const TextStyle(fontSize: 16),
                ),
                secondary: const Icon(
                  Icons.language,
                  color: Colors.teal,
                ),
                value: isEnglish,
                onChanged: (value) {
                  setState(() {
                    appLocaleNotifier.value = value
                        ? const Locale('en')
                        : const Locale('vi');
                  });
                },
              ),

              // Switch Chế độ tối (Đã kích hoạt themeNotifier)
              SwitchListTile(
                title: Text(
                  isEnglish
                      ? 'Dark Mode'
                      : 'Chế độ ban đêm',
                  style: const TextStyle(fontSize: 16),
                ),
                secondary: Icon(
                  Icons.dark_mode,
                  color: isDarkMode
                      ? Colors.amber
                      : Colors.indigo,
                ),
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    themeNotifier.value = value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  });
                },
              ),

              // Switch Thông báo
              SwitchListTile(
                title: Text(
                  isEnglish
                      ? 'Notifications'
                      : 'Thông báo học từ vựng',
                  style: const TextStyle(fontSize: 16),
                ),
                secondary: const Icon(
                  Icons.notifications_active,
                  color: Colors.orange,
                ),
                value: isNotificationOn,
                onChanged: (value) {
                  setState(() {
                    isNotificationOn = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              Text(
                isEnglish ? 'Others' : 'Khác',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              ListTile(
                leading: const Icon(
                  Icons.group,
                  color: Colors.green,
                ),
                title: Text(
                  isEnglish
                      ? 'Group Information'
                      : 'Thông tin nhóm',
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  isEnglish ? 'Logout' : 'Đăng xuất',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
