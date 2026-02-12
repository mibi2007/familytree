import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;

class FamilyTreeCanvas extends StatefulWidget {
  final List<family_proto.Member> members;
  final Function(family_proto.Member) onNodeTap;
  final Function(family_proto.Member) onAddChild;

  const FamilyTreeCanvas({super.key, required this.members, required this.onNodeTap, required this.onAddChild});

  @override
  State<FamilyTreeCanvas> createState() => _FamilyTreeCanvasState();
}

class _FamilyTreeCanvasState extends State<FamilyTreeCanvas> {
  final Graph graph = Graph()..isTree = true;
  final BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    // Configure BuchheimWalker (Tree Layout)
    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.members.isEmpty) return const SizedBox.shrink();

    // Reset graph to avoid duplicates on rebuild (optimization needed for large trees)
    graph.nodes.clear();
    graph.edges.clear();

    final Map<String, Node> nodeMap = {};

    // 1. Create Nodes
    for (final member in widget.members) {
      final node = Node.Id(member);
      nodeMap[member.id] = node;
      graph.addNode(node);
    }

    // 2. Create Edges
    for (final member in widget.members) {
      if (member.parentId.isNotEmpty && nodeMap.containsKey(member.parentId)) {
        final parentNode = nodeMap[member.parentId]!;
        final childNode = nodeMap[member.id]!;

        // Edge direction: Parent -> Child
        graph.addEdge(parentNode, childNode);
      }
    }

    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(500),
      minScale: 0.01,
      maxScale: 5.0,
      constrained: false,
      child: GraphView(
        graph: graph,
        algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        paint: Paint()
          ..color = Colors.blueGrey
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          final member = node.key!.value as family_proto.Member;
          return _MemberNode(
            member: member,
            onTap: () => widget.onNodeTap(member),
            onAddChild: () => widget.onAddChild(member),
          );
        },
      ),
    );
  }
}

class _MemberNode extends StatelessWidget {
  final family_proto.Member member;
  final VoidCallback onTap;
  final VoidCallback onAddChild;

  const _MemberNode({required this.member, required this.onTap, required this.onAddChild});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 140, // Fixed width for uniformity
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 4))],
          border: Border.all(color: Colors.blueAccent.shade100, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade50,
              child: Text(
                member.displayName.isNotEmpty ? member.displayName[0].toUpperCase() : '?',
                style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              member.displayName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (member.spouseId.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(Icons.favorite, size: 12, color: Colors.pink.shade300),
              ),
            // We can add a mini button here or just keep the tap interaction
          ],
        ),
      ),
    );
  }
}
