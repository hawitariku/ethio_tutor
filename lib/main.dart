import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ai_service.dart';
import 'utils/temp_file_cleanup.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Clean old temp files at startup to reduce disk usage
  try {
    final temp = await getTemporaryDirectory();
    await cleanOldTempFiles(temp);
  } catch (_) {}
  
  // Initialize AI service
  final ai = await AIService.fromEnv();
  
  runApp(EthioTutorApp(ai: ai));
}

class EthioTutorApp extends StatefulWidget {
  final AIService ai;

  const EthioTutorApp({super.key, required this.ai});

  @override
  State<EthioTutorApp> createState() => _EthioTutorAppState();
}

class _EthioTutorAppState extends State<EthioTutorApp> {
  final AudioRecorder recorder = AudioRecorder();
  final ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.system);

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // ... (keeping _loadTheme) ...

  // Inside a method where recording starts (Wait, the snippet I saw earlier had recording logic in ChatScreen but main.dart in step 1320 seems different? Ah, the snippet in 1320 shows the class _EthioTutorAppState but NOT the ChatScreen where the recorder was. Let me re-read 1320 completely.
  
  // WAIT. Step 1320 shows `lib/main.dart` contents. It has `_EthioTutorAppState` but NO `Record` variable in it!
  // The `Record` variable was in `_ChatScreenState` in `lib/main.dart` in previous checks.
  // Step 1320 shows lines 1-70. It ends at line 70. The file is truncated? No, "Total Lines: 70".
  // The file `lib/main.dart` in 1320 DOES NOT HAVE the recorder logic anymore?
  // It imports `screens/home_screen.dart`.
  // Maybe the recorder logic moved to `home_screen.dart` or `ai_service.dart`?
  
  // Let me check `lib/screens/home_screen.dart` before I try to fix `main.dart`.
  // If `main.dart` is clean, I don't need to fix it.

    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    _themeNotifier.value = ThemeMode.values[themeIndex];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Ethio Tutor',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeMode,
          home: SplashScreen(ai: widget.ai, themeNotifier: _themeNotifier),
        );
      },
    );
  }
}
