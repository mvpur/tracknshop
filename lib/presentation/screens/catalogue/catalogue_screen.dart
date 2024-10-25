import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/screens/catalogue/new_catalogue_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/catalogue_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';

class CatalogueScreen extends ConsumerStatefulWidget {
  static const String name = 'catalogue_screen';

  const CatalogueScreen({super.key});

  @override
  ConsumerState<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends ConsumerState<CatalogueScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(catalogueProvider.notifier).getAllCatalogues();
  }

  @override
  Widget build(BuildContext context) {
    List<Catalogue> catalogues = ref.watch(catalogueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(NewCatalogueScreen.name),
        child: const Icon(Icons.add),
      ),
      body: _CataloguesView(catalogues: catalogues),
    );
  }
}

class _CataloguesView extends StatelessWidget {
  final List<Catalogue> catalogues;

  const _CataloguesView({required this.catalogues});

  @override
  Widget build(BuildContext context) {
    if (catalogues.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: catalogues.length,
      itemBuilder: (context, index) {
        final catalogue = catalogues[index];
        return CatalogueItem(
          catalogue: catalogue,
          onTap: () => _goToCatalogueDetails(context, catalogue),
        );
      },
    );
  }

  _goToCatalogueDetails(BuildContext context, Catalogue catalogue) {
    context.pushNamed(
      CatalogueDetailScreen.name,
      pathParameters: {
        'catalogueId': catalogue.id,
      },
    );
  }
}
