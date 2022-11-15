import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/database/shared.dart';
import 'package:uptodo/screens/settings.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _controller = TextEditingController();
  String username = "";

  @override
  void initState() {
    super.initState();
    username = StorageRepository.getString("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Profile".tr(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                username,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Settings",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "App Settings",
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsPage()));
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Account",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Change account name",
                  style: TextStyle(color: Colors.white),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  "Change name",
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: TextFormField(
                                  controller: _controller,
                                  onChanged: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: "Change name",
                                      hintStyle:
                                          TextStyle(color: Colors.white30)),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        StorageRepository.setString(
                                            "name", username);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              ));
                    });
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Change account password",
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
            ),
            const SizedBox(
              height: 10,
            ),
            menu("Change account image", Icons.phone),
            const SizedBox(height: 20),
            const Text(
              "Uptodo",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            menu("About Us", Icons.all_inbox_outlined),
            const SizedBox(
              height: 10,
            ),
            menu("FAQ", Icons.info_outline),
            const SizedBox(height: 10),
            menu("Support us", Icons.favorite_border_outlined),
            const SizedBox(height: 10),
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
