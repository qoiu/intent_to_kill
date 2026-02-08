import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/visible_clicker.dart';
import 'package:intent_to_kill/utils/update_inherit.dart';
import 'package:qoiu_utils/components/widget_wrapper.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class PopupMenu extends StatefulWidget {
  final Widget child;
  final Widget follower;
  final OverlayPortalController controller;
  final Alignment? followerAnchor;
  final Alignment? targetAnchor;
  final Offset offset;
  final UpdateController? closeController;
  final VoidCallback? onClose;
  final VoidCallback? onOpen;
  final bool fromLeft;

  const PopupMenu({
    required this.child,
    required this.follower,
    required this.controller,
    this.closeController,
    this.onClose,
    this.onOpen,
    this.fromLeft = false,
    this.offset = Offset.zero,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    super.key,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu>
    with SingleTickerProviderStateMixin, UpdaterMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    widget.closeController?.let((e) => updateController = e);
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // duration: const Duration(milliseconds: 180),
      // reverseDuration: const Duration(milliseconds: 140),
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 240),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    );
  }

  Future<void> _hideWithAnimation() async {
    if (!widget.controller.isShowing) return;
    await _controller.reverse();
    widget.controller.hide();
    widget.onClose?.let((e) => e());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _layerLink = LayerLink();
  final _followerKey = GlobalKey();

  Offset _correctedOffset = Offset.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recalculateOffset();
    });
  }

  void _recalculateOffset() {
    final screenSize = MediaQuery.of(context).size;

    final targetBox = context.findRenderObject() as RenderBox?;
    final followerBox =
        _followerKey.currentContext?.findRenderObject() as RenderBox?;

    if (targetBox == null || followerBox == null) return;

    final targetPos = targetBox.localToGlobal(Offset.zero);
    final targetSize = targetBox.size;
    final followerSize = followerBox.size;

    // Базовая позиция (как будто offset = widget.offset)
    double dx = targetPos.dx + widget.offset.dx;
    double dy = targetPos.dy + targetSize.height + widget.offset.dy;

    // Clamp по экрану
    dx = dx.clamp(0.0, screenSize.width - followerSize.width - 20);
    dy = dy.clamp(0.0, screenSize.height - followerSize.height);

    setState(() {
      _correctedOffset = Offset(
        dx - targetPos.dx,
        dy - targetPos.dy - targetSize.height,
      );
    });

    ['x2', dx, 'y2', dy].print();
  }

  Rect _getTargetRect() {
    final box = context.findRenderObject() as RenderBox;
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft & box.size;
  }

  @override
  onUpdate() {
    _hideWithAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: widget.controller,
        overlayLocation: OverlayChildLocation.rootOverlay,
        child: VisibleClicker(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            if (widget.controller.isShowing) {
              _hideWithAnimation();
            } else {
              widget.controller.show();
              widget.onOpen?.let((e) => e());
            }
            ['tap'.dpRed(), widget.controller.isShowing].print();
          },
          child: widget.child,
        ),
        overlayChildBuilder: (context) {
          _controller.forward(from: 0);
          final targetRect = _getTargetRect();
          final padding = MediaQuery.of(context).padding;

          return Stack(
            clipBehavior: Clip.none,
            alignment: widget.targetAnchor ?? AlignmentDirectional.topStart,
            children: [
              // tap outside
              if (widget.closeController == null) ...{
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _hideWithAnimation,
                  ),
                ),
              },
              CustomSingleChildLayout(
                delegate: _PopupLayoutDelegate(
                  targetRect: targetRect,
                  screenPadding: padding,
                ),
                child: ClipRect(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return WidgetWrapper(
                        condition: widget.fromLeft,
                        wrap: (child) => Transform.translate(
                            offset: Offset((_animation.value * 100) - 100, 0),
                            child: child),
                        child: Transform.scale(
                          alignment: Alignment.topCenter,
                          scaleY: _animation.value,
                          scaleX: _animation.value,
                          child: child,
                        ),
                      );
                    },
                    child: widget.follower,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PopupLayoutDelegate extends SingleChildLayoutDelegate {
  final Rect targetRect;
  final EdgeInsets screenPadding;

  _PopupLayoutDelegate({
    required this.targetRect,
    this.screenPadding = EdgeInsets.zero,
  });

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double dx = targetRect.left;
    double dy = targetRect.bottom;

    // Clamp по X
    dx = dx.clamp(
      screenPadding.left,
      size.width - childSize.width - screenPadding.right - 20,
    );

    // Clamp по Y
    dy = dy.clamp(
      screenPadding.top,
      size.height - childSize.height - screenPadding.bottom,
    );

    ['x', dx, 'y', dy].print();
    return Offset(dx, dy + 5);
  }

  @override
  bool shouldRelayout(covariant _PopupLayoutDelegate oldDelegate) {
    return targetRect != oldDelegate.targetRect ||
        screenPadding != oldDelegate.screenPadding;
  }
}

class _PopupLayoutDelegate2 extends SingleChildLayoutDelegate {
  final Rect targetRect;
  final EdgeInsets screenPadding;
  final Alignment targetAnchor;
  final Alignment followerAnchor;

  _PopupLayoutDelegate2({
    required this.targetRect,
    required this.targetAnchor,
    required this.followerAnchor,
    this.screenPadding = EdgeInsets.zero,
  });

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // --- Target anchor point in global overlay coords ---
    final targetPoint = Offset(
      targetRect.left + (targetAnchor.x + 1) / 2 * targetRect.width,
      targetRect.top + (targetAnchor.y + 1) / 2 * targetRect.height,
    );

    // --- Follower anchor offset inside popup ---
    final followerOffset = Offset(
      (followerAnchor.x + 1) / 2 * childSize.width,
      (followerAnchor.y + 1) / 2 * childSize.height,
    );

    double dx = targetPoint.dx - followerOffset.dx;
    double dy = targetPoint.dy - followerOffset.dy;

    // Clamp X
    dx = dx.clamp(
      screenPadding.left,
      size.width - childSize.width - screenPadding.right - 20,
    );

    // Clamp Y
    dy = dy.clamp(
      screenPadding.top,
      size.height - childSize.height - screenPadding.bottom,
    );

    ['anchor dx', dx, 'dy', dy].print();

    return Offset(dx, dy);
  }

  @override
  bool shouldRelayout(covariant _PopupLayoutDelegate2 oldDelegate) {
    return targetRect != oldDelegate.targetRect ||
        screenPadding != oldDelegate.screenPadding ||
        targetAnchor != oldDelegate.targetAnchor ||
        followerAnchor != oldDelegate.followerAnchor;
  }
}
