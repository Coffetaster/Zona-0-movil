import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:zona0_apk/config/constants/hero_tags.dart';
import 'package:zona0_apk/config/extensions/custom_context.dart';
import 'package:zona0_apk/domain/entities/entities.dart';
import 'package:zona0_apk/main.dart';
import 'package:zona0_apk/presentation/providers/providers.dart';
import 'package:zona0_apk/presentation/widgets/widgets.dart';

const double leftPadding = 20.0;
const double initialScrollOffset = 250.0;
const double scrollDesiredPercent = 0.65;
const Duration duration = Duration(milliseconds: 100);

const double maxHeaderExtent = 400.0;
const double minHeaderExtent = 80.0;

const double avatarRadius = 30;
const double minAvatarRadius = 20;
const double maxAvatarRadius = 50;

const double minLeftOffset = 20;
const double maxleftOffset = 80;

const double minTopOffset = 8;
const double maxTopOffset = 50;

const double minFontSize = 16;
const double maxFontSize = 18;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.userImageTag,
    this.user,
  });

  final String? userImageTag;
  final User? user;

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: initialScrollOffset);

  void animateToMaxExtent() {
    scrollController.animateTo(
      50,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void animateToNormalExtent() {
    scrollController.animateTo(
      initialScrollOffset,
      duration: duration,
      curve: Curves.linear,
    );
  }

  bool get scrollStopped =>
      !scrollController.position.isScrollingNotifier.value;

  bool get mustExpand =>
      scrollController.offset < initialScrollOffset * scrollDesiredPercent;

  bool get mustRetract =>
      !mustExpand && scrollController.offset < initialScrollOffset;

  void _handleScrollingActivity() {
    if (scrollStopped) {
      if (mustRetract) {
        animateToNormalExtent();
      } else if (mustExpand) {
        animateToMaxExtent();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.position.isScrollingNotifier
            .addListener(_handleScrollingActivity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      Future.delayed(Duration.zero, () {
        context.pop();
      });
      return Container();
    }
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: PersistentProfileHeader(
                user: widget.user!,
                heroTag: widget.userImageTag ??
                    HeroTags.imageProfile1(widget.user!.id.toString())),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: ProfileView(context),
          )
        ],
      ),
    );
  }

  Widget ProfileView(BuildContext context) {
    return FadeInUp(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.height,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title:
                            Text("${AppLocalizations.of(context)!.telefono}:"),
                        subtitle: Text(widget.user!.movil),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("${AppLocalizations.of(context)!.ci}:"),
                        subtitle: Text(widget.user!.ci),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomCard(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            "${AppLocalizations.of(context)!.tipoUsuario}:"),
                        subtitle: Text(widget.user!.isClient
                            ? AppLocalizations.of(context)!.cliente
                            : AppLocalizations.of(context)!.company),
                      ),
                    ],
                  )),
            ),
            if (widget.user!.isCompany)
              Consumer(
                builder: (context, ref, child) {
                  final usersState = ref.watch(usersProvider);
                  return usersState.isLoading
                      ? const LoadingLogo()
                      : usersState.company != null
                          ? showDataCompany(usersState.company!)
                          : Container();
                },
              )
          ]),
        ),
      ),
    );
  }

  showDataCompany(Company company) {
    return FadeInUp(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Divider(
            height: 8,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("${AppLocalizations.of(context)!.company}:"),
                      subtitle: Text(company.company_name),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          "${AppLocalizations.of(context)!.codigoCompany}:"),
                      subtitle: Text(company.company_code),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomCard(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title:
                          Text("${AppLocalizations.of(context)!.tipoCompany}:"),
                      subtitle: Text(company.company_code),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class PersistentProfileHeader extends SliverPersistentHeaderDelegate {
  PersistentProfileHeader({
    required this.heroTag,
    required this.user,
  });

  final String heroTag;
  final User user;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final paddingTop = MediaQuery.of(context).padding.top;
    double percent = (shrinkOffset - initialScrollOffset) /
        (maxExtent - initialScrollOffset - paddingTop - 60);

    double radius = avatarRadius * (1 - percent);
    radius = radius.clamp(minAvatarRadius, maxAvatarRadius);

    double leftOffset = maxleftOffset * 1.3 * percent;
    leftOffset = leftOffset.clamp(minLeftOffset, maxleftOffset);

    double topOffset = maxTopOffset * (1 - percent);
    topOffset = topOffset.clamp(minTopOffset, maxTopOffset);

    double fontSize = maxFontSize * 3 * (1 - percent);
    fontSize = fontSize.clamp(minFontSize, maxFontSize);

    bool mustExpand = shrinkOffset < initialScrollOffset * scrollDesiredPercent;

    return Container(
      color: context.secondaryContainer,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: duration,
            top: mustExpand ? 0 : paddingTop + topOffset,
            left: mustExpand ? 0 : leftOffset,
            child: Hero(
              tag: heroTag,
              child: AnimatedContainer(
                duration: duration,
                height: mustExpand ? maxExtent - shrinkOffset : 2 * radius,
                width:
                    mustExpand ? MediaQuery.of(context).size.width : 2 * radius,
                decoration: BoxDecoration(
                  shape:
                      shrinkOffset < 160 ? BoxShape.rectangle : BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(user.image),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            top: mustExpand
                ? (maxExtent - shrinkOffset) - 60
                : percent > 0.9
                    ? paddingTop + 8
                    : paddingTop + topOffset + radius / 2 - 7,
            left: mustExpand ? 10 : leftOffset + 2 * radius + 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  style: context.titleLarge.copyWith(
                    color: mustExpand ? Colors.white : null,
                    fontSize: mustExpand ? 24 : fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: Text(
                    "${user.name} ${user.lastName}",
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedDefaultTextStyle(
                  style: context.labelLarge.copyWith(
                    color: mustExpand ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  child: Text(
                    user.username,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          ProfileHeaderWidget(paddingTop: paddingTop, mustExpand: mustExpand),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.paddingTop,
    required this.mustExpand,
  });

  final double paddingTop;
  final bool mustExpand;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5 + paddingTop,
      left: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconButton(
                icon: Icons.arrow_back,
                color: mustExpand ? Colors.white : null,
                onPressed: () {
                  context.pop();
                }),
          ],
        ),
      ),
    );
  }
}
