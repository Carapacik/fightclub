import 'package:fightclub/src/data/fight_history_storage.dart';
import 'package:fightclub/src/screens/main_screen.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class const App({super.key}) extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState() extends State<App> {
  late final FightHistoryStorage _storage = FightHistoryStorage(SharedPreferencesAsync());

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Press Start 2P'),
    title: 'Fight Club',
    home: MainScreen(storage: _storage),
  );
}
