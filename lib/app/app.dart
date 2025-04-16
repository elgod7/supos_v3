import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supos_v3/modules/shops/view/shop_page.dart';
import '../app/home.dart';
import '../modules/auth/bloc/auth_bloc.dart';
import '../modules/auth/view/auth_page.dart';
import '../modules/products/view/pages/product_add_page.dart';
import '../modules/products/view/pages/product_detail_page.dart';
import '../modules/products/view/pages/product_edit_page.dart';
import '../modules/products/view/product_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    //final shopId = shopBloc.state.shopId;

    final GoRouter _router = GoRouter(
      refreshListenable: GoRouterRefreshStream(
          authBloc.stream), // Auto-refresh GoRouter when Bloc state changes
      initialLocation: '/',
      redirect: (context, state) {
        final isAuthenticated = authBloc.state is AuthAuthenticated;
        final isLoggingIn = state.matchedLocation == '/';
        if (!isAuthenticated) {
          return isLoggingIn
              ? null
              : '/'; // Redirect to login if not authenticated
        }
        if (isAuthenticated && isLoggingIn) {
          return '/home';
        }
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const AuthPage()),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(userName: 'Elias'),
        ),
        GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
        GoRoute(
            path: '/products/:shopId', // <-- Define dynamic shopId parameter,
            builder: (context, state) {
              final shopId = int.parse(state.pathParameters['shopId']!);
              final shopName = state.uri.queryParameters['shopName'];
              return ProductPage(
                shopId: shopId,
                shopName: shopName,
              );
            }),
        GoRoute(
            path: '/products/detail/:productId',
            builder: (context, state) {
              //final productId = int.parse(state.pathParameters['productId']!);
              final extra = state.extra as Map<String, dynamic>;
              final product = extra['product'] as Map<String, dynamic>;
              final categoryOptions =
                  extra['categories'] as List<Map<String, dynamic>>;
              final unitOptions = extra['units'] as List<Map<String, dynamic>>;
              return ProductDetailPage(
                productId: product['id'],
                productInitial: product,
                categories: categoryOptions,
                units: unitOptions,
                shopName: extra['shopName'] as String,
              );
            }),
        GoRoute(
            path: '/products/:shopId/add',
            builder: (context, state) {
              final shopId = int.parse(state.pathParameters['shopId']!);
              final extra = state.extra as Map<String, dynamic>;
              final categoryOptions =
                  extra['categories'] as List<Map<String, dynamic>>;
              final unitOptions = extra['units'] as List<Map<String, dynamic>>;
              return ProductAddPage(
                categoryOptions: categoryOptions,
                unitOptions: unitOptions,
                shopId: shopId,
              );
            }),

        GoRoute(
            path: '/products/detail/:productId/edit',
            builder: (context, state) {
              //final productId = int.parse(state.pathParameters['productId']!);
              final extra = state.extra as Map<String, dynamic>;
              final product = extra['product'] as Map<String, dynamic>;
              final categoryOptions =
                  extra['categories'] as List<Map<String, dynamic>>;
              final unitOptions = extra['units'] as List<Map<String, dynamic>>;
              // Pass full product data
              return ProductEditPage(
                product: product,
                categoryOptions: categoryOptions,
                unitOptions: unitOptions,
              );
            }),

        // GoRoute(
        //   path: '/products/:shopId/add',
        //   builder: (context, state) {
        //     final shopId = int.parse(state.pathParameters['shopId']!);
        //     return AddEditProductPage();
        //   },
        // ),
        // GoRoute(
        //   path: '/products/:shopId/edit/:productId',
        //   builder: (context, state) {
        //     final shopId = int.parse(state.pathParameters['shopId']!);
        //     final productId = int.parse(state.pathParameters['productId']!);
        //     final product =
        //         state.extra as Map<String, dynamic>; // Pass full product data
        //     return AddEditProductPage(shopId: shopId, product: product);
        //   },
        // ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
