import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supos_v3/app/home_page.dart';
import 'package:supos_v3/core/database/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseService.initializeSupabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'My App',
      home: HomePage(),
      theme: ThemeData(
        colorScheme: ColorSchemes.lightZinc(),
        radius: 0.5,
      ),
    );
  }
}
