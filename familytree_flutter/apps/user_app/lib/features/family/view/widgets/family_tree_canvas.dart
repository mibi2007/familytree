import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;

class FamilyTreeCanvas extends StatelessWidget {
  final List<family_proto.Member> members;

  const FamilyTreeCanvas({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();

    // Simple layout: Level is Y, Position in level is X
    final Map<int, List<family_proto.Member>> levels = {};
    for (final member in members) {
      levels.putIfAbsent(member.level, () => []).add(member);
    }

    final maxLevel = levels.keys.reduce((a, b) => a > b ? a : b);
    final maxInLevel = levels.values.map((l) => l.length).reduce((a, b) => a > b ? a : b);

    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(500),
      minScale: 0.1,
      maxScale: 2.0,
      child: Center(
        child: SizedBox(
          width: maxInLevel * 200.0,
          height: (maxLevel + 1) * 200.0,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(maxInLevel * 200.0, (maxLevel + 1) * 200.0),
                painter: TreeLinePainter(members: members, levels: levels),
              ),
              ..._buildMemberNodes(levels),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMemberNodes(Map<int, List<family_proto.Member>> levels) {
    final List<Widget> nodes = [];
    levels.forEach((level, membersInLevel) {
      for (int i = 0; i < membersInLevel.length; i++) {
        final member = membersInLevel[i];
        final x =
            (i + 1) *
            (200.0 *
                (levels.values.map((l) => l.length).reduce((a, b) => a > b ? a : b) / (membersInLevel.length + 1)));
        final y = (level + 0.5) * 150.0;

        nodes.add(
          Positioned(
            left: x - 50,
            top: y - 25,
            child: _MemberNode(member: member),
          ),
        );
      }
    });
    return nodes;
  }
}

class _MemberNode extends StatelessWidget {
  final family_proto.Member member;
  const _MemberNode({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            member.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text('Lvl ${member.level}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class TreeLinePainter extends CustomPainter {
  final List<family_proto.Member> members;
  final Map<int, List<family_proto.Member>> levels;

  TreeLinePainter({required this.members, required this.levels});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey.withValues(alpha: 0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Map<String, Offset> positions = {};

    // Calculate positions first
    levels.forEach((level, membersInLevel) {
      for (int i = 0; i < membersInLevel.length; i++) {
        final member = membersInLevel[i];
        final x = (i + 1) * (size.width / (membersInLevel.length + 1));
        final y = (level + 0.5) * 150.0;
        positions[member.id] = Offset(x, y);
      }
    });

    // Draw lines
    for (final member in members) {
      if (member.parentId.isNotEmpty && positions.containsKey(member.parentId)) {
        final parentPos = positions[member.parentId]!;
        final childPos = positions[member.id]!;

        final path = Path()
          ..moveTo(parentPos.dx, parentPos.dy + 30) // Bottom of parent node
          ..lineTo(parentPos.dx, parentPos.dy + 45)
          ..lineTo(childPos.dx, childPos.dy - 45)
          ..lineTo(childPos.dx, childPos.dy - 30); // Top of child node

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
