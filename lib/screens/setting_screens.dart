import 'package:flutter/material.dart';

class SettingScreens extends StatefulWidget {
  const SettingScreens({super.key});

  @override
  State<SettingScreens> createState() => _SettingScreensState();
}

class _SettingScreensState extends State<SettingScreens> {
  bool isDarkMode = false;
  bool isNotificationOn = true;
  bool isEnglish = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color cardColor = isDarkMode ? Colors.grey.shade800 : Colors.blue.shade50;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(isEnglish ? 'Settings' : 'Cài đặt'),
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAI VĂN TÍNH',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      isEnglish ? 'Group 2 Member' : 'Thành viên nhóm 2',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            isEnglish ? 'System Preferences' : 'Tùy chỉnh hệ thống',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: Text(
              isEnglish ? 'English Language' : 'Ngôn ngữ Tiếng Anh',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            secondary: const Icon(Icons.language, color: Colors.teal),
            value: isEnglish,
            onChanged: (value) {
              setState(() {
                isEnglish = value;
              });
            },
          ),
          SwitchListTile(
            title: Text(
              isEnglish ? 'Dark Mode' : 'Chế độ ban đêm',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            secondary: const Icon(Icons.dark_mode, color: Colors.indigo),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          SwitchListTile(
            title: Text(
              isEnglish ? 'Notifications' : 'Thông báo học từ vựng',
              style: TextStyle(fontSize: 16, color: textColor),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.green),
            title: Text(
              isEnglish ? 'Group Information' : 'Thông tin nhóm',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
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
    );
  }
}
