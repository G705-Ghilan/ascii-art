import 'package:flutter/material.dart';

import '../../extensions/plus_build_context.dart';
import '../../models/ascii_art_model.dart';
import '../../shared/user_icon.dart';
import '../components/ascii_art_view_component/ascii_art_view.dart';
import '../components/drawer_component/drawer.dart';

class TopArtsPage extends StatefulWidget {
  const TopArtsPage({super.key});

  @override
  State<TopArtsPage> createState() => _TopArtsPageState();
}

class _TopArtsPageState extends State<TopArtsPage> {
  @override
  void initState() {
    super.initState();
    context.rTopArts.getTopArts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        title: const Text("Top arts"),
        actions: const [
          UserIcon(),
          SizedBox(width: 10),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: context.wTopArts.isLoading
              ? const LinearProgressIndicator(minHeight: 2)
              : const SizedBox(),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: context.wTopArts.models.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              AsciiArtModel model = context.rTopArts.models[index];
              return AsciiArtView(
                model: model,
                isTop: true,
              );
            },
          )),
    );
  }
}
