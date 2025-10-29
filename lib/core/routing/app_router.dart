import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:budgeetme/features/transaction/presentation/screens/transaction_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    observers: [HeroController()],
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/transaction-form',
        name: 'transaction-form',
        pageBuilder: (context, state) {
          final transaction = state.extra as Transaction?;
          return CustomTransitionPage(
            key: state.pageKey,
            child: TransactionFormScreen(
              transaction: transaction,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeOutCubic;
              
              final tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );
              
              final offsetAnimation = animation.drive(tween);
              final fadeAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );
              
              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
