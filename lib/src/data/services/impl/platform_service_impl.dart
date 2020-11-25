import 'dart:io';

import 'package:f_cast/src/data/services/interface/platform_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PlatformService)
class PlatformServiceImpl implements PlatformService {
  @override
  bool isIos() {
    return Platform.isIOS;
  }
}
