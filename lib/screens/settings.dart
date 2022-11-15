import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

int selectedLang = 2;

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'uz':
        selectedLang = 1;
        break;
      case 'en':
        selectedLang = 2;
        break;
      default:
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Settings".tr(),
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings".tr(),
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            menu("Change app color", Icons.color_lens_outlined),
            const SizedBox(height: 10),
            menu("Change app typography", Icons.type_specimen_outlined),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.language_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Change app language",
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              backgroundColor: Colors.black,
                              title: const Center(
                                child: Text(
                                  "Languages",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RadioListTile(
                                    title: const Text(
                                      "O'zbekcha",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 1,
                                    groupValue: selectedLang,
                                    onChanged: ((value) {
                                      setState(
                                        () {
                                          selectedLang = value as int;
                                          context.setLocale(
                                            const Locale('uz', 'UZ'),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                  RadioListTile(
                                    title: const Text(
                                      "English",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    value: 2,
                                    groupValue: selectedLang,
                                    onChanged: ((value) {
                                      setState(
                                        () {
                                          selectedLang = value as int;
                                          context.setLocale(
                                            const Locale('en', 'US'),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget menu(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 25,
          ),
        )
      ],
    );
  }
}
