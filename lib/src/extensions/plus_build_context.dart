import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/drawer_provider.dart';
import '../providers/home_page_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/top_arts_provider.dart';

extension PlusBuildContext on BuildContext {
  HomePageProvider get wHome => watch<HomePageProvider>();
  HomePageProvider get rHome => read<HomePageProvider>();

  DrawerProvider get wDrawer => watch<DrawerProvider>();
  DrawerProvider get rDrawer => read<DrawerProvider>();

  Settingsprovider get wSettings => watch<Settingsprovider>();
  Settingsprovider get rSettings => read<Settingsprovider>();

  TopArtsProvider get wTopArts => watch<TopArtsProvider>();
  TopArtsProvider get rTopArts => read<TopArtsProvider>();
}
