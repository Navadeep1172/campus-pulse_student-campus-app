import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CampusApp());
}

// ═════════════════════════ THEME & COLOUR SYSTEM ═════════════════════════
// Primary : kPri (royal blue)   Accent : kAcc (coral)
// Field fill : Pal.fill         Success : Pal.ok (green)   Error : Pal.err (red)
// Tints   : Pal.soft (blue tint) and Pal.alt (light grey-blue section background)
// Card style: radius kRadius, subtle shadow, 1px border, rounded tinted icons.
final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

const kPri = Color(0xFF1547E0);
const kAcc = Color(0xFFFF6B4A);
const kNavy = Color(0xFF0A1A4A);
const kNavRed = Color(0xFFA51C30); // active colour of the bottom navigation bar
const double kRadius = 22;
const double kFieldRadius = 14; // one radius for every input, chip and button

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
  // Form colours: readable in both light and dark mode.
  Color get fill => dark ? const Color(0xFF1B2340) : const Color(0xFFF3F6FF);
  Color get ok => dark ? const Color(0xFF4ADE80) : const Color(0xFF15803D);
  Color get err => dark ? const Color(0xFFFF8A80) : const Color(0xFFC62828);
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
const kEmail = 'navadeep@student.campuspulse.edu';
const kEmailDomain = '@student.campuspulse.edu';
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
  Svc('Helpdesk', 'Get support', Icons.support_agent_rounded, Color(0xFF64748B), 'Email help@campuspulse.edu or visit Admin Block, Level 1 (9:00 AM – 5:00 PM). You can also send a service request from the Request tab.', 'Available'),
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

/// Banner used at the top of the Events, Campus, Request and Profile pages.
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
  static const nav = ['Home', 'Events', 'Campus', 'Request', 'Profile'];
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
              // IndexedStack keeps every page alive, so a half-filled request form survives tab switches.
              child: IndexedStack(index: tab, children: [
                HomePage(c: c),
                EventsPage(c: c),
                CampusPage(c: c),
                RequestPage(c: c),
                ProfilePage(c: c),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  // Bottom navigation bar (Home • Events • Campus • Request • Profile)
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
        BottomNavigationBarItem(icon: Icon(Icons.edit_note_outlined), activeIcon: Icon(Icons.edit_note_rounded), label: 'Request'),
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
              tooltip: p.dark ? 'Switch to light mode' : 'Switch to dark mode',
              onPressed: () => themeMode.value = p.dark ? ThemeMode.light : ThemeMode.dark,
              icon: Icon(p.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            ),
            Stack(alignment: Alignment.center, children: [
              IconButton(tooltip: 'Notifications', onPressed: () => _snack('You have 3 new notifications'), icon: const Icon(Icons.notifications_none_rounded)),
              Positioned(top: 12, right: 12, child: Container(width: 9, height: 9, decoration: BoxDecoration(color: kAcc, shape: BoxShape.circle, border: Border.all(color: p.card, width: 1.5)))),
            ]),
            GestureDetector(onTap: () => _go(4), child: const Padding(padding: EdgeInsets.only(left: 4, right: 4), child: Avatar(40))),
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
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 26), side: const BorderSide(color: Colors.white70), shape: const StadiumBorder()),
          onPressed: () => c.go(3),
          icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
          label: const Text('Request a service', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
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
      link('Request', () => c.go(3)),
      link('Profile', () => c.go(4)),
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
                  onPressed: () => c.go(3), // opens the service request form
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

// ═════════════════════════════════════════════════════════════════════════════
// PAGE 4: SERVICE REQUEST FORM  (Flutter Form project)
// ─────────────────────────────────────────────────────────────────────────────
// App & form name : Campus Pulse • "Service Request Desk"
// Colours         : primary kPri (blue), accent kAcc (coral), field fill Pal.fill,
//                   success Pal.ok (green), error Pal.err (red)
// Purpose         : students contact campus service units (advising, IT, library,
//                   finance, facilities, counselling).
// Advanced choices (3 required, 6 delivered):
//   1. Conditional extra field that appears for the chosen service category
//   2. Live character counters with maximum lengths (subject + description)
//   3. Reusable CampusTextField / CampusDropdown / ChipGroupField widgets
//   4. Progress indicator showing completion of the required fields
//   5. Submission summary dialog with a request reference + recent requests list
//   6. Mock attachment selector that shows the chosen file name
//   (the app-wide light/dark switch is also kept readable on every field state)
// ═════════════════════════════════════════════════════════════════════════════

// ───────────── Sample choices ─────────────
class ServiceCat {
  final String name;
  final IconData icon;
  final String extraLabel, extraHint; // empty = no extra field for this category
  const ServiceCat(this.name, this.icon, this.extraLabel, this.extraHint);
}

const serviceCats = <ServiceCat>[
  ServiceCat('Academic Advising', Icons.school_rounded, 'Course code', 'e.g. CS2014'),
  ServiceCat('IT Helpdesk', Icons.computer_rounded, 'System or device affected', 'e.g. Wi-Fi, student portal, Lab 3 PC'),
  ServiceCat('Library Services', Icons.local_library_rounded, 'Book title or study room', 'e.g. Group Study Room 4'),
  ServiceCat('Fees & Finance', Icons.account_balance_wallet_rounded, 'Invoice or receipt number', 'e.g. INV-2026-0412'),
  ServiceCat('Facilities & Maintenance', Icons.build_circle_rounded, 'Room or location', 'e.g. Block A, Level 2, Room 5'),
  ServiceCat('Counselling & Wellbeing', Icons.favorite_rounded, '', ''),
];

class ChipOpt {
  final String label;
  final IconData icon;
  final Color color;
  const ChipOpt(this.label, this.icon, this.color);
}

const urgencyOpts = <ChipOpt>[
  ChipOpt('Low • within 7 days', Icons.flag_outlined, Color(0xFF16A34A)),
  ChipOpt('Medium • within 3 days', Icons.flag_rounded, Color(0xFFD97706)),
  ChipOpt('High • within 24 hours', Icons.priority_high_rounded, Color(0xFFEA580C)),
  ChipOpt('Urgent • today', Icons.warning_amber_rounded, Color(0xFFDC2626)),
];

const contactOpts = <ChipOpt>[
  ChipOpt('Campus email', Icons.mail_outline_rounded, kPri),
  ChipOpt('Phone call', Icons.call_outlined, kPri),
  ChipOpt('Text message', Icons.sms_outlined, kPri),
  ChipOpt('Visit in person', Icons.place_outlined, kPri),
];

const sampleFiles = <String>['wifi_error_screenshot.png', 'fee_receipt_oct.pdf', 'timetable_clash.jpg', 'medical_certificate.pdf'];

// ───────────── Validators (one per field, specific & helpful messages) ─────────────
// Each validator returns null when the value is valid, otherwise the message shown
// beside the field. They are plain functions so the progress bar can reuse them.
String? vName(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Please enter your name as it appears on your student card.';
  if (t.length < 3) return 'Your name looks too short. Use at least 3 characters.';
  if (!RegExp(r"^[A-Za-z][A-Za-z .'\-]*$").hasMatch(t)) return 'Use letters only (spaces, . \' and - are fine).';
  return null;
}

String? vStudentId(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Please enter your student ID.';
  if (!RegExp(r'^STU\d{4}-\d{4}$').hasMatch(t)) return 'Use the format STU2024-1082 (STU + year, a dash, then 4 digits).';
  return null;
}

String? vEmail(String? v) {
  final t = (v ?? '').trim().toLowerCase();
  if (t.isEmpty) return 'Please enter your campus email.';
  if (!RegExp(r'^[a-z0-9._+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$').hasMatch(t)) return 'That email looks incomplete. Example: name$kEmailDomain';
  if (!t.endsWith(kEmailDomain)) return 'Please use your campus email ending in $kEmailDomain';
  return null;
}

String? vPhone(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return null; // optional field
  final digits = t.replaceAll(RegExp(r'[\s\-]'), '');
  if (!RegExp(r'^\+?\d{9,13}$').hasMatch(digits)) return 'Use 9 to 13 digits with an optional leading +. Example: +60 12-345 6789';
  return null;
}

String? vCategory(String? v) => v == null ? 'Please choose the campus service you need.' : null;

String? vSubject(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Add a short subject so staff know what this is about.';
  if (t.length < 8) return 'Please be a little more specific (at least 8 characters).';
  return null;
}

String? vDescription(String? v) {
  final t = (v ?? '').trim();
  if (t.isEmpty) return 'Please describe your request.';
  if (t.length < 20) return 'Add more detail: at least 20 characters (${t.length} so far).';
  if (t.length > 300) return 'Please keep the description under 300 characters.';
  return null;
}

String? vUrgency(String? v) => v == null ? 'Please choose how urgent this request is.' : null;
String? vContact(String? v) => v == null ? 'Please choose how we should reach you.' : null;

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

String? vDate(DateTime? v) {
  if (v == null) return 'Please pick a preferred appointment or reply date.';
  if (_dateOnly(v).isBefore(_dateOnly(DateTime.now()))) return 'That date has already passed. Choose today or a later date.';
  if (v.weekday > 5) return 'Campus offices are closed at weekends. Pick Monday to Friday.';
  return null;
}

String? vDeclaration(bool? v) => v == true ? null : 'You must tick the declaration before submitting.';

String fmtDate(DateTime d) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
}

// ───────────── Reusable input styling & widgets ─────────────
/// One decoration for every field: floating label always visible, fill colour,
/// rounded borders, blue focus ring, red error border + readable error text.
InputDecoration campusDecoration(Pal p, {required String label, String? hint, String? helper, IconData? icon, Widget? counter}) {
  OutlineInputBorder border(Color c, [double w = 1]) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(kFieldRadius), borderSide: BorderSide(color: c, width: w));
  return InputDecoration(
    labelText: label,
    hintText: hint,
    helperText: helper,
    helperMaxLines: 2,
    counter: counter,
    filled: true,
    fillColor: p.fill,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelStyle: TextStyle(color: p.sub, fontWeight: FontWeight.w600, fontSize: 15),
    floatingLabelStyle: TextStyle(color: p.main, fontWeight: FontWeight.w700, fontSize: 15),
    hintStyle: TextStyle(color: p.sub.withOpacity(.75), fontSize: 15),
    helperStyle: TextStyle(color: p.sub, fontSize: 12.5),
    errorStyle: TextStyle(color: p.err, fontWeight: FontWeight.w600, fontSize: 12.5, height: 1.3),
    errorMaxLines: 3,
    prefixIcon: icon == null ? null : Icon(icon, color: p.sub),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: border(p.line),
    enabledBorder: border(p.line),
    focusedBorder: border(p.main, 2),
    errorBorder: border(p.err, 1.5),
    focusedErrorBorder: border(p.err, 2),
  );
}

/// Reusable text field (constructor parameters control label, hint, icon, keyboard,
/// validation, saving, length limit + live counter).
class CampusTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint, helper;
  final IconData icon;
  final String? Function(String?) validator;
  final FormFieldSetter<String> onSaved;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization capitalization;
  final List<TextInputFormatter> formatters;
  final int minLines, maxLines;
  final int? maxChars; // when set: enforces the limit and shows a live counter
  final bool autocorrect;

  const CampusTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    required this.onSaved,
    this.hint,
    this.helper,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.capitalization = TextCapitalization.none,
    this.formatters = const [],
    this.minLines = 1,
    this.maxLines = 1,
    this.maxChars,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: capitalization,
        autocorrect: autocorrect,
        minLines: minLines,
        maxLines: maxLines,
        style: TextStyle(fontSize: 16, color: p.text),
        inputFormatters: [
          ...formatters,
          if (maxChars != null) LengthLimitingTextInputFormatter(maxChars),
        ],
        decoration: campusDecoration(
          p,
          label: label,
          hint: hint,
          helper: helper,
          icon: icon,
          // Live character counter (advanced option): rebuilds on every keystroke.
          counter: maxChars == null
              ? null
              : ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, v, __) => Text('${v.text.length} / $maxChars',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: v.text.length >= maxChars! ? p.err : p.sub)),
          ),
        ),
      ),
    );
  }
}

/// Reusable dropdown for any item type.
class CampusDropdown<T> extends StatelessWidget {
  final String label, hint;
  final IconData icon;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final IconData Function(T)? itemIcon;
  final String? Function(T?) validator;
  final ValueChanged<T?> onChanged;
  final FormFieldSetter<T> onSaved;

  const CampusDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.validator,
    required this.onChanged,
    required this.onSaved,
    this.itemIcon,
  });

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        dropdownColor: p.card,
        borderRadius: BorderRadius.circular(kFieldRadius),
        style: TextStyle(fontSize: 16, color: p.text),
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: p.sub),
        decoration: campusDecoration(p, label: label, hint: hint, icon: icon),
        // Menu rows show an icon + text; the closed field shows text only.
        items: [
          for (final i in items)
            DropdownMenuItem<T>(
              value: i,
              child: Row(children: [
                if (itemIcon != null) ...[Icon(itemIcon!(i), size: 20, color: p.main), const SizedBox(width: 12)],
                Expanded(child: Text(itemLabel(i), overflow: TextOverflow.ellipsis)),
              ]),
            ),
        ],
        selectedItemBuilder: (_) => [
          for (final i in items) Align(alignment: Alignment.centerLeft, child: Text(itemLabel(i), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

/// Reusable single-choice chip group that is a real FormField (so validate, save and
/// reset all work on it). Selected chips show a tick + thicker border, not colour alone.
class ChipGroupField extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<ChipOpt> options;
  final String? Function(String?) validator;
  final ValueChanged<String?> onChanged;
  final FormFieldSetter<String> onSaved;

  const ChipGroupField({
    super.key,
    required this.label,
    required this.icon,
    required this.options,
    required this.validator,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return FormField<String>(
      validator: validator,
      onSaved: onSaved,
      builder: (state) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, size: 20, color: p.sub),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: p.text))),
          ]),
          const SizedBox(height: 10),
          Wrap(spacing: 10, runSpacing: 10, children: [
            for (final o in options)
              ChoiceChip(
                avatar: Icon(o.icon, size: 18, color: p.text),
                label: Text(o.label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: p.text)),
                selected: state.value == o.label,
                showCheckmark: true,
                checkmarkColor: p.text,
                selectedColor: o.color.withOpacity(.2),
                backgroundColor: p.fill,
                side: BorderSide(color: state.value == o.label ? o.color : (state.hasError ? p.err : p.line), width: state.value == o.label ? 2 : 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius)),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11), // ≥ 44px touch target
                onSelected: (_) {
                  state.didChange(o.label);
                  onChanged(o.label);
                },
              ),
          ]),
          if (state.hasError) _FieldError(state.errorText!),
        ]),
      ),
    );
  }
}

/// Error line with an icon, so errors never rely on colour alone.
class _FieldError extends StatelessWidget {
  final String text;
  const _FieldError(this.text);
  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.error_outline_rounded, size: 17, color: p.err),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: TextStyle(color: p.err, fontWeight: FontWeight.w600, fontSize: 12.5, height: 1.3))),
      ]),
    );
  }
}

/// Numbered card that groups related fields under a heading.
class FormCard extends StatelessWidget {
  final int step;
  final String title, sub;
  final IconData icon;
  final List<Widget> children;
  const FormCard({super.key, required this.step, required this.title, required this.sub, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: cardBox(p, r: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: p.main),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Step $step • $title', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: p.text)),
              const SizedBox(height: 2),
              Text(sub, style: TextStyle(color: p.sub, fontSize: 13.5)),
            ]),
          ),
        ]),
        Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1, color: p.line)),
        ...children,
      ]),
    );
  }
}

// ───────────── Data holders ─────────────
/// Values written by each field's onSaved callback (only after validate() passes).
class RequestDraft {
  String name = '', studentId = '', email = '', phone = '', subject = '', description = '', extra = '';
  String? category, urgency, contact, attachment;
  DateTime? date;
}

class SentRequest {
  final String ref, category, subject, urgency;
  final DateTime date;
  const SentRequest(this.ref, this.category, this.subject, this.urgency, this.date);
}

// ───────────── The page ─────────────
class RequestPage extends StatefulWidget {
  final Ctl c;
  const RequestPage({super.key, required this.c});
  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  // STATE: the key that identifies the Form and gives access to validate / save / reset.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text controllers (disposed in dispose()).
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _idCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _extraCtl = TextEditingController();
  final TextEditingController _subjectCtl = TextEditingController();
  final TextEditingController _descCtl = TextEditingController();

  // STATE: values that live outside the text controllers. Reset must clear these too.
  String? _category, _urgency, _contact, _attachment;
  DateTime? _date;
  bool _agree = false;

  final RequestDraft _draft = RequestDraft();
  final List<SentRequest> _sent = [];

  late final List<TextEditingController> _all = [_nameCtl, _idCtl, _emailCtl, _phoneCtl, _extraCtl, _subjectCtl, _descCtl];

  @override
  void initState() {
    super.initState();
    // Rebuild whenever any text changes so the progress bar stays live.
    for (final t in _all) {
      t.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    // Dispose every controller to avoid memory leaks.
    for (final t in _all) {
      t.removeListener(_refresh);
      t.dispose();
    }
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  ServiceCat? get _cat {
    for (final s in serviceCats) {
      if (s.name == _category) return s;
    }
    return null;
  }

  bool get _hasExtra => _cat != null && _cat!.extraLabel.isNotEmpty;

  String? _vExtra(String? v) {
    if ((v ?? '').trim().length < 3) return 'Please add the ${_cat?.extraLabel.toLowerCase() ?? 'detail'} (at least 3 characters).';
    return null;
  }

  // PROGRESS: counts how many required items currently pass their validator.
  List<bool> _checks() => [
    vName(_nameCtl.text) == null,
    vStudentId(_idCtl.text) == null,
    vEmail(_emailCtl.text) == null,
    _category != null,
    if (_hasExtra) _vExtra(_extraCtl.text) == null,
    vSubject(_subjectCtl.text) == null,
    vDescription(_descCtl.text) == null,
    _urgency != null,
    _contact != null,
    vDate(_date) == null,
    _agree,
  ];

  // Fills the student details from the profile (sample data) to save typing.
  void _useProfile() {
    setState(() {
      _nameCtl.text = kName;
      _idCtl.text = kId;
      _emailCtl.text = kEmail;
    });
    widget.c.snack('Student details filled from your profile');
  }

  // SUBMIT: validate first, save only if everything passes, then show feedback.
  void _submit() {
    final form = _formKey.currentState;
    if (form == null) return;
    FocusScope.of(context).unfocus();

    if (!form.validate()) {
      // Failed validation: stay on the form, keep every valid value, show errors beside fields.
      widget.c.snack('Please fix the highlighted fields before submitting.');
      return;
    }
    form.save(); // runs every onSaved callback and fills _draft

    final d = _draft;
    final now = DateTime.now();
    final ref = 'REQ-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${1000 + math.Random().nextInt(9000)}';
    final sent = SentRequest(ref, d.category ?? '', d.subject, d.urgency ?? '', d.date ?? now);
    setState(() => _sent.insert(0, sent));
    _showSuccess(ref, d);
  }

  // RESET: reset the Form AND every piece of state that is not owned by the Form.
  void _resetAll({bool silent = false}) {
    _formKey.currentState?.reset(); // resets all FormFields (dropdown, chips, date, checkbox, text)
    for (final t in _all) {
      t.clear();
    }
    setState(() {
      _category = _urgency = _contact = _attachment = null;
      _date = null;
      _agree = false;
      _draft
        ..name = ''
        ..studentId = ''
        ..email = ''
        ..phone = ''
        ..subject = ''
        ..description = ''
        ..extra = ''
        ..category = null
        ..urgency = null
        ..contact = null
        ..attachment = null
        ..date = null;
    });
    if (!silent) widget.c.snack('Form cleared. You can start a new request.');
  }

  // Success feedback: dialog with a reference number and a summary of the request.
  void _showSuccess(String ref, RequestDraft d) {
    final first = d.name.trim().split(RegExp(r'\s+')).first;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        final p = Pal.of(ctx);
        Widget row(String k, String v) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 100, child: Text(k, style: TextStyle(color: p.sub, fontWeight: FontWeight.w600, fontSize: 13.5))),
            Expanded(child: Text(v, style: TextStyle(color: p.text, fontWeight: FontWeight.w700, fontSize: 14))),
          ]),
        );
        return AlertDialog(
          backgroundColor: p.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          title: Column(children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: p.ok.withOpacity(.15), shape: BoxShape.circle),
              child: Icon(Icons.check_circle_rounded, color: p.ok, size: 40),
            ),
            const SizedBox(height: 14),
            Text('Thanks, $first. Your request is on its way!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: p.text)),
          ]),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(kFieldRadius)),
                  child: Column(children: [
                    Text('REQUEST REFERENCE', style: TextStyle(color: p.sub, fontSize: 11.5, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
                    const SizedBox(height: 4),
                    SelectableText(ref, style: TextStyle(color: p.main, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: .5)),
                  ]),
                ),
                const SizedBox(height: 14),
                row('Service', d.category ?? ''),
                row('Subject', d.subject),
                if (d.extra.isNotEmpty && _cat != null) row(_cat!.extraLabel, d.extra),
                row('Urgency', d.urgency ?? ''),
                row('Contact via', d.contact ?? ''),
                row('Preferred date', d.date == null ? '' : fmtDate(d.date!)),
                row('Student', '${d.name} (${d.studentId})'),
                row('Email', d.email),
                if (d.phone.isNotEmpty) row('Phone', d.phone),
                if (d.attachment != null) row('Attachment', d.attachment!),
                const SizedBox(height: 12),
                Text('A confirmation was sent to your campus email. Staff usually reply within one working day.', style: TextStyle(color: p.sub, height: 1.45, fontSize: 13.5)),
              ]),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: kPri, foregroundColor: Colors.white, minimumSize: const Size(200, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius))),
              onPressed: () => Navigator.of(ctx).pop(),
              icon: const Icon(Icons.done_all_rounded),
              label: const Text('Done', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
            ),
          ],
        );
      },
    ).then((_) {
      // After the dialog closes, start a clean form for the next request.
      if (mounted) _resetAll(silent: true);
    });
  }

  // Mock attachment picker: no real files, just a list of sample file names.
  void _pickAttachment() {
    final p = Pal.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(color: p.card, borderRadius: const BorderRadius.vertical(top: Radius.circular(28))),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 44, height: 5, decoration: BoxDecoration(color: p.line, borderRadius: BorderRadius.circular(3)))),
          const SizedBox(height: 18),
          Text('Choose a sample file', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: p.text)),
          const SizedBox(height: 6),
          Text('This is a demo picker. No file is uploaded.', style: TextStyle(color: p.sub, fontSize: 13.5)),
          const SizedBox(height: 10),
          for (final f in sampleFiles)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(f.endsWith('.pdf') ? Icons.picture_as_pdf_rounded : Icons.image_rounded, color: p.main),
              title: Text(f, style: TextStyle(fontWeight: FontWeight.w700, color: p.text)),
              onTap: () {
                setState(() => _attachment = f);
                Navigator.pop(ctx);
              },
            ),
        ]),
      ),
    );
  }

  // Date picker rendered as a validated FormField (weekdays only, never in the past).
  Widget _dateField() => FormField<DateTime>(
    validator: vDate,
    onSaved: (v) => _draft.date = v,
    builder: (state) {
      final p = Pal.of(context);
      final today = _dateOnly(DateTime.now());
      DateTime nextWeekday(DateTime d) {
        var x = d;
        while (x.weekday > 5) {
          x = x.add(const Duration(days: 1));
        }
        return x;
      }

      Future<void> pick() async {
        var initial = state.value ?? nextWeekday(today);
        if (initial.isBefore(today)) initial = nextWeekday(today);
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: today,
          lastDate: today.add(const Duration(days: 90)),
          selectableDayPredicate: (d) => d.weekday <= 5,
          helpText: 'Choose your preferred date',
        );
        if (picked != null) {
          state.didChange(picked);
          setState(() => _date = picked);
        }
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: InkWell(
          borderRadius: BorderRadius.circular(kFieldRadius),
          onTap: pick,
          child: InputDecorator(
            isEmpty: state.value == null,
            decoration: campusDecoration(p, label: 'Preferred date *', icon: Icons.event_available_rounded, helper: 'Appointments and replies are Monday to Friday.')
                .copyWith(errorText: state.errorText, suffixIcon: Icon(Icons.arrow_drop_down_rounded, color: p.sub)),
            child: Text(
              state.value == null ? 'Tap to choose a date' : fmtDate(state.value!),
              style: TextStyle(fontSize: 16, color: state.value == null ? p.sub : p.text),
            ),
          ),
        ),
      );
    },
  );

  // Declaration checkbox as a FormField: submission is blocked until it is ticked.
  Widget _declarationField() => FormField<bool>(
    initialValue: false,
    validator: vDeclaration,
    builder: (state) {
      final p = Pal.of(context);
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(
            color: p.fill,
            borderRadius: BorderRadius.circular(kFieldRadius),
            border: Border.all(color: state.hasError ? p.err : p.line, width: state.hasError ? 1.5 : 1),
          ),
          child: CheckboxListTile(
            value: state.value ?? false,
            activeColor: kPri,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius)),
            title: Text(
              'I confirm the information above is correct and I agree that Campus Pulse staff may contact me about this request. *',
              style: TextStyle(fontSize: 14.5, height: 1.4, color: p.text, fontWeight: FontWeight.w600),
            ),
            onChanged: (v) {
              state.didChange(v);
              setState(() => _agree = v ?? false);
            },
          ),
        ),
        if (state.hasError) _FieldError(state.errorText!),
      ]);
    },
  );

  Widget _pair(Widget a, Widget b) => LayoutBuilder(builder: (context, box) {
    if (box.maxWidth > 520) {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: a), const SizedBox(width: 14), Expanded(child: b)]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [a, b]);
  });

  @override
  Widget build(BuildContext context) {
    final p = Pal.of(context);
    final checks = _checks();
    final done = checks.where((x) => x).length;
    final total = checks.length;
    final ready = done == total;

    // Progress indicator card
    final progress = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(20), border: Border.all(color: p.line)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(ready ? Icons.check_circle_rounded : Icons.pending_actions_rounded, color: ready ? p.ok : p.main),
          const SizedBox(width: 10),
          Expanded(
            child: Text(ready ? 'All required items are complete. Ready to submit!' : '$done of $total required items complete',
                style: TextStyle(color: p.text, fontWeight: FontWeight.w800, fontSize: 15)),
          ),
        ]),
        const SizedBox(height: 12),
        Semantics(
          label: 'Form progress',
          value: '$done of $total required items complete',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: done / total, minHeight: 10, color: ready ? p.ok : kPri, backgroundColor: p.line),
          ),
        ),
        const SizedBox(height: 10),
        Text('Fields marked * are required. The phone number is optional.', style: TextStyle(color: p.sub, fontSize: 13)),
      ]),
    );

    // The Form: one key, autovalidate after user interaction, scrollable parent.
    final form = Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // ── Step 1: student details
        FormCard(
          step: 1,
          title: 'Student details',
          sub: 'Who is making this request?',
          icon: Icons.badge_rounded,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(minimumSize: const Size(48, 44), foregroundColor: p.main),
                onPressed: _useProfile,
                icon: const Icon(Icons.auto_fix_high_rounded, size: 19),
                label: const Text('Use my profile details', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 6),
            _pair(
              CampusTextField(
                controller: _nameCtl,
                label: 'Full name *',
                hint: 'e.g. Navadeep',
                icon: Icons.person_outline_rounded,
                capitalization: TextCapitalization.words,
                validator: vName,
                onSaved: (v) => _draft.name = (v ?? '').trim(),
              ),
              CampusTextField(
                controller: _idCtl,
                label: 'Student ID *',
                hint: 'STU2024-1082',
                icon: Icons.badge_outlined,
                capitalization: TextCapitalization.characters,
                autocorrect: false,
                formatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-]')), LengthLimitingTextInputFormatter(12)],
                validator: vStudentId,
                onSaved: (v) => _draft.studentId = (v ?? '').trim().toUpperCase(),
              ),
            ),
            CampusTextField(
              controller: _emailCtl,
              label: 'Campus email *',
              hint: 'name$kEmailDomain',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: vEmail,
              onSaved: (v) => _draft.email = (v ?? '').trim().toLowerCase(),
            ),
            CampusTextField(
              controller: _phoneCtl,
              label: 'Phone number (optional)',
              hint: '+60 12-345 6789',
              helper: 'Only used if you choose a phone call or text message.',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              formatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\- ]')), LengthLimitingTextInputFormatter(18)],
              validator: vPhone,
              onSaved: (v) => _draft.phone = (v ?? '').trim(),
            ),
          ],
        ),

        // ── Step 2: request details
        FormCard(
          step: 2,
          title: 'Request details',
          sub: 'What do you need help with?',
          icon: Icons.support_agent_rounded,
          children: [
            CampusDropdown<String>(
              label: 'Service category *',
              hint: 'Choose a campus service',
              icon: Icons.category_rounded,
              value: _category,
              items: [for (final s in serviceCats) s.name],
              itemLabel: (s) => s,
              itemIcon: (s) => serviceCats.firstWhere((x) => x.name == s).icon,
              validator: vCategory,
              onChanged: (v) => setState(() {
                _category = v;
                _extraCtl.clear(); // a different category needs a different extra detail
              }),
              onSaved: (v) => _draft.category = v,
            ),
            // ADVANCED 1: extra field appears only for categories that need it.
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: _hasExtra
                  ? CampusTextField(
                controller: _extraCtl,
                label: '${_cat!.extraLabel} *',
                hint: _cat!.extraHint,
                icon: _cat!.icon,
                validator: _vExtra,
                onSaved: (v) => _draft.extra = (v ?? '').trim(),
              )
                  : (_cat != null
                  ? Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: p.soft, borderRadius: BorderRadius.circular(kFieldRadius), border: Border.all(color: p.line)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(Icons.lock_outline_rounded, color: p.main, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Counselling requests are private. Only the wellbeing team can read them.', style: TextStyle(color: p.text, fontSize: 13.5, height: 1.4))),
                ]),
              )
                  : const SizedBox(width: double.infinity)),
            ),
            CampusTextField(
              controller: _subjectCtl,
              label: 'Request subject *',
              hint: 'e.g. Cannot log in to the student portal',
              icon: Icons.title_rounded,
              capitalization: TextCapitalization.sentences,
              maxChars: 80,
              validator: vSubject,
              onSaved: (v) => _draft.subject = (v ?? '').trim(),
            ),
            // ADVANCED 2: multiline description with live counter and a 300 character limit.
            CampusTextField(
              controller: _descCtl,
              label: 'Request details *',
              hint: 'Tell us what happened, where, and what you have already tried.',
              helper: 'Between 20 and 300 characters.',
              icon: Icons.notes_rounded,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              capitalization: TextCapitalization.sentences,
              minLines: 4,
              maxLines: 6,
              maxChars: 300,
              validator: vDescription,
              onSaved: (v) => _draft.description = (v ?? '').trim(),
            ),
            ChipGroupField(
              label: 'Urgency *',
              icon: Icons.speed_rounded,
              options: urgencyOpts,
              validator: vUrgency,
              onChanged: (v) => setState(() => _urgency = v),
              onSaved: (v) => _draft.urgency = v,
            ),
            // ADVANCED 6: mock attachment selector that shows the chosen file name.
            Align(
              alignment: Alignment.centerLeft,
              child: _attachment == null
                  ? OutlinedButton.icon(
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48), side: BorderSide(color: p.line), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius))),
                onPressed: _pickAttachment,
                icon: Icon(Icons.attach_file_rounded, color: p.text, size: 20),
                label: Text('Attach a file (optional)', style: TextStyle(color: p.text, fontWeight: FontWeight.w700)),
              )
                  : InputChip(
                avatar: Icon(Icons.description_rounded, color: p.main, size: 18),
                label: Text(_attachment!, style: TextStyle(color: p.text, fontWeight: FontWeight.w700)),
                deleteIcon: const Icon(Icons.close_rounded, size: 18),
                deleteButtonTooltipMessage: 'Remove attachment',
                backgroundColor: p.soft,
                side: BorderSide(color: p.line),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                onDeleted: () => setState(() => _attachment = null),
              ),
            ),
          ],
        ),

        // ── Step 3: preferences
        FormCard(
          step: 3,
          title: 'Preferences',
          sub: 'How and when should we respond?',
          icon: Icons.tune_rounded,
          children: [
            ChipGroupField(
              label: 'Preferred contact method *',
              icon: Icons.forum_outlined,
              options: contactOpts,
              validator: vContact,
              onChanged: (v) => setState(() => _contact = v),
              onSaved: (v) => _draft.contact = v,
            ),
            _dateField(),
          ],
        ),

        // ── Step 4: confirmation + actions
        FormCard(
          step: 4,
          title: 'Confirm & send',
          sub: 'Review your answers, then submit.',
          icon: Icons.verified_user_rounded,
          children: [
            _declarationField(),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                flex: 3,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: kPri,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius)),
                  ),
                  onPressed: _submit,
                  icon: const Icon(Icons.send_rounded, size: 20),
                  label: const Text('Submit request', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: p.err,
                    minimumSize: const Size.fromHeight(54),
                    side: BorderSide(color: p.err.withOpacity(.7), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFieldRadius)),
                  ),
                  onPressed: _resetAll,
                  icon: const Icon(Icons.restart_alt_rounded, size: 20),
                  label: const Text('Reset', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15.5)),
                ),
              ),
            ]),
          ],
        ),
      ]),
    );

    // ADVANCED 5: the recent requests list shows what has been submitted this session.
    Widget recent() => Container(
      padding: const EdgeInsets.all(20),
      decoration: cardBox(p, r: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.history_rounded, color: p.main),
          const SizedBox(width: 10),
          Text('Your recent requests', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: p.text)),
        ]),
        const SizedBox(height: 12),
        for (final r in _sent)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: p.ok.withOpacity(.14), borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.mark_email_read_rounded, color: p.ok, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.subject, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: p.text)),
                  const SizedBox(height: 2),
                  Text('${r.ref} • ${r.category} • ${fmtDate(r.date)}', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: p.sub, fontSize: 12.5)),
                ]),
              ),
              const SizedBox(width: 8),
              Pill(r.urgency.split(' ').first.toUpperCase(), p.main),
            ]),
          ),
      ]),
    );

    return SingleChildScrollView(
      primary: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      // Extra bottom padding keeps the last fields visible above the on-screen keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const PageBanner(
          eyebrow: 'SERVICE REQUEST DESK',
          title: 'Ask campus services',
          sub: 'Fill in the four short steps and we will reply within one working day.',
          icon: Icons.edit_note_rounded,
          seed: 58,
        ),
        Section(
          top: 36,
          bottom: 48,
          bg: p.alt,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                progress,
                const SizedBox(height: 20),
                form,
                if (_sent.isNotEmpty) recent(),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}

// ═════════════════════════ PAGE 5: PROFILE ═════════════════════════
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
              info(Icons.mail_outline_rounded, kEmail),
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
        settingRow(Icons.support_agent_rounded, const Color(0xFF06B6D4), 'Help & support', 'Send a service request', Icon(Icons.chevron_right_rounded, color: p.sub),
                () => c.go(3)), // opens the service request form
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