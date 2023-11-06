// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_firebase/src/introduction_page.dart';

const _introductionDocumentRef = 'introduction/introduction';

class FirebaseIntroductionService {
  FirebaseIntroductionService({
    DocumentReference<Map<String, dynamic>>? documentRef,
  }) : _documentRef = documentRef ??
            FirebaseFirestore.instance.doc(_introductionDocumentRef);

  final DocumentReference<Map<String, dynamic>> _documentRef;
  List<IntroductionPageData> _pages = [];

  Future<List<IntroductionPageData>> getIntroductionPages() async {
    if (_pages.isNotEmpty) return _pages;
    var pagesDocuments =
        await _documentRef.collection('pages').orderBy('order').get();
    return _pages = pagesDocuments.docs.map((document) {
      var data = document.data();
      // convert Map<String, dynamic> to Map<String, String>
      var title = data['title'] != null
          ? (data['title'] as Map<String, dynamic>).cast<String, String>()
          : <String, String>{};
      var content = data['content'] != null
          ? (data['content'] as Map<String, dynamic>).cast<String, String>()
          : <String, String>{};
      return IntroductionPageData(
        title: title,
        content: content,
        contentImage: data['image'] as String?,
        backgroundImage: data['background_image'] as String?,
        // the color is stored as a hex string
        backgroundColor: data['background_color'] != null
            ? Color(int.parse(data['background_color'] as String, radix: 16))
            : null,
      );
    }).toList();
  }

  Future<bool> shouldAlwaysShowIntroduction() async {
    var document = await _documentRef.get();
    return document.data()!['always_show'] as bool? ?? false;
  }

  Future<void> loadIntroductionPages(
    BuildContext context,
  ) async {
    for (var page in _pages) {
      if (context.mounted && page.backgroundImage != null) {
        await precacheImage(
          CachedNetworkImageProvider(page.backgroundImage!),
          context,
        );
      }
      if (context.mounted && page.contentImage != null) {
        await precacheImage(
          CachedNetworkImageProvider(page.contentImage!),
          context,
        );
      }
    }
  }
}
