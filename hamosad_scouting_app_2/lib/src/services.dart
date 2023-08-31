export 'services/app_lifecycle_observer.dart';
export 'services/firebase_options.dart';
export 'services/report_data_provider.dart';
export 'services/scouting_database.dart';

class Cubit<T> {
  Cubit(this.data);

  T data;
}
