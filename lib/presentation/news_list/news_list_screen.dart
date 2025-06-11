import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_portal/presentation/news_list/widegets/app_bar.dart';
import 'package:news_portal/presentation/news_list/widegets/hot_topic.dart';
import 'package:news_portal/presentation/news_list/widegets/lastest_news.dart';
import 'package:news_portal/presentation/widgets/app_scaffold.dart';
import 'package:news_portal/presentation/widgets/app_logo.dart'; // AppLogo import 추가

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: NewsListAppBar(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: const Column(
          spacing: 15,
          children: [
            HotTopic(), //
            LastestNews(),
          ],
        ),
      ),
    );
  }
}
