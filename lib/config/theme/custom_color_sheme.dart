import 'package:flutter/material.dart';

/// Project custom colors
final class CustomColorScheme {
  CustomColorScheme._();
  static const lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff00C9FF), // Ana arka plan rengi, koyu mavi ton
    onPrimary: Color(0xFFFFFFFF), // Beyaz, birincil renk üzerinde kontrast
    secondary: Color(0xFFE0E0E0), // Açık gri, sekmeler ve alt kısımlar için
    onSecondary: Color(0xFF000000), // Siyah, sekme yazıları için
    error: Color(0xFFB00020), // Kırmızımsı hata rengi
    onError: Color(0xFFFFFFFF), // Beyaz, hata mesajları üzerinde kontrast
    surface: Color(0xFFFFFFFF), // Beyaz yüzeyler (kartlar vb.)
    onSurface: Color(0xFF000000), // Siyah, yüzey üzerindeki yazılar için

    secondaryContainer: Colors.red, // Koyu kırmızı, vurgular için
    tertiaryContainer: Colors.green, // Koyu yeşil, yardımcı vurgular için
    tertiaryFixed: Colors.amber, // Amber, sabit üçüncül renk
    onPrimaryContainer: Color.fromARGB(
        255, 226, 223, 223), // Konteyner içindeki öğeler için koyu gri
    tertiary: Colors.grey, // Orta koyu gri, ekstra aksan veya simgeler için
    onTertiary: Color(0xFFFFFFFF), // Ters kontrast için beyaz
    outline: Color(0xFFBDBDBD), // Açık gri, sınır ve çizgiler için
  );

  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff00C9FF), // Ana arka plan rengi
    onPrimary: Color(0xFFFFFFFF), // Beyaz renk, kontrast oluşturur
    secondary: Color(0xFF424242), // Koyu gri, sekmeler ve alt kısımlar için
    onSecondary: Color(0xFFFFFFFF), // Beyaz renk, sekme yazıları için
    error: Color(0xFFCF6679), // Kırmızımsı hata rengi
    onError: Color(0xFF000000), // Siyah, hata mesajları üzerine

    surface: Color(0xFF303030), // Kart arka planları ve diğer yüzeyler için

    scrim: Colors.black,
    secondaryContainer: Colors.redAccent,
    tertiaryContainer: Colors.greenAccent,
    tertiaryFixed: Colors.amberAccent,
    onSurface: Color(0xFFFFFFFF), // Beyaz renk, yüzey üzerindeki yazılar için
    onPrimaryContainer:
        Color.fromARGB(95, 97, 97, 97), // Container içindeki öğeler için
    tertiary: Colors.grey, // Ekstra aksan veya simgeler için

    onTertiary: Color(0xFFFFFFFF), // Ters kontrast için beyaz
    outline: Color(0xFF757575), // Sınır ve çizgiler için
  );
}
