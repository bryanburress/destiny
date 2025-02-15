import 'dart:io';

import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/shared/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsShared<T extends SettingsState> extends State<T> {
  SharedPreferences? prefs;
  bool selectingFolder = false;

  String? get path {
    final path = prefs?.get(PATH);

    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  late String? defaultPathForPlatform = '';

  String get version {
    return const String.fromEnvironment("version", defaultValue: "undefined");
  }

  SettingsShared() {
    SharedPreferences.getInstance().then((prefs) => setState(() {
          this.prefs = prefs;
        }));

    if (Platform.isAndroid) {
      defaultPathForPlatform = ANDROID_DOWNLOADS_FOLDER_PATH;
    } else {
      getDownloadsDirectory().then((downloadsDir) {
        defaultPathForPlatform = downloadsDir?.path;
      });
    }
  }

  void selectSaveDestination() async {
    if (selectingFolder) return;
    try {
      this.setState(() {
        selectingFolder = true;
      });
      String? directory = await FilePicker.platform
          .getDirectoryPath(initialDirectory: prefs?.getString(PATH));
      if (directory == null) {
        return;
      }

      if (await canWriteToDirectory(directory)) {
        setState(() {
          prefs?.setString(PATH, "$directory${Platform.pathSeparator}");
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              THE_APP_DOES_NOT_HAVE_THE_PREMISSION_TO_STORE_FILES_IN_THE_DIR),
        ));
      }
    } finally {
      this.setState(() {
        selectingFolder = false;
      });
    }
  }

  Widget build(BuildContext context);
}

abstract class SettingsState extends StatefulWidget {
  SettingsState({Key? key}) : super(key: key);
}
