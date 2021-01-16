import 'package:f_cast/src/data/model/api/curated_podcasts.dart';
import 'package:f_cast/src/data/services/impl/curated_podcast_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final CuratedPodcastService _curatedPodcastService;
  CuratedPodcasts _podcasts;

  HomeCubit(this._curatedPodcastService) : super(HomeState.loading()) {
    _init();
  }

  Future<void> refresh() async {
    emit(HomeState.loading());
    _init();
  }

  Future<void> _init() async {
    _podcasts = await _curatedPodcastService.getCuratedPodcasts();
    _emitState();
  }

  void _emitState() {
    emit(HomeState.loaded(_podcasts));
  }
}
