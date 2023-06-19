import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Sets the URL strategy of your web app to using paths instead of a leading
/// hash (`#`).
///
/// You can safely call this on all platforms, i.e. also when running on mobile
/// or desktop. In that case, it will simply be a noop.
///
/// See also:
///  * [setHashUrlStrategy], which will use a hash URL strategy instead.
void setPathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}

/// Sets the URL strategy of your web app to using a leading has (`#`) instead
/// of paths.
///
/// You can safely call this on all platforms, i.e. also when running on mobile
/// or desktop. In that case, it will simply be a noop.
///
/// See also:
///  * [setPathUrlStrategy], which will use a path URL strategy instead.
void setHashUrlStrategy() {
  setUrlStrategy(HashUrlStrategy());
}

void setNoPathUrlStrategy() {
  setUrlStrategy(XDPathUrlStrategy());
}

class XDPathUrlStrategy extends HashUrlStrategy {
  /// Creates an instance of [PathUrlStrategy].
  ///
  /// The [PlatformLocation] parameter is useful for testing to mock out browser
  /// interactions.
  XDPathUrlStrategy([
    super.platformLocation,
  ]) : _basePath = stripTrailingSlash(extractPathname(checkBaseHref(
    platformLocation.getBaseHref(),
  )));

  final String _basePath;

  @override
  String prepareExternalUrl(String internalUrl) {
    if (internalUrl.isNotEmpty && !internalUrl.startsWith('/')) {
      internalUrl = '/$internalUrl';
    }
    return '$_basePath/';
  }
}