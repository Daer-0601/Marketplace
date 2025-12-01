import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import '../products/product_detail_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    
    // Verificar si es administrador (puedes agregar lógica de roles aquí)
    final isAdmin = authProvider.currentUser?.email?.contains('admin') ?? false;

    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Panel de Administración')),
        body: const Center(
          child: Text('No tienes permisos de administrador'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
      ),
      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Estadísticas
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2E7D32).withOpacity(0.1),
                        const Color(0xFF4CAF50).withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        'Total Productos',
                        productProvider.products.length.toString(),
                        Icons.inventory,
                      ),
                      _buildStatItem(
                        'Activos',
                        productProvider.products
                            .where((p) => p.isActive)
                            .length
                            .toString(),
                        Icons.check_circle,
                        const Color(0xFF2E7D32),
                      ),
                      _buildStatItem(
                        'Inactivos',
                        productProvider.products
                            .where((p) => !p.isActive)
                            .length
                            .toString(),
                        Icons.cancel,
                        Colors.red[700]!,
                      ),
                    ],
                  ),
                ),
                // Lista de productos
                Expanded(
                  child: productProvider.products.isEmpty
                      ? const Center(
                          child: Text('No hay productos para moderar'),
                        )
                      : ListView.builder(
                          itemCount: productProvider.products.length,
                          itemBuilder: (context, index) {
                            final product = productProvider.products[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: product.images.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          product.images.first,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.image_not_supported);
                                          },
                                        ),
                                      )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(product.title),
                                subtitle: Text(
                                  '${product.sellerName ?? "Sin vendedor"} - \$${product.price.toStringAsFixed(2)}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      product.isActive
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    const SizedBox(width: 8),
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: const Text('Ver detalles'),
                                          onTap: () {
                                            Future.delayed(
                                              Duration.zero,
                                              () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProductDetailScreen(
                                                      productId: product.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: Text(
                                            product.isActive
                                                ? 'Desactivar'
                                                : 'Activar',
                                          ),
                                          onTap: () async {
                                            await productProvider.updateProduct(
                                              id: product.id,
                                              isActive: !product.isActive,
                                            );
                                            if (mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    product.isActive
                                                        ? 'Producto desactivado'
                                                        : 'Producto activado',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        productId: product.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon,
      [Color? color]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (color ?? const Color(0xFF2E7D32)).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color ?? const Color(0xFF2E7D32), size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color ?? const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

