package com.catchit.app

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin


class MainNativeAdFactory(val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.main_native_ad, null) as NativeAdView

        with(nativeAdView) {

          //  attribution

            val attributionViewSmall: TextView = nativeAdView
                .findViewById(R.id.native_ad_attribution_small)
            attributionViewSmall.visibility = View.VISIBLE
// icon

            nativeAdView.iconView = nativeAdView.findViewById(R.id.native_ad_icon)
            if (nativeAd.icon == null) {
                nativeAdView.iconView!!.visibility = View.GONE
            } else {

                (nativeAdView.iconView as ImageView?)!!.clipToOutline
                (nativeAdView.iconView as ImageView?)!!.setImageDrawable(nativeAd.icon!!.drawable)
            }

//  media
            val mediaView: MediaView = nativeAdView.findViewById(R.id.native_ad_media)
            mediaView.mediaContent = nativeAd.mediaContent
            nativeAdView.mediaView = mediaView

// button

            nativeAdView.callToActionView = nativeAdView.findViewById(R.id.native_ad_button)
            if (nativeAd.callToAction == null) {
                nativeAdView.callToActionView!!.visibility = View.INVISIBLE
            } else {
                (nativeAdView.callToActionView as Button?)!!.text = nativeAd.callToAction
            }

//   headline
            nativeAdView.headlineView = nativeAdView.findViewById(R.id.native_ad_headline)
            (nativeAdView.headlineView as TextView?)!!.text = nativeAd.headline
//  bodyView
            nativeAdView.bodyView = nativeAdView.findViewById(R.id.native_ad_body)
            if (nativeAd.body == null) {
                nativeAdView.bodyView!!.visibility = View.INVISIBLE
            } else {
                (nativeAdView.bodyView as TextView?)!!.text = nativeAd.body
                nativeAdView.bodyView!!.visibility = View.VISIBLE
            }

//    advertiser name
            nativeAdView.advertiserView = nativeAdView.findViewById(R.id.native_ad_advertiser)
            if (nativeAd.advertiser == null) {
                nativeAdView.advertiserView!!.visibility = View.GONE
            } else {
                (nativeAdView.advertiserView as TextView?)!!.text = nativeAd.advertiser
                nativeAdView.advertiserView!!.visibility = View.VISIBLE
            }
//   ratingbar
            nativeAdView.starRatingView = nativeAdView.findViewById(R.id.native_ad_rating)
            if (nativeAd.starRating == null) {
                nativeAdView.starRatingView!!.visibility = View.INVISIBLE
            } else {
                (nativeAdView.starRatingView as RatingBar?)!!.rating =
                    nativeAd.starRating!!.toFloat()
                nativeAdView.starRatingView!!.visibility = View.VISIBLE
            }


            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}

//internal class NativeAdFactoryExample(private val layoutInflater: LayoutInflater) :
//    NativeAdFactory {
//    override fun createNativeAd(
//        nativeAd: NativeAd, customOptions: Map<String, Any>
//    ): NativeAdView {
//        val adView = layoutInflater.inflate(R.layout.main_native_ad, null) as NativeAdView
//        val headlineView = adView.findViewById<TextView>(R.id.native_ad_headline)
//        val bodyView = adView.findViewById<TextView>(R.id.native_ad_body)
//        headlineView.text = nativeAd.headline
//        bodyView.text = nativeAd.body
//        adView.setBackgroundColor(Color.YELLOW)
//        adView.setNativeAd(nativeAd)
//        adView.bodyView = bodyView
//        adView.headlineView = headlineView
//        return adView
//    }
//}