import 'package:catchit/core/helper/error_msg.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:catchit/core/locator/locator.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/core/services/reviwe.dart';
import 'package:catchit/core/utils/global_widgets/modals/cant_find_modal.dart';
import 'package:catchit/core/utils/global_widgets/modals/network_error.dart';
import 'package:catchit/future/detail/data_source/repository/repository_impl.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:flutter_flurry_sdk/flurry.dart';

class HomeController {
  Future<DetailEntity?> searchLink(String link, BuildContext context) async {
    // List<DetailEntity> history = ref.read(historyProvider).history;
    // final sqlDetail =
    //     history.where((element) => element.link == link).toList();
    // if (sqlDetail.isNotEmpty) {
    //   return sqlDetail[0];
    // }

    DataState<DetailEntity> detail = const DataFailed(linkWorng);
    if (link.contains('tiktok')) {
      detail = await locator<DetailRepositoryImpl>().tiktokApi(link);
    } else if (link.contains('instagram')) {
      detail = await locator<DetailRepositoryImpl>().instagramApi(link);
    } else if (link.contains('facebook') || link.contains('fb.')) {
      detail = await locator<DetailRepositoryImpl>().facebookApi(link);
    }

    if (detail is DataSuccess) {
      Flurry.logEventWithParameters(
          'Catch', {'platform': detail.data!.platform});
      // FirebaseAnalytics.instance.logEvent(
      //     name: 'catch', parameters: {'platform': detail.data!.platform});
      ReviewService().rating();
      return detail.data;
    } else {
      if (detail.error!.contains(linkWorng)) {
        if (context.mounted) cantFindModal(context: context);
      } else if (detail.error!.contains(somthinWorng)) {
        if (context.mounted) {
          cantFindModal(
              context: context, text: 'Something wrong! Please try Again');
        }
      } else if (detail.error!.contains(networkError)) {
        if (context.mounted) {
          networkErrorModal(
              context: context,
              text:
                  'Unfortunately, We have problem with your current network, Please use another WIFI Network or another VPN');
        }
      } else if (detail.error!.contains(privatePage)) {
        if (context.mounted) {
          cantFindModal(
            context: context,
            text: "The link is Private, We can't get data from it",
          );
        }
      }
      return null;
    }
  }
}
