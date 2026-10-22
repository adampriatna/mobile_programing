import 'package:flutter/material.dart';

void main() {
  runApp(const StockMasterApp());
}

class StockMasterApp extends StatelessWidget {
  const StockMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockMaster',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF167D68),
        ),
        useMaterial3: true,
      ),
      home: const StockHomePage(),
    );
  }
}

class StockHomePage extends StatefulWidget {
  const StockHomePage({super.key});

  @override
  State<StockHomePage> createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  final List<Map<String, dynamic>> barang = [
    {'nama': 'Baut Baja', 'kategori': 'Bahan Baku', 'stok': 120},
    {'nama': 'Kabel Listrik', 'kategori': 'Elektronik', 'stok': 45},
    {'nama': 'Sarung Tangan', 'kategori': 'Keselamatan', 'stok': 8},
  ];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  int get totalStok => barang.fold(
        0,
        (total, item) => total + (item['stok'] as int),
      );

  @override
  void dispose() {
    namaController.dispose();
    stokController.dispose();
    super.dispose();
  }

  void ubahStok(int index, int perubahan) {
    setState(() {
      final stokSekarang = barang[index]['stok'] as int;
      barang[index]['stok'] =
          (stokSekarang + perubahan).clamp(0, 999999);
    });
  }

  void hapusBarang(int index) {
    final nama = barang[index]['nama'] as String;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus "$nama"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                barang.removeAt(index);
              });

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$nama berhasil dihapus.'),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void tambahBarang() {
    final nama = namaController.text.trim();
    final stok = int.tryParse(stokController.text.trim());

    if (nama.isEmpty || stok == null || stok < 0 || stok > 999999) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Isi nama barang dan stok 0–999999 dengan benar.',
          ),
        ),
      );
      return;
    }

    setState(() {
      barang.add({
        'nama': nama,
        'kategori': 'Barang Industri',
        'stok': stok,
      });
    });

    namaController.clear();
    stokController.clear();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barang berhasil ditambahkan.'),
      ),
    );
  }

  void bukaFormTambah() {
    namaController.clear();
    stokController.clear();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Tambah Barang'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah stok',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: tambahBarang,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF167D68),
        foregroundColor: Colors.white,
        title: const Text(
          'StockMaster',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: bukaFormTambah,
            icon: const Icon(Icons.add_box_outlined),
            tooltip: 'Tambah barang',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Manajemen Stok Industri',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pantau dan kelola persediaan barang dengan mudah.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Ringkasan stok
              Card(
                color: const Color(0xFF167D68),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.white,
                        size: 42,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Stok Barang',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '$totalStok unit',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${barang.length} jenis',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daftar Barang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: bukaFormTambah,
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah'),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (barang.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text('Belum ada barang. Silakan tambah barang.'),
                    ),
                  ),
                ),

              ...List.generate(barang.length, (index) {
                final item = barang[index];
                final stok = item['stok'] as int;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFFDCEFE9),
                          child: Icon(
                            Icons.inventory_2,
                            color: Color(0xFF167D68),
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['nama'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                item['kategori'] as String,
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                stok <= 10
                                    ? 'Stok menipis: $stok unit'
                                    : 'Stok: $stok unit',
                                style: TextStyle(
                                  color: stok <= 10
                                      ? Colors.red
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Kurangi stok
                        IconButton(
                          onPressed: stok > 0
                              ? () => ubahStok(index, -1)
                              : null,
                          icon: const Icon(Icons.remove_circle_outline),
                          tooltip: 'Kurangi stok',
                        ),

                        // Tambah stok
                        IconButton(
                          onPressed: stok < 999999
                              ? () => ubahStok(index, 1)
                              : null,
                          icon: const Icon(Icons.add_circle_outline),
                          tooltip: 'Tambah stok',
                        ),

                        // Hapus barang
                        IconButton(
                          onPressed: () => hapusBarang(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          tooltip: 'Hapus barang',
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: bukaFormTambah,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}