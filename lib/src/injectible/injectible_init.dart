import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectible_init.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<GetIt> configureDependencies() => $initGetIt(getIt);
