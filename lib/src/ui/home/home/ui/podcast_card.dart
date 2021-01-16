import 'package:f_cast/src/data/model/api/podcast_curated.dart';
import 'package:flutter/material.dart';

class PodcastCard extends StatelessWidget {
  final PodcastCurated podcast;

  const PodcastCard({Key key, this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              child: Image.network(podcast.image),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    podcast.title,
                    maxLines: 3,
                  ),
                  Text(podcast.description ?? ""),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
