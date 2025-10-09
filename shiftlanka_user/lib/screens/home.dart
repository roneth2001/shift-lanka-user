import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _promoCtrl = PageController(viewportFraction: 0.88);
  int _currentTab = 0;

  // Brand palette
  static const _bg = Color(0xFFF6F7FB);
  static const _ink = Color(0xFF121316);
  static const _sub = Color(0xFF6B7280);
  static const _primary = Color(0xFF6366F1); // indigo
  static const _primaryAlt = Color(0xFF8B5CF6); // violet
  static const _accent = Color(0xFFFF6A00); // ShiftLanka orange
  static const _card = Colors.white;

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double top = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _bg,
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(top),
          SliverToBoxAdapter(child: _buildHero()),
          SliverToBoxAdapter(child: _space(16)),
          SliverToBoxAdapter(child: _buildSearch()),
          SliverToBoxAdapter(child: _space(18)),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: _space(22)),
          SliverToBoxAdapter(child: _buildPromoCarousel()),
          SliverToBoxAdapter(child: _space(24)),
          SliverToBoxAdapter(child: _sectionTitle('Services')),
          SliverToBoxAdapter(child: _space(12)),
          SliverToBoxAdapter(child: _buildServicesGrid()),
          SliverToBoxAdapter(child: _space(22)),
          SliverToBoxAdapter(child: _buildStats()),
          SliverToBoxAdapter(child: _space(24)),
          SliverToBoxAdapter(child: _buildFooter()),
          _spaceSliver(96), // room above bottom nav
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------- APP BAR ----------
  Widget _buildAppBar(double topPadding) {
    return SliverAppBar(
      backgroundColor: _bg,
      elevation: 0,
      floating: true,
      snap: true,
      toolbarHeight: 64,
      titleSpacing: 16,
      title: Row(
        children: [
          // Logo tile
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFF44336)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.15),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: const Icon(Icons.directions_bus, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          const Text(
            'SHIFT LANKA',
            style: TextStyle(
              color: _ink,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
      actions: [
        _iconBtn(Icons.notifications_outlined, onTap: () {}),
        const SizedBox(width: 8),
      ],
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  // ---------- HERO ----------
  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_primary, _primaryAlt],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.26),
              blurRadius: 28,
              spreadRadius: 1,
              offset: const Offset(0, 16),
            )
          ],
        ),
        child: Stack(
          children: [
            // subtle ornament
            Positioned(
              right: -12,
              top: -12,
              child: Opacity(
                opacity: 0.15,
                child: Icon(Icons.radio_button_checked, size: 140, color: Colors.white),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Chip(text: '👋 Welcome back'),
                SizedBox(height: 12),
                Text(
                  'Where do you\nwant to go today?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- SEARCH ----------
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _Glass(
        child: Row(
          children: [
            const Icon(Icons.search, color: _sub, size: 22),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Search routes, stops, destinations',
                style: TextStyle(color: _sub, fontSize: 14.5),
              ),
            ),
            _pill('Popular'),
          ],
        ),
      ),
    );
  }

  // ---------- QUICK ACTIONS (horizontal) ----------
  Widget _buildQuickActions() {
    final items = <_Action>[
      _Action('Track Bus', Icons.gps_fixed, const Color(0xFF10B981)),
      _Action('Bus Stops', Icons.location_on, const Color(0xFFF59E0B)),
      _Action('Fare Info', Icons.payments, const Color(0xFF3B82F6)),
      _Action('Tickets', Icons.confirmation_number_outlined, const Color(0xFF22C55E)),
      _Action('Alerts', Icons.notification_important_outlined, const Color(0xFFEF4444)),
    ];
    return SizedBox(
      height: 102,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _quickAction(items[i]),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: items.length,
      ),
    );
  }

  Widget _quickAction(_Action a) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: a.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(a.icon, color: a.color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              a.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                color: _ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- PROMO CAROUSEL ----------
  Widget _buildPromoCarousel() {
    final promos = [
      _Promo(
        title: 'Live Tracking',
        subtitle: 'See buses on the map in real time',
        icon: Icons.my_location,
        color: const Color(0xFF10B981),
        badge: 'Real-time',
      ),
      _Promo(
        title: 'Route Planner',
        subtitle: 'Find the fastest route with changes',
        icon: Icons.alt_route,
        color: _primary,
        badge: 'Popular',
      ),
      _Promo(
        title: 'Lost & Found',
        subtitle: 'Report or find your lost items',
        icon: Icons.search_off,
        color: const Color(0xFFEF4444),
        badge: 'New',
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _promoCtrl,
            itemCount: promos.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, i) => _promoCard(promos[i]),
          ),
        ),
        const SizedBox(height: 10),
        _pageDots(promos.length),
      ],
    );
  }

  Widget _promoCard(_Promo p) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [p.color.withOpacity(0.08), _card],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 10),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: p.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(p.icon, color: p.color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          p.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _tinyBadge(p.badge, p.color),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: _sub, height: 1.2),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFB6BCC6)),
          ],
        ),
      ),
    );
  }

  Widget _pageDots(int count) {
    return AnimatedBuilder(
      animation: _promoCtrl,
      builder: (_, __) {
        final page = _promoCtrl.hasClients && _promoCtrl.page != null ? _promoCtrl.page! : 0.0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (i) {
            final selected = (page.round() == i);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: selected ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: selected ? _accent : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        );
      },
    );
  }

  // ---------- SERVICES GRID ----------
  Widget _buildServicesGrid() {
    final services = <_Service>[
      _Service('Route Search', 'Find best routes between locations', Icons.search, _primary, 'Popular'),
      _Service('Live Tracking', 'Track buses in real-time', Icons.map_outlined, const Color(0xFF10B981), 'Real-time'),
      _Service('Lost & Found', 'Report or find lost items', Icons.search_off, const Color(0xFFEF4444), 'New'),
      _Service('Complaints', 'Share feedback about services', Icons.feedback, const Color(0xFF3B82F6), null),
      _Service('Timetables', 'Stop-wise daily schedules', Icons.schedule, const Color(0xFF22C55E), null),
      _Service('Fare Info', 'Distance-based fare details', Icons.payments, const Color(0xFFF59E0B), null),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (_, c) {
          final isWide = c.maxWidth > 360;
          final cross = isWide ? 2 : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cross,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isWide ? 2.6 : 3.2,
            ),
            itemBuilder: (_, i) => _serviceCard(services[i]),
          );
        },
      ),
    );
  }

  Widget _serviceCard(_Service s) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: s.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(s.icon, color: s.color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          s.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (s.badge != null) ...[
                        const SizedBox(width: 6),
                        _tinyBadge(s.badge!, s.color),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.5, color: _sub),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Color(0xFFB6BCC6)),
          ],
        ),
      ),
    );
  }

  // ---------- STATS ----------
  Widget _buildStats() {
    Widget stat(String value, String label) => Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: _primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: _sub, fontWeight: FontWeight.w600),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 18,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          children: [
            const Text(
              'Trusted by thousands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _ink),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                stat('500+', 'Routes'),
                _divider(),
                stat('2,000+', 'Stops'),
                _divider(),
                stat('50K+', 'Users'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 36, color: const Color(0xFFE5E7EB));

  // ---------- FOOTER ----------
  Widget _buildFooter() {
    Text link(String t) => Text(
      t,
      style: const TextStyle(fontSize: 13, color: _sub, fontWeight: FontWeight.w600),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: link('About')),
              TextButton(onPressed: () {}, child: link('Help')),
              TextButton(onPressed: () {}, child: link('Contact')),
            ],
          ),
          const SizedBox(height: 4),
          const Text('© 2025 SHIFT LANKA', style: TextStyle(fontSize: 12, color: _sub)),
          const SizedBox(height: 4),
          const Text('English • සිංහල • தமிழ்', style: TextStyle(fontSize: 11, color: Color(0xFFA1A1AA))),
        ],
      ),
    );
  }

  // ---------- FAB ----------
  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: _accent,
      icon: const Icon(Icons.directions_bus_filled, color: Colors.white),
      label: const Text('Track Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  // ---------- BOTTOM NAV ----------
  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: BottomAppBar(
        color: _card,
        elevation: 16,
        height: 66,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home_filled, 'Home', 0),
            _navItem(Icons.route, 'Routes', 1),
            const SizedBox(width: 48), // FAB notch
            _navItem(Icons.favorite, 'Saved', 2),
            _navItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int idx) {
    final active = _currentTab == idx;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() => _currentTab = idx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 4, color: active ? _accent : _sub),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  color: active ? _accent : _sub,
                )),
          ],
        ),
      ),
    );
  }

  // ---------- SMALL PARTS ----------
  static Widget _iconBtn(IconData i, {required VoidCallback onTap}) => IconButton(
        icon: Icon(i, color: _sub),
        iconSize: 24,
        onPressed: onTap,
        splashRadius: 22,
      );

  static Widget _pill(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF1F5),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12, color: _sub, fontWeight: FontWeight.w700)),
      );

  static Widget _tinyBadge(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(6)),
        child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: color)),
      );

  static Widget _sectionTitle(String t) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.apps_rounded, size: 18, color: _sub),
            const SizedBox(width: 6),
            Text(
              t,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _ink, letterSpacing: 0.2),
            ),
          ],
        ),
      );

  static Widget _space(double h) => SizedBox(height: h);
  static SliverToBoxAdapter _spaceSliver(double h) => SliverToBoxAdapter(child: SizedBox(height: h));
}

// ---- DATA MODELS ----
class _Action {
  final String label;
  final IconData icon;
  final Color color;
  const _Action(this.label, this.icon, this.color);
}

class _Promo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String badge;
  _Promo({required this.title, required this.subtitle, required this.icon, required this.color, required this.badge});
}

class _Service {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? badge;
  _Service(this.title, this.subtitle, this.icon, this.color, this.badge);
}

// ---- REUSABLE GLASS CARD ----
class _Glass extends StatelessWidget {
  final Widget child;
  const _Glass({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.72),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE9ECF2)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ---- CHIP ----
class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.28),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w800, letterSpacing: 0.2),
      ),
    );
  }
}
