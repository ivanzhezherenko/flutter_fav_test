import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fav_test/domain/network/movie_api_service.dart';

class MoviePosterImage extends StatelessWidget {
  final String? posterPath;
  final ValueNotifier<bool>? imageLoadedNotifier;

  const MoviePosterImage({
    this.imageLoadedNotifier,
    this.posterPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: '${MovieApiService.baseImageUrl}$posterPath',
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) {
          _notifyImageLoaded();
          return Image(image: imageProvider, fit: BoxFit.cover);
        },
        placeholder: (context, url) => const AspectRatio(
          aspectRatio: 2 / 3,
          child: Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  void _notifyImageLoaded() {
    if (imageLoadedNotifier != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => imageLoadedNotifier?.value = true);
    }
  }
}
