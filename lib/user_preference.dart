import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  late AppTheme selectedTheme;
  late AppLanguage selectedLanguage;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    selectedTheme = appState.theme;
    selectedLanguage = appState.language;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
              _buildLabel(appState.language == AppLanguage.english ? 'Choose Theme' : 'Piliin ang Tema'),
              _buildThemeDropdown(),
              const SizedBox(height: 20),
              _buildLabel(appState.language == AppLanguage.english ? 'Choose Language' : 'Piliin ang Wika'),
              _buildLanguageDropdown(),
              const SizedBox(height: 28),
              _buildButtons(appState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildThemeDropdown() {
    return DropdownButtonFormField<AppTheme>(
      value: selectedTheme,
      items: AppTheme.values.map((theme) {
        return DropdownMenuItem(
          value: theme,
          child: Text(theme == AppTheme.roseBud ? 'Rose Bud' : 'Sandwisp'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedTheme = value;
          });
        }
      },
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButtonFormField<AppLanguage>(
      value: selectedLanguage,
      items: AppLanguage.values.map((lang) {
        return DropdownMenuItem(
          value: lang,
          child: Text(lang == AppLanguage.filipino ? 'Filipino' : 'English'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedLanguage = value;
          });
        }
      },
    );
  }

  Widget _buildButtons(AppState appState) {
    return Row(
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
              theme: selectedTheme,
              language: selectedLanguage,
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF729F)),
          child: const Text('SAVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
