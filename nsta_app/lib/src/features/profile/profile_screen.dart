import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nsta_app/src/shared/widgets/custom_appbar.dart';
import 'package:nsta_app/src/shared/widgets/sections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? uid;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    uid = box.read('userId');
    print('User Id from storage: $uid');
  }

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 16;

    if (uid == null || uid!.isEmpty) {
      return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.noUserLoggedIn)),
      );
    }

    return Scaffold(
      appBar: CustomAppBar3(title: AppLocalizations.of(context)!.myProfile),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Text(AppLocalizations.of(context)!.userDataNotFound),
              );
            }

            final rawData = snapshot.data!.data();
            if (rawData == null) {
              return Center(
                child: Text(AppLocalizations.of(context)!.userDataNotFound),
              );
            }

            final data = rawData as Map<String, dynamic>;
            final name = data['name'] ?? 'Unknown';
            final userId = data['userId'] ?? '-';
            final age = data['age'] ?? '-';
            final gender = data['gender'] ?? '-';
            final location = data['location'] ?? '-';

            print('Fetched User Data:');
            print('Name: $name');
            print('UserId: $userId');
            print('Age: $age');
            print('Gender: $gender');
            print('Location: $location');

            return ListView(
              padding: EdgeInsets.all(pad),
              children: [
                SectionCard(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        child: Icon(Icons.person, size: 32),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '$name\n'
                          '${AppLocalizations.of(context)!.id}: $userId\n'
                          '${AppLocalizations.of(context)!.age}: $age • $gender • $location',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SectionCard(
                  title: AppLocalizations.of(context)!.myTests,
                  child: Column(
                    children: const [
                      _TestTile(
                        title: 'Vertical Jump',
                        score: '32 inches',
                      ),
                      Divider(height: 20),
                      _TestTile(
                        title: 'Sprint',
                        score: '10.5 seconds',
                      ),
                    ],
                  ),
                ),
                SectionCard(
                  title: AppLocalizations.of(context)!.achievements,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(3, (i) => const _Achievement()),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestTile extends StatelessWidget {
  final String title;
  final String score;
  const _TestTile({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(Icons.sports_handball, color: Colors.orange),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.score(score),
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}

class _Achievement extends StatelessWidget {
  const _Achievement();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.emoji_events_outlined, color: Colors.amber),
    );
  }
}
