import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CampusApp());
}

// ═════════════════════════ THEME & COLOUR SYSTEM ═════════════════════════
// Primary : kPri (royal blue)   Accent : kAcc (coral)
// Tints   : Pal.soft (blue tint) and Pal.alt (light grey-blue section background)
// Card style: radius kRadius, subtle shadow, 1px border, rounded tinted icons.
final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

const kPri = Color(0xFF1547E0);
const kAcc = Color(0xFFFF6B4A);
const kNavy = Color(0xFF0A1A4A);
const kNavRed = Color(0xFFA51C30); // active colour of the bottom navigation bar
const double kRadius = 22;

class Pal {
  final bool dark;
  const Pal(this.dark);
  static Pal of(BuildContext c) => Pal(Theme.of(c).brightness == Brightness.dark);
  Color get bg => dark ? const Color(0xFF0B0F1C) : const Color(0xFFF9FAFD);
  Color get alt => dark ? const Color(0xFF0F1526) : const Color(0xFFEFF3FC);
  Color get card => dark ? const Color(0xFF151B2E) : Colors.white;
  Color get text => dark ? const Color(0xFFF1F4FB) : const Color(0xFF0E1530);
  Color get sub => dark ? const Color(0xFF9BA5C4) : const Color(0xFF5F6885);
  Color get line => dark ? const Color(0xFF232C48) : const Color(0xFFE4E8F3);
  Color get soft => dark ? const Color(0xFF1A2447) : const Color(0xFFEAF0FF);
  Color get main => dark ? const Color(0xFF7FA0FF) : kPri;
  Color get navActive => dark ? const Color(0xFFFF7A8A) : kNavRed;
}

ThemeData buildTheme(bool dark) => ThemeData(
  useMaterial3: true,
  brightness: dark ? Brightness.dark : Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: kPri, brightness: dark ? Brightness.dark : Brightness.light),
  scaffoldBackgroundColor: Pal(dark).bg,
);

class CampusApp extends StatelessWidget {
  const CampusApp({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: themeMode,
    builder: (_, m, __) => MaterialApp(
      title: 'Campus Pulse',
      debugShowCheckedModeBanner: false,
      themeMode: m,
      theme: buildTheme(false),
      darkTheme: buildTheme(true),
      home: const AppShell(),
    ),
  );
}

BoxDecoration cardBox(Pal p, {double r = kRadius}) => BoxDecoration(
  color: p.card,
  borderRadius: BorderRadius.circular(r),
  border: Border.all(color: p.line),
  boxShadow: p.dark ? null : const [BoxShadow(color: Color(0x141547E0), blurRadius: 26, offset: Offset(0, 12))],
);

// ═════════════════════════ DATA ═════════════════════════
const kName = 'Navadeep';
const kId = 'STU2024-1082';
const kProgram = 'B.Sc. Computer Science • Year 2';
const dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

class Slot {
  final int day;
  final String name, room, start, who;
  const Slot(this.day, this.name, this.room, this.start, this.who);
}

class Ev {
  final String day, month, title, cat, time, venue, desc, photo;
  const Ev(this.day, this.month, this.title, this.cat, this.time, this.venue, this.desc, this.photo);
}

class Svc {
  final String name, sub, info, badge;
  final IconData icon;
  final Color color;
  const Svc(this.name, this.sub, this.icon, this.color, this.info, [this.badge = '']);
}

const classes = <Slot>[
  Slot(0, 'Data Structures', 'Lab 3', '09:00', 'Dr. Lim'),
  Slot(0, 'Discrete Math', 'Hall B', '13:00', 'Prof. Kumar'),
  Slot(1, 'Database Systems', 'Room 12', '10:00', 'Dr. Aminah'),
  Slot(1, 'Web Development', 'Lab 1', '14:00', 'Mr. Tan'),
  Slot(2, 'Data Structures', 'Hall A', '09:00', 'Dr. Lim'),
  Slot(2, 'Technical English', 'Room 5', '11:00', 'Ms. Sofia'),
  Slot(3, 'Database Systems', 'Lab 2', '09:00', 'Dr. Aminah'),
  Slot(3, 'Discrete Math', 'Hall B', '14:00', 'Prof. Kumar'),
  Slot(4, 'Web Development', 'Lab 1', '09:00', 'Mr. Tan'),
  Slot(4, 'Student Seminar', 'Auditorium', '13:00', 'Faculty'),
];

const events = <Ev>[
  Ev('12', 'OCT', 'Innovation Hackathon', 'Hackathon', '9:00 AM – 6:00 PM', 'Innovation Hub', 'Build digital solutions in teams with mentors from industry.', '1517694712202-14dd9538aa97'),
  Ev('18', 'OCT', 'Cybersecurity Workshop', 'Workshop', '2:00 PM – 5:00 PM', 'Network Lab', 'Hands-on session on networks, threats and modern security tools.', '1550751827-4bd374c3f58b'),
  Ev('24', 'OCT', 'Career & Internship Fair', 'Career', '11:00 AM – 4:00 PM', 'Main Hall', 'Meet companies and explore internships and graduate roles.', '1521737604893-d14cc237f11d'),
  Ev('02', 'NOV', 'Tech Talk: AI in Industry', 'Talk', '3:00 PM – 4:30 PM', 'Auditorium', 'Speakers share how AI is changing real products and careers.', '1540575467063-178a50c2df87'),
];

const services = <Svc>[
  Svc('Timetable', 'Weekly classes', Icons.calendar_month_rounded, Color(0xFF1547E0), 'Your weekly timetable is on this Campus page, just below the services. Pick a day to see its classes.'),
  Svc('Results', 'Grades & GPA', Icons.assignment_rounded, Color(0xFFEC4899), 'Semester 3 GPA: 3.62. Cumulative CGPA: 3.55. Semester 4 results will be released on 20 January.', 'New'),
  Svc('Attendance', '92% present', Icons.fact_check_rounded, Color(0xFF10B981), 'Overall attendance is 92%. You need at least 85% to sit the final examinations.'),
  Svc('Fees', 'Payments', Icons.account_balance_wallet_rounded, Color(0xFF06B6D4), 'Semester 5 fees are due on 5 January. Pay online or at the Finance Office, Admin Block.', 'Due soon'),
  Svc('Library', 'Books & rooms', Icons.local_library_rounded, Color(0xFFF59E0B), 'Open 8:00 AM – 10:00 PM. You have 2 books due in 3 days. Group study rooms can be booked online.', 'Open'),
  Svc('Shuttle', 'Campus bus', Icons.directions_bus_rounded, Color(0xFF8B5CF6), 'Route A runs every 15 minutes. Route B is about 10 minutes late today. Next bus from Gate A at 10:25 AM.', 'On time'),
  Svc('Clubs', 'Activities', Icons.groups_rounded, Color(0xFFEF4444), 'You joined the Coding Club and the Photography Society. Next meeting: Thursday, 5:00 PM, Room 3.'),
  Svc('Helpdesk', 'Get support', Icons.support_agent_rounded, Color(0xFF64748B), 'Email help@campuspulse.edu or visit Admin Block, Level 1 (9:00 AM – 5:00 PM).', 'Available'),
];

int todayIdx() {
  final d = DateTime.now().weekday - 1;
  return d > 4 ? 0 : d;
}

// ═════════════════════════ SHARED WIDGETS ═════════════════════════
class _ArtPainter extends CustomPainter {
  final int seed;
  _ArtPainter(this.seed);
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
        rect,
        Paint()
          ..shader = const LinearGradient(colors: [kNavy, kPri, Color(0xFF5B7CFA)], begin: Alignment.topLeft, end: Alignment.bottomRight)
              .createShader(rect));
    final r = math.Random(seed);
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(r.nextDouble() * size.width, r.nextDouble() * size.height), size.shortestSide * (.25 + r.nextDouble() * .5),
          Paint()..color = Colors.white.withOpacity(.05 + r.nextDouble() * .06));
    }
  }

  @override
  bool shouldRepaint(covariant _ArtPainter o) => false;
}

/// New Campus Pulse logo: a signal-ripple (centre dot + two pulse rings + coral spark).
class PulseLogo extends StatelessWidget {
  final double size;
  final bool onDark;
  const PulseLogo(this.size, {super.key, this.onDark = false});
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size * .32),
      color: onDark ? Colors.white.withOpacity(.14) : null,
      gradient: onDark ? null : const LinearGradient(colors: [kNavy, kPri], begin: Alignment.topLeft, end: Alignment.bottomRight),
    ),
    child: CustomPaint(size: Size.square(size), painter: const _RipplePainter()),
  );
}

class _RipplePainter extends CustomPainter {
  const _RipplePainter();
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final c = Offset(w / 2, size.height / 2);
    final ring = Paint()..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(c, w * .10, Paint()..color = Colors.white);
    canvas.drawCircle(c, w * .23, ring..strokeWidth = w * .055..color = Colors.white);
    canvas.drawCircle(c, w * .36, ring..strokeWidth = w * .04..color = Colors.white.withOpacity(.5));
    const a = -math.pi / 4;
    canvas.drawCircle(c + Offset(math.cos(a), math.sin(a)) * (w * .23), w * .06, Paint()..color = kAcc);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter o) => false;
}

/// Photo: tries assets/images/<asset> first, then the internet, then generated artwork.
class Photo extends StatelessWidget {
  final String id, asset;
  final int seed;
  const Photo(this.id, {super.key, this.asset = '', this.seed = 1});
  @override
  Widget build(BuildContext context) {
    Widget art() => CustomPaint(painter: _ArtPainter(seed), size: Size.infinite);
    final net = Image.network(
      'https://images.unsplash.com/photo-$id?auto=format&fit=crop&w=1400&q=70',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => art(),
      loadingBuilder: (_, child, prog) => prog == null ? child : art(),
    );
    if (asset.isEmpty) return net;
    return Image.asset('assets/images/$asset',
        fit: BoxFit.cover, width: double.infinity, height: double.infinity, errorBuilder: (_, __, ___) => net);
  }
}

class Avatar extends StatelessWidget {
  final double size;
  const Avatar(this.size, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(.12), blurRadius: 12)]),
    child: ClipOval(
      child: Image.asset('assets/images/profile.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [kAcc, Color(0xFFFF9A5B)])),
            child: Text('N', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: size * .42)),
          )),
    ),
  );
}

/// Small status badge.
class Pill extends StatelessWidget {
  final String text;
  final Color color;
  final bool onDark;
  const Pill(this.text, this.color, {super.key, this.onDark = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: onDark ? Colors.white.withOpacity(.2) : color.withOpacity(.13), borderRadius: BorderRadius.circular(20)),
    child: Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, letterSpacing: .5, color: onDark ? Colors.white : color)),
  );
}

/// Page section with a centred max-width column (responsive constraint).
class Section extends StatelessWidget {
  final Widget child;
  final Color? bg;
  final double top, bottom;
  const Section({super.key, required this.child, this.bg, this.top = 64, this.bottom = 64});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    return Container(
      width: double.infinity,
      color: bg,
      padding: EdgeInsets.only(top: wide ? top : top * .6, bottom: wide ? bottom : bottom * .6),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1120),
          padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20),
          child: child,
        ),
      ),
    );
  }
}

class SecHead extends StatelessWidget {
  final String eyebrow, title, sub;
  const SecHead(this.eyebrow, this.title, this.sub, {super.key});
  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final wide = MediaQuery.of(context).size.width >= 900;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(eyebrow, style: const TextStyle(color: kAcc, fontSize: 12.5, fontWeight: FontWeight.w800, letterSpacing: 1.8)),
        const SizedBox(height: 10),
        Text(title, style: TextStyle(fontSize: wide ? 36 : 28, fontWeight: FontWeight.w800, letterSpacing: -1.1, height: 1.1, color: p.text)),
        if (sub.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(sub, style: TextStyle(color: p.sub, fontSize: 16, height: 1.5)),
        ],
      ]),
    );
  }
}

/// Banner used at the top of the Events, Campus and Profile pages.
class PageBanner extends StatelessWidget {
  final String eyebrow, title, sub;
  final IconData icon;
  final int seed;
  const PageBanner({super.key, required this.eyebrow, required this.title, required this.sub, required this.icon, this.seed = 5});
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;
    return Stack(children: [
      Positioned.fill(child: CustomPaint(painter: _ArtPainter(seed))),
      Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1120),
          padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20, vertical: wide ? 56 : 30),
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(eyebrow, style: TextStyle(color: Colors.white.withOpacity(.75), fontSize: 12.5, fontWeight: FontWeight.w800, letterSpacing: 1.8)),
                const SizedBox(height: 8),
                Text(title, style: TextStyle(color: Colors.white, fontSize: wide ? 46 : 32, fontWeight: FontWeight.w800, letterSpacing: -1.2, height: 1.05)),
                const SizedBox(height: 8),
                Text(sub, style: TextStyle(color: Colors.white.withOpacity(.82), fontSize: wide ? 17 : 15, height: 1.45)),
              ]),
            ),
            const SizedBox(width: 16),
            Container(
              width: wide ? 84 : 60,
              height: wide ? 84 : 60,
              decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white.withOpacity(.3))),
              child: Icon(icon, color: Colors.white, size: wide ? 40 : 30),
            ),
          ]),
        ),
      ),
    ]);
  }
}

/// Reusable quick-access card (required reusable component).
class CampusActionCard extends StatelessWidget {
  final Svc s;
  final bool selected;
  final VoidCallback onTap;
  const CampusActionCard({super.key, required this.s, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 124),
      decoration: BoxDecoration(
        color: selected ? s.color.withOpacity(.12) : p.card,
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: selected ? s.color : p.line, width: selected ? 2 : 1),
        boxShadow: p.dark ? null : const [BoxShadow(color: Color(0x101547E0), blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(kRadius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: s.color.withOpacity(.14), borderRadius: BorderRadius.circular(15)),
                  child: Icon(s.icon, color: s.color, size: 25),
                ),
                const SizedBox(width: 6),
                const Spacer(),
                if (s.badge.isNotEmpty) Flexible(child: Pill(s.badge, s.color)),
              ]),
              const SizedBox(height: 14),
              Text(s.name, style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: p.text)),
              const SizedBox(height: 2),
              Text(s.sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: p.sub, fontSize: 13.5)),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Reusable event card used on the Events page.
class EventCard extends StatelessWidget {
  final Ev e;
  final int seed;
  final bool going;
  final VoidCallback onToggle;
  const EventCard({super.key, required this.e, required this.seed, required this.going, required this.onToggle});
  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: cardBox(p, r: 26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 170,
          child: Stack(fit: StackFit.expand, children: [
            Photo(e.photo, seed: seed),
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                width: 56,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: Column(children: [
                  Text(e.day, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: kNavy, height: 1)),
                  const SizedBox(height: 2),
                  Text(e.month, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: kAcc, letterSpacing: 1)),
                ]),
              ),
            ),
            Positioned(top: 14, right: 14, child: Pill(e.cat.toUpperCase(), Colors.white, onDark: true)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: -.3, color: p.text)),
            const SizedBox(height: 6),
            Text(e.desc, style: TextStyle(color: p.sub, height: 1.4, fontSize: 13.5)),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.schedule_rounded, size: 16, color: kAcc),
              const SizedBox(width: 6),
              Expanded(child: Text(e.time, style: TextStyle(color: p.sub, fontSize: 13))),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.place_outlined, size: 16, color: kAcc),
              const SizedBox(width: 6),
              Expanded(child: Text(e.venue, style: TextStyle(color: p.sub, fontSize: 13))),
            ]),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: going ? const Color(0xFF16A34A) : kPri,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: onToggle,
              child: Text(going ? '✓ Registered' : 'Register', style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ]),
        ),
      ]),
    );
  }
}

void showInfo(BuildContext context, String title, IconData icon, Color color, String body) {
  final p = Pal.of(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      decoration: BoxDecoration(color: p.card, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 44, height: 5, decoration: BoxDecoration(color: p.line, borderRadius: BorderRadius.circular(3))),
        const SizedBox(height: 24),
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color.withOpacity(.14), borderRadius: BorderRadius.circular(22)),
          child: Icon(icon, color: color, size: 34),
        ),
        const SizedBox(height: 16),
        Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: p.text)),
        const SizedBox(height: 8),
        Text(body, textAlign: TextAlign.center, style: TextStyle(color: p.sub, fontSize: 15, height: 1.5)),
        const SizedBox(height: 24),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: kPri, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ]),
    ),
  );
}

class _RingPainter extends CustomPainter {
  final double v;
  final Color color, track;
  _RingPainter(this.v, this.color, this.track);
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2 - 5;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..color = track;
    canvas.drawCircle(c, r, paint);
    paint.color = color;
    canvas.drawArc(Rect.fromCircle(center: c, radius: r), -math.pi / 2, 2 * math.pi * v, false, paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter o) => o.v != v;
}

// ═════════════════════════ APP SHELL (top bar + pages + bottom bar) ═════════════════════════
/// Shared state and actions handed to every page.
class Ctl {
  final int selected;
  final Set<int> going;
  final ValueChanged<int> go, pick, toggleGoing;
  final void Function(String) snack;
  const Ctl({required this.selected, required this.going, required this.go, required this.pick, required this.toggleGoing, required this.snack});
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const nav = ['Home', 'Events', 'Campus', 'Profile'];
  int tab = 0, selected = -1;
  final Set<int> going = {};

  void _go(int i) => setState(() => tab = i);

  void _snack(String msg, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg), action: action));
  }

  void _pick(int i) {
    setState(() => selected = i);
    final s = services[i];
    _snack('${s.name} selected',
        action: SnackBarAction(label: 'DETAILS', onPressed: () => showInfo(context, s.name, s.icon, s.color, s.info)));
  }

  void _toggleGoing(int i) {
    setState(() => going.contains(i) ? going.remove(i) : going.add(i));
    _snack(going.contains(i) ? 'Registered for ${events[i].title}' : 'Registration cancelled');
  }

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final wide = MediaQuery.of(context).size.width >= 900;
    final c = Ctl(selected: selected, going: going, go: _go, pick: _pick, toggleGoing: _toggleGoing, snack: _snack);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: p.dark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        bottomNavigationBar: wide ? null : _bottomBar(p),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _topBar(p, wide),
          Expanded(
            child: SafeArea(
              top: false,
              child: IndexedStack(index: tab, children: [
                HomePage(c: c),
                EventsPage(c: c),
                CampusPage(c: c),
                ProfilePage(c: c),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  // Bottom navigation bar (Home • Events • Campus • Profile)
  Widget _bottomBar(Pal p) => Container(
    decoration: BoxDecoration(
      color: p.card,
      border: Border(top: BorderSide(color: p.line)),
      boxShadow: p.dark ? null : const [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, -2))],
    ),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: p.card,
      elevation: 0,
      currentIndex: tab,
      selectedItemColor: p.navActive,
      unselectedItemColor: p.sub,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      onTap: _go,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.event_outlined), activeIcon: Icon(Icons.event_rounded), label: 'Events'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), activeIcon: Icon(Icons.map_rounded), label: 'Campus'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
      ],
    ),
  );

  // Top bar (page tabs appear here on wide screens only)
  Widget _topBar(Pal p, bool wide) => Container(
    decoration: BoxDecoration(color: p.card, border: Border(bottom: BorderSide(color: p.line))),
    child: SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          height: 66,
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            const PulseLogo(40),
            const SizedBox(width: 10),
            Flexible(
              child: Text('Campus Pulse',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, letterSpacing: -.5, color: p.text)),
            ),
            if (wide) ...[
              const SizedBox(width: 28),
              for (int i = 0; i < nav.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: GestureDetector(
                    onTap: () => _go(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      constraints: const BoxConstraints(minHeight: 44),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: tab == i ? p.soft : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: tab == i ? p.main : Colors.transparent),
                      ),
                      child: Text(nav[i], style: TextStyle(fontWeight: FontWeight.w700, color: tab == i ? p.main : p.sub)),
                    ),
                  ),
                ),
            ],
            const Spacer(),
            IconButton(
              onPressed: () => themeMode.value = p.dark ? ThemeMode.light : ThemeMode.dark,
              icon: Icon(p.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            ),
            Stack(alignment: Alignment.center, children: [
              IconButton(onPressed: () => _snack('You have 3 new notifications'), icon: const Icon(Icons.notifications_none_rounded)),
              Positioned(top: 12, right: 12, child: Container(width: 9, height: 9, decoration: BoxDecoration(color: kAcc, shape: BoxShape.circle, border: Border.all(color: p.card, width: 1.5)))),
            ]),
            GestureDetector(onTap: () => _go(3), child: const Padding(padding: EdgeInsets.only(left: 4, right: 4), child: Avatar(40))),
          ]),
        ),
      ),
    ),
  );
}

// ═════════════════════════ PAGE 1: HOME ═════════════════════════
class HomePage extends StatelessWidget {
  final Ctl c;
  const HomePage({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final wide = MediaQuery.of(context).size.width >= 900;
    return SingleChildScrollView(
      primary: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _hero(p, wide),
        Section(child: _updateSection(context, p, wide)),
        Section(bg: p.alt, child: _nextEvents(p)),
        _footer(p, wide),
      ]),
    );
  }

  Widget _hero(Pal p, bool wide) {
    final today = classes.where((x) => x.day == todayIdx()).toList();
    final weekend = DateTime.now().weekday > 5;

    final left = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('CAMPUS PULSE STUDENT DASHBOARD',
          style: TextStyle(color: Colors.white.withOpacity(.75), fontSize: 12.5, fontWeight: FontWeight.w800, letterSpacing: 1.8)),
      const SizedBox(height: 12),
      const Pill('WELCOME BACK, NAVADEEP', Colors.white, onDark: true),
      const SizedBox(height: 22),
      Text('Learn. Connect.\nThrive on campus.',
          style: TextStyle(color: Colors.white, fontSize: wide ? 62 : 36, height: 1.05, fontWeight: FontWeight.w800, letterSpacing: wide ? -2.2 : -1.2)),
      const SizedBox(height: 18),
      Text('One place for your classes, campus services, events and student life.',
          style: TextStyle(color: Colors.white.withOpacity(.82), fontSize: wide ? 18 : 16, height: 1.5)),
      const SizedBox(height: 26),
      Wrap(spacing: 12, runSpacing: 12, children: [
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: kAcc, foregroundColor: Colors.white, minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 26), shape: const StadiumBorder()),
          onPressed: () => c.go(2),
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Explore campus', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 26), side: const BorderSide(color: Colors.white70), shape: const StadiumBorder()),
          onPressed: () => c.go(1),
          child: const Text('View events', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
        ),
      ]),
    ]);

    final card = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.14),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(weekend ? 'UP NEXT' : 'TODAY', style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.6)),
              const SizedBox(height: 2),
              Text(dayNames[todayIdx()], style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -.6)),
            ]),
          ),
          Container(width: 46, height: 46, decoration: BoxDecoration(color: Colors.white.withOpacity(.18), shape: BoxShape.circle), child: const Icon(Icons.wb_sunny_rounded, color: Color(0xFFFFD166))),
        ]),
        const SizedBox(height: 18),
        for (int i = 0; i < today.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == today.length - 1 ? 0 : 14),
            child: Row(children: [
              SizedBox(width: 54, child: Text(today[i].start, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))),
              Container(width: 3, height: 38, margin: const EdgeInsets.only(right: 14), decoration: BoxDecoration(color: kAcc, borderRadius: BorderRadius.circular(3))),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(today[i].name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  Text('${today[i].room} • ${today[i].who}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ]),
              ),
            ]),
          ),
      ]),
    );

    return Stack(children: [
      const Positioned.fill(child: Photo('1562774053-701939374585', asset: 'campus.jpg', seed: 3)),
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: wide
                ? const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xF20A1A4A), Color(0xB80A1A4A), Color(0x400A1A4A)])
                : const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xB00A1A4A), Color(0xF00A1A4A)]),
          ),
        ),
      ),
      Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1120, minHeight: wide ? 560 : 0),
          padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20, vertical: wide ? 64 : 40),
          alignment: Alignment.center,
          child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(flex: 6, child: left),
            const SizedBox(width: 48),
            Expanded(flex: 4, child: card),
          ])
              : Column(children: [left, const SizedBox(height: 30), card]),
        ),
      ),
    ]);
  }

  Widget _updateSection(BuildContext context, Pal p, bool wide) {
    const amber = Color(0xFFF59E0B);
    final announcement = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: p.dark ? amber.withOpacity(.10) : const Color(0xFFFFF6E3),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: amber.withOpacity(.55), width: 1.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 50, height: 50, alignment: Alignment.center, decoration: BoxDecoration(color: amber.withOpacity(.2), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.campaign_rounded, color: amber)),
          const Spacer(),
          const Pill('DUE SOON', amber),
        ]),
        const SizedBox(height: 16),
        Text('Semester 5 registration', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: -.5, color: p.text)),
        const SizedBox(height: 8),
        Text('Course registration closes soon. Confirm your advisor approval before you submit your course choices in the portal.',
            style: TextStyle(color: p.sub, height: 1.5, fontSize: 15.5)),
        const SizedBox(height: 14),
        Row(children: [
          const Icon(Icons.event_rounded, size: 19, color: amber),
          const SizedBox(width: 8),
          Flexible(child: Text('Deadline: 15 Oct • 5:00 PM', style: TextStyle(color: p.text, fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: 20),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: kPri, foregroundColor: Colors.white, minimumSize: const Size(160, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          onPressed: () => showInfo(context, 'How to register', Icons.how_to_reg_rounded, amber, '1. Meet your advisor for approval.\n2. Choose your courses in the portal.\n3. Submit before 15 Oct, 5:00 PM.'),
          icon: const Icon(Icons.list_alt_rounded, size: 20),
          label: const Text('View steps', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ]),
    );

    Widget notice(IconData i, Color col, String t, String s, String badge) => Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: cardBox(p, r: 22),
      child: Row(children: [
        Container(width: 48, height: 48, alignment: Alignment.center, decoration: BoxDecoration(color: col.withOpacity(.14), borderRadius: BorderRadius.circular(15)), child: Icon(i, color: col)),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5, color: p.text)),
            const SizedBox(height: 2),
            Text(s, style: TextStyle(color: p.sub, fontSize: 13.5, height: 1.35)),
          ]),
        ),
        const SizedBox(width: 8),
        Pill(badge, col),
      ]),
    );

    final notices = Column(children: [
      notice(Icons.directions_bus_rounded, const Color(0xFFEF4444), 'Shuttle update', 'Route B is running about 10 minutes late from Gate A.', 'DELAYED'),
      notice(Icons.local_library_rounded, const Color(0xFF3B82F6), 'Library hours', 'Extended to 11:00 PM during exam week.', 'NEW'),
      notice(Icons.school_rounded, const Color(0xFF10B981), 'Scholarship briefing', 'Friday, 3:00 PM, Auditorium. Bring your ID.', 'OPEN'),
    ]);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SecHead('CAMPUS UPDATE', 'What\'s new on campus.', 'Important notices and deadlines for this week.'),
      wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 5, child: announcement),
        const SizedBox(width: 24),
        Expanded(flex: 5, child: notices),
      ])
          : Column(children: [announcement, const SizedBox(height: 20), notices]),
    ]);
  }

  // Compact preview of the next two events with a link to the Events page.
  Widget _nextEvents(Pal p) {
    Widget row(int i) {
      final e = events[i];
      return Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: cardBox(p, r: 22),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => c.go(1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Container(
                  width: 58,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(16)),
                  child: Column(children: [
                    Text(e.day, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: p.main, height: 1)),
                    const SizedBox(height: 2),
                    Text(e.month, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: kAcc, letterSpacing: 1)),
                  ]),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: p.text)),
                    const SizedBox(height: 3),
                    Text('${e.time} • ${e.venue}', style: TextStyle(color: p.sub, fontSize: 13)),
                  ]),
                ),
                Icon(c.going.contains(i) ? Icons.check_circle_rounded : Icons.chevron_right_rounded, color: c.going.contains(i) ? const Color(0xFF16A34A) : p.sub),
              ]),
            ),
          ),
        ),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SecHead('COMING UP', 'Next on campus.', 'Tap an event to open the Events page.'),
      row(0),
      row(1),
      const SizedBox(height: 6),
      OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: const Size(0, 50), padding: const EdgeInsets.symmetric(horizontal: 22), side: BorderSide(color: p.line), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        onPressed: () => c.go(1),
        icon: Icon(Icons.arrow_forward_rounded, size: 19, color: p.text),
        label: Text('See all events', style: TextStyle(color: p.text, fontWeight: FontWeight.w700)),
      ),
    ]);
  }

  Widget _footer(Pal p, bool wide) {
    const soft = Color(0xFFB5BEDD);
    Widget link(String t, VoidCallback f) => InkWell(
      onTap: f,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 7), child: Text(t, style: const TextStyle(color: soft, fontSize: 14.5))),
    );
    Widget col(String t, List<Widget> items) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15.5)),
      const SizedBox(height: 12),
      ...items,
    ]);

    final brand = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [
        PulseLogo(40, onDark: true),
        SizedBox(width: 10),
        Text('Campus Pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21)),
      ]),
      const SizedBox(height: 14),
      const SizedBox(width: 300, child: Text('Feel the heartbeat of your campus.', style: TextStyle(color: soft, height: 1.5))),
    ]);
    final explore = col('Explore', [
      link('Home', () => c.go(0)),
      link('Events', () => c.go(1)),
      link('Campus', () => c.go(2)),
      link('Profile', () => c.go(3)),
    ]);
    final contact = col('Contact', [
      link('help@campuspulse.edu', () => c.snack('help@campuspulse.edu')),
      link('+60 6-799 0000', () => c.snack('+60 6-799 0000')),
      link('Admin Block, Level 1', () => c.snack('Admin Block, Level 1')),
    ]);

    return Container(
      width: double.infinity,
      color: kNavy,
      padding: EdgeInsets.only(top: wide ? 72 : 52, bottom: 28),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1120),
          padding: EdgeInsets.symmetric(horizontal: wide ? 32 : 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [kPri, Color(0xFF5B7CFA)]), borderRadius: BorderRadius.circular(28)),
              child: Wrap(spacing: 20, runSpacing: 18, alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, children: [
                const SizedBox(
                  width: 520,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Need help? We\'re here.', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -.6)),
                    SizedBox(height: 6),
                    Text('The Helpdesk is open Monday to Friday, 9:00 AM – 5:00 PM.', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  ]),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: kPri, minimumSize: const Size(180, 52), shape: const StadiumBorder()),
                  onPressed: () => c.snack('Connecting you to the Helpdesk…'),
                  child: const Text('Contact Helpdesk', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ]),
            ),
            SizedBox(height: wide ? 56 : 40),
            wide
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 4, child: brand),
              Expanded(flex: 2, child: explore),
              Expanded(flex: 3, child: contact),
            ])
                : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [brand, const SizedBox(height: 28), explore, const SizedBox(height: 28), contact]),
            const SizedBox(height: 36),
            Divider(color: Colors.white.withOpacity(.14)),
            const SizedBox(height: 14),
            const Text('© 2026 Campus Pulse. Prototype with sample data.', style: TextStyle(color: soft, fontSize: 13)),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}

// ═════════════════════════ PAGE 2: EVENTS ═════════════════════════
class EventsPage extends StatefulWidget {
  final Ctl c;
  const EventsPage({super.key, required this.c});
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String cat = 'All';

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final c = widget.c;
    final cats = <String>['All', ...events.map((e) => e.cat).toSet()];
    final shown = [
      for (int i = 0; i < events.length; i++)
        if (cat == 'All' || events[i].cat == cat) i
    ];

    return SingleChildScrollView(
      primary: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const PageBanner(eyebrow: 'STUDENT LIFE', title: 'Upcoming events', sub: 'Hackathons, workshops, career fairs and talks.', icon: Icons.event_rounded, seed: 21),
        Section(
          top: 36,
          bottom: 48,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Registration summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(20), border: Border.all(color: p.line)),
              child: Row(children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: p.main.withOpacity(.15), borderRadius: BorderRadius.circular(14)),
                  child: Icon(Icons.confirmation_number_outlined, color: p.main),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    c.going.isEmpty ? 'You have not registered for any events yet.' : 'You are registered for ${c.going.length} of ${events.length} events.',
                    style: TextStyle(color: p.text, fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            // Category filter
            Wrap(spacing: 10, runSpacing: 10, children: [
              for (final k in cats)
                ChoiceChip(
                  label: Text(k, style: TextStyle(fontWeight: FontWeight.w700, color: cat == k ? Colors.white : p.text)),
                  selected: cat == k,
                  showCheckmark: false,
                  selectedColor: kPri,
                  backgroundColor: p.card,
                  side: BorderSide(color: cat == k ? kPri : p.line),
                  shape: const StadiumBorder(),
                  onSelected: (_) => setState(() => cat = k),
                ),
            ]),
            const SizedBox(height: 24),
            LayoutBuilder(builder: (context, box) {
              final cols = box.maxWidth > 900 ? 4 : (box.maxWidth > 560 ? 2 : 1);
              const gap = 20.0;
              final cw = (box.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(spacing: gap, runSpacing: gap, children: [
                for (final i in shown)
                  SizedBox(
                    width: cw,
                    child: EventCard(e: events[i], seed: i + 1, going: c.going.contains(i), onToggle: () => c.toggleGoing(i)),
                  ),
              ]);
            }),
          ]),
        ),
      ]),
    );
  }
}

// ═════════════════════════ PAGE 3: CAMPUS ═════════════════════════
class CampusPage extends StatefulWidget {
  final Ctl c;
  const CampusPage({super.key, required this.c});
  @override
  State<CampusPage> createState() => _CampusPageState();
}

class _CampusPageState extends State<CampusPage> {
  int day = todayIdx();

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final c = widget.c;
    final list = classes.where((x) => x.day == day).toList();

    return SingleChildScrollView(
      primary: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const PageBanner(eyebrow: 'CAMPUS HUB', title: 'Your campus', sub: 'Services, timetable and shuttle, all in one place.', icon: Icons.map_rounded, seed: 33),
        Section(
          top: 36,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SecHead('CAMPUS SERVICES', 'Everything you need.', 'Tap a service to select it and see quick details.'),
            LayoutBuilder(builder: (context, box) {
              final cols = box.maxWidth > 820 ? 4 : (box.maxWidth > 520 ? 3 : 2);
              const gap = 16.0;
              final cw = (box.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(spacing: gap, runSpacing: gap, children: [
                for (int i = 0; i < services.length; i++)
                  SizedBox(width: cw, child: CampusActionCard(s: services[i], selected: c.selected == i, onTap: () => c.pick(i))),
              ]);
            }),
          ]),
        ),
        Section(
          bg: p.alt,
          bottom: 48,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SecHead('WEEKLY TIMETABLE', 'Your classes.', 'Choose a day to see what is scheduled.'),
            Wrap(spacing: 10, runSpacing: 10, children: [
              for (int i = 0; i < dayNames.length; i++)
                ChoiceChip(
                  label: Text(dayNames[i].substring(0, 3), style: TextStyle(fontWeight: FontWeight.w700, color: day == i ? Colors.white : p.text)),
                  selected: day == i,
                  showCheckmark: false,
                  selectedColor: kPri,
                  backgroundColor: p.card,
                  side: BorderSide(color: day == i ? kPri : p.line),
                  shape: const StadiumBorder(),
                  onSelected: (_) => setState(() => day = i),
                ),
            ]),
            const SizedBox(height: 20),
            for (final s in list)
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: cardBox(p, r: 22),
                child: Row(children: [
                  Container(
                    width: 66,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(16)),
                    child: Text(s.start, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: p.main)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(s.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: p.text)),
                      const SizedBox(height: 3),
                      Text('${s.room} • ${s.who}', style: TextStyle(color: p.sub, fontSize: 13.5)),
                    ]),
                  ),
                  if (day == todayIdx() && DateTime.now().weekday <= 5) const Pill('TODAY', kAcc),
                ]),
              ),
          ]),
        ),
      ]),
    );
  }
}

// ═════════════════════════ PAGE 4: PROFILE ═════════════════════════
class ProfilePage extends StatefulWidget {
  final Ctl c;
  const ProfilePage({super.key, required this.c});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final c = widget.c;
    final wide = MediaQuery.of(context).size.width >= 900;

    Widget info(IconData i, String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(children: [
        Icon(i, size: 19, color: p.sub),
        const SizedBox(width: 12),
        Expanded(child: Text(t, style: TextStyle(color: p.sub, fontSize: 14.5))),
      ]),
    );

    final profile = Container(
      clipBehavior: Clip.antiAlias,
      decoration: cardBox(p, r: 28),
      child: Stack(alignment: Alignment.topCenter, children: [
        Column(children: [
          SizedBox(height: 104, width: double.infinity, child: CustomPaint(painter: _ArtPainter(11))),
          const SizedBox(height: 62),
          Text(kName, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -.5, color: p.text)),
          const SizedBox(height: 4),
          const Text('B.Sc. Computer Science', style: TextStyle(color: kAcc, fontWeight: FontWeight.w700, fontSize: 15.5)),
          const SizedBox(height: 4),
          Text('Year 2 · Student ID $kId', style: TextStyle(color: p.sub, fontSize: 13.5)),
          const SizedBox(height: 10),
          const Pill('ACTIVE STUDENT', Color(0xFF16A34A)),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(children: [
              Divider(color: p.line),
              info(Icons.mail_outline_rounded, 'navadeep@student.campuspulse.edu'),
              info(Icons.person_pin_rounded, 'Advisor: Dr. Lim'),
              info(Icons.place_outlined, 'Block A, Campus Level 2'),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), side: BorderSide(color: p.line), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                onPressed: () => c.snack('Edit profile is coming soon'),
                icon: Icon(Icons.edit_outlined, size: 19, color: p.text),
                label: Text('Edit profile', style: TextStyle(color: p.text, fontWeight: FontWeight.w700)),
              ),
            ]),
          ),
        ]),
        const Positioned(top: 56, child: Avatar(100)),
      ]),
    );

    Widget tile(Widget child) => Container(
      constraints: const BoxConstraints(minHeight: 172),
      padding: const EdgeInsets.all(16),
      decoration: cardBox(p, r: 24),
      child: child,
    );
    Widget label(String t) => Text(t, style: TextStyle(color: p.sub, fontWeight: FontWeight.w700, fontSize: 13.5));
    Widget big(String v, String of) => Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(v, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: -1, color: p.text)),
      const SizedBox(width: 5),
      Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(of, style: TextStyle(fontSize: 13, color: p.sub))),
    ]);
    Widget bar(double v, Color col) => ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(value: v, minHeight: 8, color: col, backgroundColor: col.withOpacity(.14)),
    );

    final indicators = LayoutBuilder(builder: (context, box) {
      final tw = (box.maxWidth - 16) / 2;
      return Wrap(spacing: 16, runSpacing: 16, children: [
        SizedBox(
          width: tw,
          child: tile(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label('CGPA'),
            const SizedBox(height: 8),
            big('3.55', '/ 4.00'),
            const SizedBox(height: 10),
            bar(.89, const Color(0xFF10B981)),
            const SizedBox(height: 12),
            const Pill('DEAN\'S LIST', Color(0xFF10B981)),
          ])),
        ),
        SizedBox(
          width: tw,
          child: tile(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label('Credits earned'),
            const SizedBox(height: 8),
            big('84', '/ 120'),
            const SizedBox(height: 10),
            bar(.70, const Color(0xFFF59E0B)),
            const SizedBox(height: 12),
            const Pill('ON TRACK', Color(0xFFF59E0B)),
          ])),
        ),
        SizedBox(
          width: tw,
          child: tile(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label('Attendance'),
            const SizedBox(height: 8),
            SizedBox(
              width: 68,
              height: 68,
              child: Stack(alignment: Alignment.center, children: [
                CustomPaint(size: const Size(68, 68), painter: _RingPainter(.92, kPri, p.soft)),
                Text('92%', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: p.text)),
              ]),
            ),
            const SizedBox(height: 10),
            const Pill('EXCELLENT', kPri),
          ])),
        ),
        SizedBox(
          width: tw,
          child: tile(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            label('Semester'),
            const SizedBox(height: 8),
            big('4', 'of 6'),
            const SizedBox(height: 10),
            bar(.66, kAcc),
            const SizedBox(height: 12),
            const Pill('GOOD STATUS', kAcc),
          ])),
        ),
      ]);
    });

    Widget settingRow(IconData icon, Color col, String title, String sub, Widget trailing, VoidCallback? onTap) => Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(children: [
            Container(width: 44, height: 44, alignment: Alignment.center, decoration: BoxDecoration(color: col.withOpacity(.14), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: col, size: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5, color: p.text)),
                const SizedBox(height: 2),
                Text(sub, style: TextStyle(color: p.sub, fontSize: 13)),
              ]),
            ),
            trailing,
          ]),
        ),
      ),
    );

    final settings = Container(
      clipBehavior: Clip.antiAlias,
      decoration: cardBox(p, r: 24),
      child: Column(children: [
        settingRow(Icons.dark_mode_rounded, const Color(0xFF8B5CF6), 'Dark mode', 'Switch the app appearance',
            Switch(value: p.dark, onChanged: (v) => themeMode.value = v ? ThemeMode.dark : ThemeMode.light), () => themeMode.value = p.dark ? ThemeMode.light : ThemeMode.dark),
        Divider(height: 1, color: p.line),
        settingRow(Icons.notifications_rounded, kAcc, 'Notifications', 'Campus updates and deadlines',
            Switch(value: notifications, onChanged: (v) => setState(() => notifications = v)), () => setState(() => notifications = !notifications)),
        Divider(height: 1, color: p.line),
        settingRow(Icons.support_agent_rounded, const Color(0xFF06B6D4), 'Help & support', 'Contact the Helpdesk', Icon(Icons.chevron_right_rounded, color: p.sub),
                () => c.snack('Connecting you to the Helpdesk…')),
        Divider(height: 1, color: p.line),
        settingRow(Icons.logout_rounded, const Color(0xFFEF4444), 'Sign out', 'This is a demo, nothing will change', Icon(Icons.chevron_right_rounded, color: p.sub),
                () => c.snack('Signed out (demo)')),
      ]),
    );

    return SingleChildScrollView(
      primary: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const PageBanner(eyebrow: 'STUDENT PROFILE', title: 'Your academic space', sub: 'Your details and progress at a glance.', icon: Icons.person_rounded, seed: 47),
        Section(
          top: 36,
          child: wide
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 4, child: profile),
            const SizedBox(width: 24),
            Expanded(flex: 6, child: indicators),
          ])
              : Column(children: [profile, const SizedBox(height: 20), indicators]),
        ),
        Section(
          bg: p.alt,
          bottom: 48,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SecHead('SETTINGS', 'Preferences.', ''),
            settings,
          ]),
        ),
      ]),
    );
  }
}