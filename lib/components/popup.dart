import 'package:flutter/material.dart';

class Popup extends StatefulWidget {
  final Widget child;
  final Widget follower;
  final OverlayPortalController controller;
  final Alignment followerAnchor;
  final Alignment targetAnchor;
  final Offset offset;

  const Popup({
    required this.child,
    required this.follower,
    required this.controller,
    this.offset = Offset.zero,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    super.key,
  });

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  final _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      // Link the target widget to the follower widget.
      link: _layerLink,
      child: OverlayPortal(
        controller: widget.controller,
        child: widget.child,
        overlayChildBuilder: (BuildContext context) {
          // It is needed to wrap the follower widget in a widget that fills the space of the overlay.
          // This is needed to make sure that the follower widget is positioned relative to the target widget.
          // If not wrapped, the follower widget will fill the screen and be positioned incorrectly.
          return Align(
            child: CompositedTransformFollower(
              // Link the follower widget to the target widget.
              link: _layerLink,
              // The follower widget should not be shown when the link is broken.
              showWhenUnlinked: false,
              followerAnchor: widget.followerAnchor,
              targetAnchor: widget.targetAnchor,
              offset: widget.offset,
              child: widget.follower,
            ),
          );
        },
      ),
    );
  }
}