import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class VipAccountScreen extends StatelessWidget {
  const VipAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                body: TabBarView(children: [
                  firstTabBarView(context),
                  photosCustomGridView()
                ]),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      leading: IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back)),
                      title: const Text('Nombre barbero'),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star_border_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                      centerTitle: true,
                      pinned: true,
                      bottom: AppBar(
                        leading: const SizedBox(),
                        leadingWidth: 0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: const TabBar(
                            isScrollable: false,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabAlignment: TabAlignment.center,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                text: 'Informacion',
                              ),
                              Tab(
                                text: 'Catalogo',
                              )
                            ]),
                      ),
                      onStretchTrigger: () async {},
                      stretchTriggerOffset: 50.0,
                      expandedHeight: size.height * 0.4,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Center(
                          child: rankingTable(context),
                        ),
                      ),
                    ),
                  ];
                })));
  }

  Column rankingTable(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FlutterLogo(
          size: 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  '200',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Text('Valoraciones'),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '3',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const Text('Promedio'),
              ],
            ),
            Column(
              children: [
                Text(
                  '3/120',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Text('Ranking por provincia'),
              ],
            ),
          ],
          // photosCustomGridView(),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget firstTabBarView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text("Dias laborales:", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(
          height: 10,
        ),
        const Wrap(
          spacing: 8,
          children: [
            Chip(label: Text('Lunes')),
            Chip(label: Text('Marte')),
            Chip(label: Text('Miercoles')),
            Chip(label: Text('Jueves')),
            Chip(label: Text('Viernes')),
            Chip(label: Text('Sabado')),
            Chip(label: Text('Domingo')),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on_outlined),
            label: const Text('Mostrar ubicación'))
      ],
    );
  }
}

Widget photosCustomGridView() {
  return GridView.custom(
    gridDelegate: SliverWovenGridDelegate.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 8,
      pattern: [
        const WovenGridTile(1),
        const WovenGridTile(
          5 / 7,
          crossAxisRatio: 0.9,
          alignment: AlignmentDirectional.centerEnd,
        ),
      ],
    ),
    childrenDelegate: SliverChildBuilderDelegate(
      childCount: 14,
      (context, index) => Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
