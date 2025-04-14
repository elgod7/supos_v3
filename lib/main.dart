import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/core/supabase/supabase_service.dart';
import 'package:supos_v3/modules/shops/bloc/shop_bloc.dart';
import 'app/app.dart';
import 'modules/auth/bloc/auth_bloc.dart';
import 'modules/products/bloc/product_bloc.dart';
import 'modules/products/data/product_repository.dart';
import 'modules/shops/data/shop_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseService.initializeSupabase();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            AuthBloc()..add(AppStarted())), // Provide AuthBloc globally
    BlocProvider(create: (context) => ShopBloc(ShopRepository())),
    BlocProvider(create: (context) => ProductBloc(ProductRepository())),

    // BlocProvider(create: (context) => ShopBloc(ShopRepository()))
  ], child: MyApp()));
}
