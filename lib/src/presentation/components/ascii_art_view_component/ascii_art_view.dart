import 'package:flutter/material.dart';

import '../../../extensions/plus_build_context.dart';
import '../../../models/ascii_art_model.dart';
import '../../popup_animation/custom_rect_tween.dart';
import '../../popup_animation/hero_dialog_route.dart';
import 'ascii_art_hero_dialog.dart';
import 'custom_text_button.dart';

class AsciiArtView extends StatelessWidget {
  const AsciiArtView({
    super.key,
    required this.model,
    this.isTop = false,
  });

  final AsciiArtModel model;
  final bool isTop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, HeroDialogRoute(
          builder: (context) {
            return AsciiArtHeroDialog(model: model);
          },
        ));
      },
      child: Material(
        child: Hero(
          tag: model.artDocument.id,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: FittedBox(
                        child: Text(
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
                            icon: "dislike",
                            label: model.disLikes.toString(),
                            isSelected: model.isDisLike,
                            onTap: () async {
                              if (isTop) {
                                await context.rTopArts
                                    .disLike(model.artDocument.id);
                              } else {
                                await context.rHome
                                    .disLike(model.artDocument.id);
                              }
                            },
                          ),
                          CustomTextButton(
                            icon: "like",
                            label: model.likes.toString(),
                            isSelected: model.isLike,
                            onTap: () async {
                              if (isTop) {
                                await context.rTopArts
                                    .like(model.artDocument.id);
                              } else {
                                await context.rHome.like(model.artDocument.id);
                              }
                            },
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
}
