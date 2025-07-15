import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/notes_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'System',
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF3B82F6),
            secondary: Color(0xFF64748B),
            surface: Color(0xFFFAFAFB),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Color(0xFF0F172A),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Color(0xFF0F172A),
            titleTextStyle: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 28,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
          ),
        ),
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.state == AuthState.initial) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF1E293B),
                    Color(0xFF334155),
                  ],
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 64,
                      color: Color(0xFF3B82F6),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 48),
                    CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                      strokeWidth: 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (authProvider.isAuthenticated) {
          return const NotesScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
