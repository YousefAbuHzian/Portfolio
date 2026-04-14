import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0D0F14);
  static const bg2 = Color(0xFF13161E);
  static const bg3 = Color(0xFF1A1E2A);
  static const bg4 = Color(0xFF21273A);
  static const accent = Color(0xFF7C6FF7);
  static const accent2 = Color(0xFFA78BFA);
  static const accent3 = Color(0xFFC4B5FD);
  static const textPrimary = Color(0xFFE8EAF0);
  static const textSecondary = Color(0xFF9CA3AF);
  static const textTertiary = Color(0xFF6B7280);
  static const border = Color(0xFF2A2F45);
  static const card = Color(0xFF161B28);
  static const green = Color(0xFF34D399);
  static const amber = Color(0xFFFBBF24);
  static const red = Color(0xFFF87171);
}

class AppTextStyles {
  static const base = TextStyle(
    fontFamily: 'Inter',
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static TextStyle heading1 = base.copyWith(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 1.1,
  );

  static TextStyle heading2 = base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading3 = base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body = base.copyWith(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.8,
  );

  static TextStyle label = base.copyWith(
    fontSize: 12,
    letterSpacing: 1.5,
    color: AppColors.accent2,
  );

  static TextStyle caption = base.copyWith(
    fontSize: 11,
    color: AppColors.textTertiary,
  );
}
