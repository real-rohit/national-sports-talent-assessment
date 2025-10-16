import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/core/theme/app_theme.dart';
import 'package:nsta_app/src/shared/widgets/sections.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 12;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_outlined, color: Colors.white,)),
        backgroundColor: AppTheme.primaryRed,
        title: Text(
          AppLocalizations.of(context)!.leaderboard,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        bottom: TabBar(
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          controller: _tabController,
          labelColor: Colors.white,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.global,
            ),
            Tab(text: AppLocalizations.of(context)!.ageGroup),
            Tab(text: AppLocalizations.of(context)!.localCenter)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(pad),
          _buildList(pad),
          _buildList(pad),
        ],
      ),
    );
  }

  Widget _buildList(double pad) {
    return ListView(
      padding: EdgeInsets.all(pad),
      children: [
        SectionCard(
          child: TextField(
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchAthletes,
                  prefixIcon: const Icon(Icons.search))),
        ),
        SectionCard(
          child: Column(
            children: List.generate(
                10,
                (i) => _LeaderboardRow(
                    rank: i + 1,
                    name: '${AppLocalizations.of(context)!.athlete} ${i + 1}',
                    score: 1200 - i * 50)),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  const _LeaderboardRow(
      {required this.rank, required this.name, required this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(radius: 16, child: Text(rank.toString())),
          const SizedBox(width: 12),
          const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
          const SizedBox(width: 12),
          Expanded(
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(score.toString(), style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
