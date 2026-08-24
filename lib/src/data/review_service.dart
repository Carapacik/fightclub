import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

abstract final class ReviewService._() {
  static Future<void> requestIfAvailable() async {
    if (kIsWeb || !{TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.macOS}.contains(defaultTargetPlatform)) {
      return;
    }
    final InAppReview review = InAppReview.instance;
    if (await review.isAvailable()) {
      await review.requestReview();
    }
  }
}
