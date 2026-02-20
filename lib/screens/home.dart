import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:price_scrapper/components/product_card.dart';
import 'package:price_scrapper/model/product_model.dart';
import 'package:price_scrapper/services/product_fetch_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<bool> _isSearchBarAtTop = ValueNotifier(false);

  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final fetchedProducts = await ProductFetchService().fetchProduct(
        user.email!,
      );
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro loading Products")));
      });
    }
  }

  void _onScroll() {
    final isAtTop = _scrollController.offset > 120;

    // Only update if the state actually changed
    if (isAtTop != _isSearchBarAtTop) {
      _isSearchBarAtTop.value = isAtTop;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main scrollable content
          RefreshIndicator(
            onRefresh: fetchProducts,
            child: CustomScrollView(
              cacheExtent: 800,
              controller: _scrollController,
              slivers: [
                // Large Title Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App Title
                        const Text(
                          'JUTAFY',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                            letterSpacing: -1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        // Text(
                        //   'jute pe paise bachao',
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.grey[600],
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  ),
                ),

                // Search Bar (in scroll view)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: _buildSearchBar(),
                  ),
                ),

                // Content Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Text(
                        //   'Recent Links',
                        //   style: TextStyle(
                        //     fontSize: 22,
                        //     fontWeight: FontWeight.bold,
                        //     color: Color(0xFF000000),
                        //     letterSpacing: -0.5,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Dynamic product list with loading states
                if (isLoading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                else if (products.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text("No products found"),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];

                      return RepaintBoundary(
                        child: ProductCard(
                          product: product,
                          onTap: () {

                          },
                        ),
                      );
                    }, childCount: products.length),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),

          // Sticky Search Bar at Top (appears when scrolling)
          ValueListenableBuilder<bool>(
            valueListenable: _isSearchBarAtTop,
            builder: (context, isAtTop, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: isAtTop ? 0 : -100,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: _buildSearchBar(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // Floating Action Button
      // floatingActionButton: Container(
      //   width: 60,
      //   height: 60,
      //   decoration: BoxDecoration(
      //     gradient: const LinearGradient(
      //       colors: [Color(0xFF007AFF), Color(0xFF00C7FF)],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //     borderRadius: BorderRadius.circular(30),
      //     boxShadow: [
      //       BoxShadow(
      //         color: const Color(0xFF007AFF).withOpacity(0.4),
      //         blurRadius: 16,
      //         offset: const Offset(0, 8),
      //       ),
      //     ],
      //   ),
      //   child: Material(
      //     color: Colors.transparent,
      //     child: InkWell(
      //       borderRadius: BorderRadius.circular(30),
      //       onTap: () {
      //         // Handle add link
      //       },
      //       child: const Icon(Icons.add, color: Colors.white, size: 28),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildSearchBar() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _searchController,
      builder: (context, value, child) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Paste your link here',
              prefixIcon: const Icon(Icons.link),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              )
                  : null,
              border: InputBorder.none,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLinkCard({
    required String title,
    required String url,
    required String date,
  }) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E5EA), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Handle link tap
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Link Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF007AFF), Color(0xFF00C7FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.link,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Link Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                            letterSpacing: -0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          url,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8E8E93),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAEAEB2),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow Icon
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFFAEAEB2),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
