import 'package:flutter/material.dart';

import 'home_hud_panel.dart';

/// A standalone page to preview the Host/Identity UI.
class HomeHudPage extends StatelessWidget {
  const HomeHudPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Host / Identity HUD')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: HomeHudPanel(),
        ),
      ),
    );
  }
}
