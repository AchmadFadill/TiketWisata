import 'package:flutter/material.dart';
import 'package:tiket_wisata/data/datasources/auth_local_datasources.dart';
import 'package:tiket_wisata/presentation/ui/intro/login_page.dart';
import '/presentation/ui/home/page/main_page.dart'; // Ganti dengan halaman utama kamu
import '../../../core/core.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthLocalDataSource _authLocal = AuthLocalDataSource();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // animasi splash
    final isLoggedIn = await _authLocal.isLoggedIn();
    if (!mounted) return;

    if (isLoggedIn) {
      context.pushReplacement(const MainPage());
    } else {
      context.pushReplacement(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Assets.images.logoBlue.image(),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100.0,
        child: Align(
          alignment: Alignment.center,
          child: Assets.images.logoIdn.image(width: 96.0),
        ),
      ),
    );
  }
}
