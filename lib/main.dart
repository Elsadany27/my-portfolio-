import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'cv_download.dart';

const String kLinkedInUrl =
    'https://www.linkedin.com/in/youssef-elsadany-aa5579236';
const String kGitHubUrl = 'https://github.com/Elsadany27';
const String kEmail = 'Youssefhussien211@gmail.com';

/// WhatsApp: CV number (+20) 01156378215 → international digits for wa.me (no + or leading 0).
const String kWhatsAppUrl = 'https://wa.me/201156378215';
const String kWhatsAppDisplay = '+20 11 56378215';

const Color _kAccent = Color(0xFFE53935);
const Color _kHeroBg = Color(0xFF0D0D0D);

/// Paste listing URLs per project. Leave `''` to hide that store button.
/// Play: `https://play.google.com/store/apps/details?id=...`
/// iOS: `https://apps.apple.com/.../id...`
Future<void> launchPortfolioUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open: $url')),
      );
    }
  }
}

/// Fades and slides content in when it enters the viewport (scroll reveal).
class _RevealOnScroll extends StatefulWidget {
  const _RevealOnScroll({
    required this.uniqueKey,
    required this.child,
    this.staggerIndex = 0,
  });

  final String uniqueKey;
  final Widget child;
  /// Extra delay per list item (milliseconds × index) for a cascading reveal.
  final int staggerIndex;

  @override
  State<_RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<_RevealOnScroll> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final extra = Duration(milliseconds: widget.staggerIndex * 72);

    return VisibilityDetector(
      key: Key(widget.uniqueKey),
      onVisibilityChanged: (info) {
        if (!_revealed && info.visibleFraction > 0.1) {
          setState(() => _revealed = true);
        }
      },
      child: _revealed
          ? widget.child
              .animate()
              .fadeIn(duration: 620.ms, delay: extra, curve: Curves.easeOutCubic)
              .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic)
          : Opacity(opacity: 0.01, child: widget.child),
    );
  }
}

class _BlinkCursor extends StatefulWidget {
  const _BlinkCursor({required this.fontSize});

  final double fontSize;

  @override
  State<_BlinkCursor> createState() => _BlinkCursorState();
}

class _BlinkCursorState extends State<_BlinkCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        '|',
        style: TextStyle(
          color: _kAccent,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w300,
          height: 1.15,
        ),
      ),
    );
  }
}

class _BouncingScrollHint extends StatefulWidget {
  const _BouncingScrollHint();

  @override
  State<_BouncingScrollHint> createState() => _BouncingScrollHintState();
}

class _BouncingScrollHintState extends State<_BouncingScrollHint> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 8 * _controller.value),
          child: child,
        );
      },
      child: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: _kAccent,
        size: 36,
      ),
    );
  }
}

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youssef Hussien Said — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: _kAccent,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: const Color(0xFF111111),
          secondary: const Color(0xFF404040),
          onSecondary: Colors.white,
          outline: const Color(0xFFCCCCCC),
        ),
        scaffoldBackgroundColor: Colors.white,
        dividerColor: const Color(0xFFDDDDDD),
        fontFamily: 'Segoe UI',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Color(0xFF000000),
            height: 1.15,
          ),
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111111),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Color(0xFF2A2A2A),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFF3A3A3A),
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            letterSpacing: 1.4,
            fontWeight: FontWeight.w600,
            color: Color(0xFF666666),
          ),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeNav = 'HOME';

  void _scrollTo(GlobalKey key, String navId) {
    setState(() => _activeNav = navId);
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  Future<void> _hireMe() async {
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Get in touch',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose email or WhatsApp — I typically reply within a day.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF666666),
                      ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: _kAccent.withValues(alpha: 0.12),
                    child: const Icon(Icons.mail_outline_rounded, color: _kAccent),
                  ),
                  title: const Text('Email'),
                  subtitle: SelectableText(kEmail),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final uri = Uri.parse(
                      'mailto:$kEmail?subject=${Uri.encodeComponent('Opportunity / Hire')}',
                    );
                    await launchUrl(uri);
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF25D366).withValues(alpha: 0.15),
                    child: const Icon(Icons.chat_rounded, color: Color(0xFF25D366)),
                  ),
                  title: const Text('WhatsApp'),
                  subtitle: Text(kWhatsAppDisplay),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () async {
                    Navigator.pop(ctx);
                    await launchPortfolioUrl(context, kWhatsAppUrl);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadCv() async {
    try {
      await downloadPortfolioCv();
    } catch (e, st) {
      debugPrint('CV download failed: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not load the CV file. You can still reach me at $kEmail.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final isWide = screenW >= 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroPanel(
              homeKey: _homeKey,
              isWide: isWide,
              activeNav: _activeNav,
              onNav: _scrollTo,
              onHire: _hireMe,
              onCv: _downloadCv,
              aboutKey: _aboutKey,
              experienceKey: _experienceKey,
              projectsKey: _projectsKey,
              skillsKey: _skillsKey,
              contactKey: _contactKey,
            ),
            KeyedSubtree(
              key: _aboutKey,
              child: _RevealOnScroll(
                uniqueKey: 'section-about',
                child: _AboutSection(),
              ),
            ),
            KeyedSubtree(
              key: _experienceKey,
              child: _RevealOnScroll(
                uniqueKey: 'section-experience',
                child: _SectionBlock(
                  title: 'Experience',
                  child: _ExperienceColumn(),
                ),
              ),
            ),
            KeyedSubtree(
              key: _projectsKey,
              child: _RevealOnScroll(
                uniqueKey: 'section-portfolio',
                child: _SectionBlock(
                  title: 'Portfolio',
                  child: _ProjectsColumn(),
                ),
              ),
            ),
            KeyedSubtree(
              key: _skillsKey,
              child: _RevealOnScroll(
                uniqueKey: 'section-skills',
                child: _SectionBlock(
                  title: 'Skills',
                  child: _SkillsColumn(),
                ),
              ),
            ),
            KeyedSubtree(
              key: _contactKey,
              child: _RevealOnScroll(
                uniqueKey: 'section-contact',
                child: _ContactFooter(
                  onLinkedIn: () => launchPortfolioUrl(context, kLinkedInUrl),
                  onGitHub: () => launchPortfolioUrl(context, kGitHubUrl),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _RevealOnScroll(
              uniqueKey: 'footer-copy',
              child: Center(
                child: Text(
                  '© ${DateTime.now().year} Youssef Hussien Said',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.homeKey,
    required this.isWide,
    required this.activeNav,
    required this.onNav,
    required this.onHire,
    required this.onCv,
    required this.aboutKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.contactKey,
  });

  final GlobalKey homeKey;
  final bool isWide;
  final String activeNav;
  final void Function(GlobalKey key, String navId) onNav;
  final VoidCallback onHire;
  final VoidCallback onCv;
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    // Shorter hero band: cap max height so the black section doesn’t dominate the viewport.
    final minHero = h.clamp(360.0, 560.0);

    return KeyedSubtree(
      key: homeKey,
      child: Container(
        color: _kHeroBg,
        constraints: BoxConstraints(minHeight: minHero),
        width: double.infinity,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopNav(
                    isWide: isWide,
                    activeNav: activeNav,
                    onNav: onNav,
                    homeKey: homeKey,
                    aboutKey: aboutKey,
                    experienceKey: experienceKey,
                    projectsKey: projectsKey,
                    skillsKey: skillsKey,
                    contactKey: contactKey,
                  )
                      .animate()
                      .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: -0.04, end: 0, curve: Curves.easeOutCubic),
                  SizedBox(height: isWide ? 40 : 24),
                  Text(
                    'I Am Youssef Hussien Said',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                  )
                      .animate()
                      .fadeIn(delay: 90.ms, duration: 520.ms, curve: Curves.easeOutCubic)
                      .slideX(begin: -0.03, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 16),
                  _HeroHeadline()
                      .animate()
                      .fadeIn(delay: 160.ms, duration: 600.ms, curve: Curves.easeOutCubic)
                      .slideX(begin: -0.025, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 20),
                  Text(
                    'Software Engineer with a bachelor\'s in Computer Science and Artificial Intelligence. '
                    'I build immersive cross-platform mobile experiences with Flutter—clean architecture, '
                    'thoughtful UI/UX, and reliable integrations. Based in Cairo, Egypt.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 15,
                        ),
                  )
                      .animate()
                      .fadeIn(delay: 240.ms, duration: 560.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.04, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: 28),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _GhostButton(
                        label: 'DOWNLOAD CV',
                        onPressed: onCv,
                      )
                          .animate()
                          .fadeIn(delay: 320.ms, duration: 500.ms)
                          .scale(
                            begin: const Offset(0.94, 0.94),
                            curve: Curves.easeOutBack,
                          ),
                      _GhostButton(
                        label: 'HIRE ME!',
                        onPressed: onHire,
                      )
                          .animate()
                          .fadeIn(delay: 380.ms, duration: 500.ms)
                          .scale(
                            begin: const Offset(0.94, 0.94),
                            curve: Curves.easeOutBack,
                          ),
                    ],
                  ),
                  SizedBox(height: isWide ? 32 : 24),
                  Center(
                    child: const _BouncingScrollHint()
                        .animate()
                        .fadeIn(delay: 480.ms, duration: 500.ms)
                        .shimmer(delay: 900.ms, duration: 1800.ms, color: Colors.white24),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroHeadline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const fontSize = 38.0;
    final baseStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontSize: fontSize,
          height: 1.15,
        );
    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: 'I Am Creative '),
          const TextSpan(
            text: 'Flutter Developer.',
            style: TextStyle(color: _kAccent),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: _BlinkCursor(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav({
    required this.isWide,
    required this.activeNav,
    required this.onNav,
    required this.homeKey,
    required this.aboutKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.contactKey,
  });

  final bool isWide;
  final String activeNav;
  final void Function(GlobalKey key, String navId) onNav;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem('HOME', homeKey),
      _NavItem('ABOUT', aboutKey),
      _NavItem('EXPERIENCE', experienceKey),
      _NavItem('PORTFOLIO', projectsKey),
      _NavItem('SKILLS', skillsKey),
      _NavItem('CONTACT', contactKey),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.work_outline_rounded, color: _kAccent, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUSSEF',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  'Portfolio',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        if (isWide)
          Wrap(
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: items
                .map(
                  (e) => _NavLink(
                    label: e.label,
                    active: activeNav == e.label,
                    onTap: () => onNav(e.key, e.label),
                  ),
                )
                .toList(),
          )
        else
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            color: _kHeroBg,
            onSelected: (v) {
              final m = items.firstWhere((e) => e.label == v);
              onNav(m.key, m.label);
            },
            itemBuilder: (ctx) => items
                .map(
                  (e) => PopupMenuItem(
                    value: e.label,
                    child: Text(
                      e.label,
                      style: TextStyle(
                        color: activeNav == e.label ? _kAccent : Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _NavItem {
  _NavItem(this.label, this.key);
  final String label;
  final GlobalKey key;
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hover ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: TextButton(
          onPressed: widget.onTap,
          style: TextButton.styleFrom(
            foregroundColor: widget.active ? _kAccent : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.8,
              decoration: _hover ? TextDecoration.underline : TextDecoration.none,
              decorationColor: _kAccent,
            ),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  const _GhostButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _hover ? 1.045 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: _kAccent.withValues(alpha: 0.45),
                      blurRadius: 18,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: OutlinedButton(
            onPressed: widget.onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: _hover ? Colors.white.withValues(alpha: 0.06) : null,
              side: BorderSide(
                color: _hover ? _kAccent : Colors.white,
                width: _hover ? 2 : 1.5,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(
            builder: (context, c) {
              final wide = c.maxWidth >= 720;
              final textBlock = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF111111),
                          decoration: TextDecoration.underline,
                          decorationColor: _kAccent,
                          decorationThickness: 3,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'I Am Youssef Hussien Said',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 32,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'I am a Software Engineer with a bachelor\'s degree in Computer Science and Artificial Intelligence. '
                    'I have a strong passion for mobile application development, particularly using Flutter, with 2 years of '
                    'hands-on experience. I am seeking opportunities as a Software Developer with an expert team of developers '
                    'who can help advance my career toward senior positions in the future.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Cairo, Egypt · (+20) 01156378215 · $kEmail · MS: Exempted',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF666666),
                        ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'EDUCATION',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          letterSpacing: 2,
                          color: const Color(0xFF000000),
                        ),
                  ),
                  const SizedBox(height: 12),
                  const _EducationRow(
                    school: 'Benha University',
                    detail: 'Bachelor, Computer Science and Artificial Intelligence',
                    period: 'Aug 2020 – Jun 2024',
                  ),
                  const _EducationRow(
                    school: 'Amit Learning — Maadi, Egypt',
                    detail: 'Diploma, mobile application development using Flutter (92%)',
                    period: 'Jun 2023 – Oct 2023',
                  ),
                ],
              );

              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBlock,
                    const SizedBox(height: 32),
                    const _AboutAvatar(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: textBlock),
                  const SizedBox(width: 48),
                  const Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: _AboutAvatar(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AboutAvatar extends StatelessWidget {
  const _AboutAvatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -8,
          top: -12,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _kAccent.withValues(alpha: 0.35), width: 1.5),
            ),
          ),
        ),
        Positioned(
          left: -16,
          bottom: 8,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12, width: 1.5),
            ),
          ),
        ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF0F0F0),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'YH',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 56,
                  color: const Color(0xFF222222),
                  letterSpacing: 2,
                ),
          ),
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 2,
                      color: const Color(0xFF000000),
                    ),
              ),
              const SizedBox(height: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      _ExperienceCard(
        title: 'Flutter Developer',
        org: 'Cyparta',
        period: 'Aug 2025 – Present',
        bullets: const [
          'Cross-platform apps for Android and iOS with Flutter; smooth, high-performance UX.',
          'Collaboration with UI/UX and backend teams; design reviews and code reviews.',
        ],
      ),
      _ExperienceCard(
        title: 'Flutter Developer Monitor',
        org: 'Cellula Technology',
        period: 'Jul 2025 – Dec 2025',
        bullets: const [
          'Structured code reviews for 20+ trainees; Clean Architecture and quality standards.',
          'Technical feedback reports; state management and architecture best practices.',
          'Weekly progress in Agile; performance evaluation and certification readiness.',
          'Mentoring on debugging, API integration, and scalable app structure.',
        ],
      ),
      _ExperienceCard(
        title: 'Flutter Developer',
        org: 'BoodSolutions',
        period: 'Jan 2025 – May 2025',
        bullets: const [
          'High-performance Flutter apps for Android and iOS.',
          'Close work with designers and backend developers; code reviews.',
        ],
      ),
      _ExperienceCard(
        title: 'Flutter Developer Intern',
        org: 'Cellula Technology',
        period: 'Sep 2024 – Nov 2024',
        bullets: const [
          'Hands-on Flutter and Dart; cross-platform mobile development.',
          'Two AI-integrated projects (e.g. Gemini AI & ML features).',
          'Stronger Flutter skills and ability to blend modern tech with mobile solutions.',
        ],
      ),
      _ExperienceCard(
        title: 'Flutter Developer (Training)',
        org: 'Information technology consultation and research — Benha University',
        period: 'Jul 2023 – Aug 2023',
        bullets: const [
          'Training in Flutter: cross-platform apps, UI/UX, state management, API integration.',
          'Projects combining technical depth with analytical skills for real-world scenarios.',
        ],
      ),
    ];

    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          _RevealOnScroll(
            uniqueKey: 'exp-card-$i',
            staggerIndex: i,
            child: items[i],
          ),
      ],
    );
  }
}

class _ProjectsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const _ProjectBlock(
        name: 'Find me',
        note: 'Graduation project — excellent grade (A+); among top 25 projects in college.',
        bullets: [
          'Injured-person recognition with user and admin apps for emergency response.',
          'Engagement with Health, Police, and Social Solidarity for emergency management.',
          'Flutter app with AI facial recognition to match injured people with families.',
        ],
        googlePlayUrl: '',
        appStoreUrl: '',
      ),
      const _ProjectBlock(
        name: 'HB App',
        bullets: [
          'Cosmetic surgery clinic app (Kuwait): bookings, treatment tracking, loyalty/cashback.',
          'Clinic updates, videos, and articles for patient engagement.',
        ],
        googlePlayUrl: 'https://play.google.com/store/apps/details?id=com.cyparta.hb',
        appStoreUrl: 'https://apps.apple.com/eg/app/hb-glow/id6754099949',
      ),
      const _ProjectBlock(
        name: 'Safarni',
        bullets: [
          'Hotels nearby and flight booking requests; simple UI.',
          'Location-based hotel browsing; 100+ downloads.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.safarni',
        appStoreUrl: 'https://apps.apple.com/eg/app/safarni/id6759935666',
      ),
      const _ProjectBlock(
        name: 'Mohadraty-D',
        bullets: [
          'University app for doctors: lectures, schedules, sections.',
          'Attendance per lecture/section; student search and profiles.',
        ],
        googlePlayUrl: '',
        appStoreUrl: 'https://apps.apple.com/eg/app/mohadraty-d/id6754034146',
      ),
      const _ProjectBlock(
        name: 'Fastlink Vendor',
        bullets: [
          'Vendor app (Nigeria & Kenya): products, categories, warehouse stock.',
          'Order statuses, offers, financial charts, secure withdrawals.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.fastlink_partner',
        appStoreUrl: 'https://apps.apple.com/eg/app/fastlink-vendor/id6756020469',
      ),
      const _ProjectBlock(
        name: 'Scholify',
        bullets: [
          'E-learning: browse and purchase courses; lectures with videos, files, quizzes, discussions.',
          'Favorites, profile, language, notifications for new courses and purchases.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.e_learnn',
        appStoreUrl:
            'https://apps.apple.com/ph/app/scholify-learn/id6756230905',
      ),
      const _ProjectBlock(
        name: 'Scholify – QR',
        bullets: [
          'Scan instructor QR to see courses; purchase in app.',
          'Full course access: lectures, media, quizzes, discussions.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.myplatform',
        appStoreUrl: '',
      ),
      const _ProjectBlock(
        name: 'Fe-khedmatek Sannie',
        bullets: [
          'Request craftsmen by service; location-based nearby providers.',
          'Fast connection to trusted providers.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.fekhimtak_sanaiae',
        appStoreUrl:
            'https://apps.apple.com/ph/app/%D9%81%D9%8A-%D8%AE%D8%AF%D9%85%D8%AA%D9%83-%D8%B5%D9%86%D8%A7%D9%8A%D8%B9%D9%8A/id6470123122',
      ),
      const _ProjectBlock(
        name: 'Almaoulaoui',
        bullets: [
          'Celebration booking (Syria): halls, DJs, lighting, photographers, music teams.',
          'Weddings, birthdays, corporate events; browse, compare, book in a few steps.',
        ],
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.cyparta.weeding',
        appStoreUrl: 'https://apps.apple.com/ph/app/almaoulaoui/id6757958284',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          _RevealOnScroll(
            uniqueKey: 'proj-$i',
            staggerIndex: i,
            child: items[i],
          ),
      ],
    );
  }
}

class _SkillsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Technical', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        const _SkillWrap([
          'Dart',
          'Flutter',
          'REST',
          'Dio',
          'HTTP',
          'OOP',
          'MVC',
          'MVVM',
          'Cubit',
          'State management',
          'Clean Architecture',
          'Solid Principles',
          'Dependency injection',
          'Firebase (Storage, DB, Realtime, Auth)',
          'Local DB',
          'MySQL',
          'GitHub',
          'Google Maps',
          'Local notifications',
          'Python',
        ]),
        const SizedBox(height: 16),
        Text('Soft', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        const _SkillWrap([
          'Leadership',
          'Teamwork',
          'Communication',
          'Problem solving',
          'Presentation',
          'Analytical thinking',
          'Time management',
        ]),
        const SizedBox(height: 20),
        Text('Languages', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        Text(
          'Arabic (Native) · English (Very good)',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _ContactFooter extends StatelessWidget {
  const _ContactFooter({
    required this.onLinkedIn,
    required this.onGitHub,
  });

  final VoidCallback onLinkedIn;
  final VoidCallback onGitHub;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 2,
                      color: const Color(0xFF000000),
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                "Let's talk about your next mobile product.",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              SelectableText(kEmail, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                children: [
                  FilledButton(
                    onPressed: onLinkedIn,
                    style: FilledButton.styleFrom(
                      backgroundColor: _kAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('LinkedIn'),
                  ),
                  OutlinedButton(
                    onPressed: onGitHub,
                    child: const Text('GitHub'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.title,
    required this.org,
    required this.period,
    required this.bullets,
  });

  final String title;
  final String org;
  final String period;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDDDDDD)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(org, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    period,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF666666),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...bullets.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('· ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(b, style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectBlock extends StatelessWidget {
  const _ProjectBlock({
    required this.name,
    required this.bullets,
    this.note,
    this.googlePlayUrl = '',
    this.appStoreUrl = '',
  });

  final String name;
  final String? note;
  final List<String> bullets;
  final String googlePlayUrl;
  final String appStoreUrl;

  @override
  Widget build(BuildContext context) {
    final hasPlay = googlePlayUrl.isNotEmpty;
    final hasIos = appStoreUrl.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.titleMedium),
          if (note != null) ...[
            const SizedBox(height: 4),
            Text(note!, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
          ],
          const SizedBox(height: 8),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('· ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: Text(b, style: Theme.of(context).textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
          if (hasPlay || hasIos) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (hasPlay)
                  _StoreLinkChip(
                    label: 'Google Play',
                    icon: Icons.play_circle_fill_rounded,
                    iconColor: const Color(0xFF3DDC84),
                    onPressed: () => launchPortfolioUrl(context, googlePlayUrl),
                  ),
                if (hasIos)
                  _StoreLinkChip(
                    label: 'App Store',
                    icon: Icons.apple,
                    iconColor: const Color(0xFF000000),
                    onPressed: () => launchPortfolioUrl(context, appStoreUrl),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StoreLinkChip extends StatelessWidget {
  const _StoreLinkChip({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: iconColor),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF111111),
        side: const BorderSide(color: Color(0xFFCCCCCC)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class _EducationRow extends StatelessWidget {
  const _EducationRow({
    required this.school,
    required this.detail,
    required this.period,
  });

  final String school;
  final String detail;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(school, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(detail, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            period,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF666666),
                ),
          ),
        ],
      ),
    );
  }
}

class _SkillWrap extends StatelessWidget {
  const _SkillWrap(this.skills);

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map(
            (s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFCCCCCC)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(s, style: Theme.of(context).textTheme.bodySmall),
            ),
          )
          .toList(),
    );
  }
}
