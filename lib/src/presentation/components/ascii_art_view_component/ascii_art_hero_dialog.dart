import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/ascii_art_model.dart';
import '../../popup_animation/custom_rect_tween.dart';
import 'custom_text_button.dart';

class AsciiArtHeroDialog extends StatelessWidget {
  const AsciiArtHeroDialog({
    super.key,
    required this.model,
  });

  final AsciiArtModel model;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Hero(
          tag: model.artDocument.id,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: FittedBox(
                        child: SelectableText(
                          model.art,
                          style: const TextStyle(
                              fontFamily: "monospace", color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextButton(
                            icon: "share",
                            label: "share",
                            withSelect: false,
                            onTap: share,
                          ),
                          CustomTextButton(
                            icon: "copy",
                            label: "copy",
                            withSelect: false,
                            onTap: () => copy(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: model.art));
  }

  void share() {
    Share.share(model.art);
  }
}
