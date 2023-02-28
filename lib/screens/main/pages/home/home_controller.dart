// ignore_for_file: use_build_context_synchronously

import 'package:catchit/core/utils/global_state/route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:catchit/core/locator/locator.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/core/services/internet.dart';
import 'package:catchit/core/services/reviwe.dart';
import 'package:catchit/core/utils/global_widgets/modals/cant_find_modal.dart';
import 'package:catchit/core/utils/global_widgets/modals/network_error.dart';
import 'package:catchit/future/detail/data_source/repository/repository_impl.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:catchit/future/history/controller.dart';

class HomeController {
  Future<bool> searchLink(
      String link, WidgetRef ref, BuildContext context) async {
    if (await InternetService().checkConncetivity()) {
      if (link.isNotEmpty) {
        List<DetailEntity> history = ref.read(historyProvider).history;
        final sqlDetail =
            history.where((element) => element.link == link).toList();
        if (sqlDetail.isNotEmpty) {
          ref.read(routerProvider).pushNamed('detail', extra: sqlDetail[0]);
          return true;
        }
        DataState<DetailEntity> detail = const DataFailed('LinkWorng');
        //! youtube
        // if (link.contains('youtu') || link.contains('youtube')) {
        //   detail = await locator<DetailRepositoryImpl>().youtubeApi(link);
        // }
        //! spotify
        // else if (link.contains('spotify')) {
        //   detail = await locator<DetailRepositoryImpl>().spotifyApi(link);
        // } else

        if (link.contains('tiktok')) {
          detail = await locator<DetailRepositoryImpl>().tiktokApi(link);
        } else if (link.contains('instagram')) {
          detail = await locator<DetailRepositoryImpl>().instagramApi(link);
        } else if (link.contains('facebook') || link.contains('fb.')) {
          detail = await locator<DetailRepositoryImpl>().facebookApi(link);
        } else {
          const DataFailed('');
        }
        if (detail is DataSuccess) {
          FirebaseAnalytics.instance.logEvent(
            name: 'catch',
            parameters: {'platform': detail.data!.platform},
          );
          ReviewService().rating();

          if (detail.data?.platform == 'tiktok') {
            ref
                .read(historyProvider)
                .add(detail.data as DetailEntity, checkDublicate: false);
            ref.read(routerProvider).pushNamed('detail', extra: detail.data);
            return true;
          } else {
            ref
                .read(historyProvider)
                .add(detail.data as DetailEntity, checkDublicate: false);
            ref.read(routerProvider).pushNamed('detail', extra: detail.data);
            return true;
          }
        } else {
          if (detail.error!.contains('LinkWorng')) {
            cantFindModal(context: context);
          } else if (detail.error!.contains('SomethingWrong')) {
            cantFindModal(
                context: context, text: 'Something wrong! Please try Again');
          } else if (detail.error!.contains('ConnectionWorng')) {
            networkErrorModal(
                context: context,
                text:
                    'Unfortunately, We have problem with your current network, Please use VPN or another WIFI Network');
          }

          return false;
        }
      }
      return false;
    } else {
      networkErrorModal(context: context);
      return false;
    }
  }
}
