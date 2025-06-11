import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_portal/api/models/news_api.dart';
import 'package:news_portal/api/models/news_data.dart';
import 'package:news_portal/app/translations/app_trans.dart';

class LastestNews extends StatelessWidget {
  const LastestNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppTrans.newsList.lastestNews.tr(),
          style: GoogleFonts.jua(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        FutureBuilder(
          future: NewsApi.getLastestNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 350,
                child: Center(
                  child: CircularProgressIndicator(year2023: false),
                ),
              );
            }
            final lastestNews = snapshot.data ?? <NewsData>[];

            if (lastestNews.isEmpty) {
              return Center(
                child: Text(
                  AppTrans.newsList.noData, //lastestNews isEmpty일 경우 Text 출력력
                ),
              );
            }

            return GridView.builder(
              //아이템 개수를 반드시 지정해야함
              itemCount: lastestNews.length,
              shrinkWrap: true, //자식의 크기만큼 생성성 하게하는 기능
              physics: NeverScrollableScrollPhysics(), //이중스크롤 방지,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1 / 1.3,
              ), //
              itemBuilder: (context, index) {
                final item = lastestNews[index];
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 5,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item.imgUri!, //
                            fit: BoxFit.cover, //
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  //
                                  LucideIcons.imageOff,
                                  size: 25,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Text(
                        item.pubDate, //
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
