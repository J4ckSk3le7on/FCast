import 'package:f_cast/src/data/model/api/search/search_results.dart';
import 'package:f_cast/src/ui/common/ui/loading_widget.dart';
import 'package:f_cast/src/ui/home/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchPage extends StatelessWidget {
  final _searchCubit = GetIt.instance.get<SearchCubit>();

  Widget _buildLoading() {
    return Container(
      child: Center(child: LoadingWidget()),
    );
  }

  Widget _buildResults(SearchPodcastResults results) {
    if (results.results.isEmpty) {
      return Container(
        child: Center(
          child: Text("No podcasts found!"),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, index) => Divider(),
      itemCount: results.results.length,
      itemBuilder: (BuildContext context, int index) {
        var podcast = results.results[index];
        return Row(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
              child: Image.network(podcast.thumbnail),
            ),
            SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    podcast.titleOriginal,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    podcast.descriptionOriginal,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              height: 2,
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey,
              hintText: 'Search',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (searchString) =>
                _searchCubit.searchPodcast(searchString),
          ),
          SizedBox(height: 8),
          Expanded(
            child: BlocBuilder(
              cubit: _searchCubit,
              builder: (BuildContext context, SearchState state) {
                return state.when(
                  loading: _buildLoading,
                  loaded: _buildResults,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
