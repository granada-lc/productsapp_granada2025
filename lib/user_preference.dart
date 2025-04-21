import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  late String selectedTheme;
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    selectedTheme = appState.theme == AppTheme.dark ? 'Dark' : 'Light';
    selectedLanguage = appState.language == AppLanguage.filipino ? 'Filipino' : 'English';
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: const Color(0xFFFFC1C1),
        elevation: 0,
        title: Text(
          appState.language == AppLanguage.english ? 'User Preferences' : 'Mga Kagustuhan',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F19C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appState.language == AppLanguage.english ? 'Choose Theme' : 'Piliin ang Tema',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedTheme,
                items: ['Dark', 'Light'].map((theme) {
                  return DropdownMenuItem(value: theme, child: Text(theme));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Text(appState.language == AppLanguage.english ? 'Choose Language' : 'Piliin ang Wika',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedLanguage,
                items: ['English', 'Filipino'].map((lang) {
                  return DropdownMenuItem(value: lang, child: Text(lang));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF729F)),
                    child: const Text('CANCEL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appState.updatePreferences(
                        theme: selectedTheme == 'Dark' ? AppTheme.dark : AppTheme.light,
                        language: selectedLanguage == 'Filipino' ? AppLanguage.filipino : AppLanguage.english,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF729F)),
                    child: const Text('SAVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
