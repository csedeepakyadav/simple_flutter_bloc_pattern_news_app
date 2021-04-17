import 'package:blocnews/model/news_model.dart';
import 'package:blocnews/repository/news_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final NewsRepository _newsRepository = NewsRepository();

  final _newsFetcher = PublishSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get allNews => _newsFetcher.stream;

  fetchAllNews({@required String? country}) async {
    List<ArticleModel> albumList =
        await _newsRepository.fetchArticle(country: country);
    _newsFetcher.sink.add(albumList);
  }

  lauchNewsUrl(String newsUrl) {
    FlutterWebBrowser.openWebPage(
      url: newsUrl,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: Colors.deepPurple,
        secondaryToolbarColor: Colors.green,
        navigationBarColor: Colors.amber,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.green,
        preferredControlTintColor: Colors.amber,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  dispose() {
    _newsFetcher.close();
  }
}

final newsBloc = NewsBloc();
