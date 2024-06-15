import 'package:flutter/material.dart';

import 'curved_edges.dart';

class MOCurvedEdgeWidget extends StatelessWidget {
  const MOCurvedEdgeWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: MOCustomCurvedEdges(),
        child: child
    );
  }
}