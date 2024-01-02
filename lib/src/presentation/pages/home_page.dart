import 'package:ascii_art/src/presentation/dialogs/oops_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/plus_build_context.dart';
import '../../models/ascii_art_model.dart';
import '../components/ascii_art_view_component/ascii_art_view.dart';
import '../components/drawer_component/drawer.dart';
import '../components/search_bar_component/search_bar.dart';
import '../dialogs/ascii_category_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.rHome.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: context.rHome.key,
        drawer: const DrawerComponent(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SearchBarComponent(),
                SizedBox(
                  height: 20,
                  child: Center(
                    child: context.wHome.isloading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: LinearProgressIndicator(
                              minHeight: 2,
                            ),
                          )
                        : null,
                  ),
                ),
                if (context.wHome.asciiModels.isNotEmpty)
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Ascii art",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                if (context.wHome.asciiModels.isEmpty) ...[
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: constraints.maxWidth,
                          alignment: Alignment.center,
                          height: constraints.maxHeight,
                          // padding: EdgeInsets.only(bottom: 92),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: context.wHome.note
                                ? context.wHome.isloading
                                    ? const SizedBox()
                                    : Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          const Text(
                                            "Oops!\nWe couldn't find any ASCII art matching your search. Please try a different keywordsn or see the ascii category",
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: FilledButton(
                                                onPressed: () =>
                                                    AsciiCategoryDialog.show(
                                                        context),
                                                child: const Text("Category")),
                                          )
                                        ],
                                      )
                                : SvgPicture.asset(
                                    "assets/icons/search_big.svg",
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Spacer(),
                ],
                if (context.wHome.asciiModels.isNotEmpty)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                          if (scrollEnd.metrics.atEdge &&
                              scrollEnd.metrics.pixels > 0) {
                            context.rHome.search(context);
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: context.wHome.asciiModels.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            AsciiArtModel model =
                                context.rHome.asciiModels[index];
                            return AsciiArtView(model: model);
                          },
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
