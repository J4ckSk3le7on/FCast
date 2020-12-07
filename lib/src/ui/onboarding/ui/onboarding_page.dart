import 'package:f_cast/src/data/model/api/search_results.dart';
import 'package:f_cast/src/ui/common/ui/loading_widget.dart';
import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/common/ui/platform_scaffold.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:f_cast/src/ui/onboarding/cubit/onboarding_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

class OnboardingPage extends PlatformPage {
  OnboardingPage() : super(OnboardingWidget(), "/onboarding");
}

class OnboardingWidget extends StatelessWidget {
  Widget _buildResults(OnboardingSearchCubit cubit,
      SearchPodcastResults results, List<String> selectedIds) {
    return ListView.separated(
      separatorBuilder: (_, index) => Divider(),
      itemCount: results.results.length,
      itemBuilder: (BuildContext context, int index) {
        var podcast = results.results[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
              child: Image.network(podcast.thumbnail),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              podcast.titleOriginal,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          selectedIds.contains(podcast.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () => cubit.toggleId(podcast.id),
                      ),
                    ],
                  ),
                  Text(
                    podcast.descriptionOriginal,
                    maxLines: 3,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = GetIt.instance.get<OnboardingSearchCubit>();
    var authCubit = BlocProvider.of<AuthenticationCubit>(context);
    return PlatformScaffold(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          cubit: cubit,
          builder: (BuildContext context, OnboardingSearchState state) {
            return Flex(
              direction: Axis.vertical,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Finish"),
                    onPressed: () {
                      state.maybeWhen(
                          orElse: () {},
                          loaded: (_, selectedIds) =>
                              authCubit.saveNewUser(selectedIds));
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.podcast,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text("What do you like to listen to?"),
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (newString) => cubit.search(newString),
                ),
                Expanded(
                  flex: 3,
                  child: Builder(
                    builder: (BuildContext context) {
                      return state.when(
                        loading: () => LoadingWidget(),
                        empty: () => Center(
                          child: Text("Nothing to show!"),
                        ),
                        loaded: (results, ids) =>
                            _buildResults(cubit, results, ids),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
