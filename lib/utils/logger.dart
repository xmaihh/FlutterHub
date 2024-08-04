import 'package:logging/logging.dart';

class Log {
  static final Logger _logger = Logger('MyApp');

  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  static void info(String message) => _logger.info(message);

  static void warning(String message) => _logger.warning(message);

  static void error(String message) => _logger.severe(message);
}
