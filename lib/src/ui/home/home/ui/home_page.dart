import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_cast/src/data/model/api/curated_podcasts.dart';
import 'package:f_cast/src/ui/home/home/cubit/home_cubit.dart';
import 'package:f_cast/src/ui/home/home/ui/podcast_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../common/ui/loading_widget.dart';

class PodcastHomePage extends StatelessWidget {
  final _homeCubit = GetIt.instance.get<HomeCubit>();

  Widget _buildLoading() {
    return Container(
      child: Center(
        child: LoadingWidget(),
      ),
    );
  }

  Widget _buildLoaded(CuratedPodcasts podcasts) {
    return RefreshIndicator(
      onRefresh: () => _homeCubit.refresh(),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: podcasts.curatedPodcasts.length,
        itemBuilder: (BuildContext context, int index) {
          var curatedPodcasts = podcasts.curatedPodcasts[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  curatedPodcasts.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              CarouselSlider.builder(
                itemCount: curatedPodcasts.podcasts.length,
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                itemBuilder: (_, int index) {
                  return PodcastCard(podcast: curatedPodcasts.podcasts[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _homeCubit,
      builder: (BuildContext context, HomeState state) {
        return state.when(
          loading: _buildLoading,
          loaded: _buildLoaded,
        );
      },
    );
  }
}
