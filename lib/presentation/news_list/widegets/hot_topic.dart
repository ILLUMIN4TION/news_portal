import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:news_portal/api/models/news_api.dart';
import 'package:news_portal/api/models/news_data.dart';
import 'package:news_portal/app/translations/app_trans.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_portal/api/auth_api.dart';
import 'package:news_portal/app/router/app_router.dart';

import 'package:news_portal/presentation/widgets/app_logo.dart';
import 'package:news_portal/presentation/widgets/app_scaffold.dart';

class HotTopic extends StatelessWidget {
  const HotTopic({super.key});

  @override
  Widget build(BuildContext context) {
    //FETCH DATA XXXX
    NewsApi.getTopic();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppTrans.newsList.hotTopic.tr(),
          style: GoogleFonts.jua(fontSize: 40, fontWeight: FontWeight.bold),
          // style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder(
            future: NewsApi.getTopic(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    //퓨처빌더에 크기값을 지정해줘서 width, height에 에러가 안남
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(year2023: false),
                  ),
                );
              }

              final topicNews =
                  snapshot.data ??
                  <NewsData>[]; //애초에 초기값으로 받을 떄 널과 isEmpty를 같이 처리할 수 잇게끔 수정

              if (topicNews.isEmpty) {
                //핫토픽이 nullable이므로, topicNews가 비어있는지도 체크해야함함 ,뉴스가 없습니다,
                return Center(child: Text(AppTrans.newsList.noData.tr()));
              }

              return CarouselView.weighted(
                flexWeights: [1, 7, 1],
                children: List.generate(topicNews.length, (i) {
                  final topic = topicNews[i];
                  return Card(
                    child: Stack(
                      //순서 밑으로 내려갈 수록 위로 올라옴 1번이 가장 바닥
                      children: [
                        //region 뉴스 스틸컷
                        Positioned.fill(
                          child: Image.network(
                            topic.imgUri!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              //가져온 이미지가 null일경우 아이콘 표시,
                              return Center(
                                child: Icon(LucideIcons.imageOff, size: 25),
                              );
                            },
                          ),
                        ),
                        //endRegion 뉴스 스틸컷

                        //region 그라데이션 박스스
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin:
                                  Alignment
                                      .bottomCenter, //beign index 0 번쨰 (black)
                              end:
                                  Alignment
                                      .topCenter, //end inded의 끝 (transparent)
                              colors: [Colors.black, Colors.transparent],
                            ),
                          ),
                        ),
                        //endRegion 그라데이션 박스스

                        //region 뉴스 타이틀 영역
                        Positioned(
                          left: 10, //여백을 주기, 좌우 아래 10씩씩
                          right: 10,
                          bottom: 10,
                          child: Text(
                            topic.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ), // imageUri가 nullable이므로  imageUri에 !를 표시
                        //endregion 기사제목목
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
