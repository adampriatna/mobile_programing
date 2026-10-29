import 'package:flutter/material.dart';

void main() {
  runApp(const WisataIndonesiaApp());
}

class WisataIndonesiaApp extends StatelessWidget {
  const WisataIndonesiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wisata Indonesia',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F8C),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F8FA),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/pantai': (context) => const KategoriPage(
              judul: 'Wisata Pantai',
              namaTempat: 'Pantai Kuta',
              gambar: 'assets/images/pantai_kuta.jpg',
              ikon: Icons.beach_access,
              deskripsi:
                  'Pantai Kuta merupakan salah satu destinasi wisata '
                  'populer di Bali. Pantai ini terkenal dengan pasirnya '
                  'yang indah, pemandangan matahari terbenam, dan '
                  'ombak yang cocok untuk berselancar.',
              lokasi: 'Bali, Indonesia',
            ),
        '/gunung': (context) => const KategoriPage(
              judul: 'Wisata Gunung',
              namaTempat: 'Gunung Bromo',
              gambar: 'assets/images/gunung_bromo.jpg',
              ikon: Icons.landscape,
              deskripsi:
                  'Gunung Bromo merupakan destinasi wisata alam di '
                  'Jawa Timur. Tempat ini terkenal dengan pemandangan '
                  'matahari terbit, lautan pasir, dan kawah gunung '
                  'yang menjadi daya tarik wisatawan.',
              lokasi: 'Jawa Timur, Indonesia',
            ),
        '/budaya': (context) => const KategoriPage(
              judul: 'Wisata Budaya',
              namaTempat: 'Tari Kecak',
              gambar: 'assets/images/tari_kecak.jpg',
              ikon: Icons.theater_comedy,
              deskripsi:
                  'Tari Kecak adalah pertunjukan seni tradisional Bali '
                  'yang menampilkan gerakan tari, suara khas para '
                  'penari, dan cerita yang terinspirasi dari kisah '
                  'Ramayana.',
              lokasi: 'Bali, Indonesia',
            ),
        '/kuliner': (context) => const KategoriPage(
              judul: 'Wisata Kuliner',
              namaTempat: 'Rendang',
              gambar: 'assets/images/rendang.jpg',
              ikon: Icons.restaurant,
              deskripsi:
                  'Rendang merupakan makanan khas Sumatera Barat '
                  'yang dibuat menggunakan daging dan rempah-rempah. '
                  'Hidangan ini dimasak dalam waktu lama sehingga '
                  'menghasilkan cita rasa yang kaya.',
              lokasi: 'Sumatera Barat, Indonesia',
            ),
        '/detail': (context) {
          final namaTempat =
              ModalRoute.of(context)!.settings.arguments as String? ??
                  'Pantai Kuta';

          return DetailPage(namaTempat: namaTempat);
        },
      },
    );
  }
}

// ==================== HALAMAN HOME ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> kategori = const [
    {
      'judul': 'Pantai',
      'ikon': Icons.beach_access,
      'warna': Color(0xFF168AAD),
      'route': '/pantai',
      'deskripsi': 'Keindahan laut Indonesia',
    },
    {
      'judul': 'Gunung',
      'ikon': Icons.landscape,
      'warna': Color(0xFF40916C),
      'route': '/gunung',
      'deskripsi': 'Pesona alam pegunungan',
    },
    {
      'judul': 'Budaya',
      'ikon': Icons.theater_comedy,
      'warna': Color(0xFF9B5DE5),
      'route': '/budaya',
      'deskripsi': 'Tradisi dan seni Nusantara',
    },
    {
      'judul': 'Kuliner',
      'ikon': Icons.restaurant,
      'warna': Color(0xFFF08C46),
      'route': '/kuliner',
      'deskripsi': 'Cita rasa khas Indonesia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
        title: const Text(
          'Wisata Indonesia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jelajahi Keindahan Indonesia',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16324F),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Temukan destinasi wisata favoritmu di Nusantara.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 22),

              // Banner Raja Ampat
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/raja_ampat.jpg',
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          width: double.infinity,
                          color: const Color(0xFF168AAD),
                          child: const Icon(
                            Icons.landscape,
                            size: 80,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.75),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 18,
                      right: 18,
                      bottom: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DESTINASI UNGGULAN',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Raja Ampat, Papua',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Surga tropis di Indonesia Timur',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Jelajahi Kategori',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16324F),
                ),
              ),

              const SizedBox(height: 14),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.15,
                children: kategori.map((item) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        item['route'] as String,
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: const Color(0xFFE8F0F2),
                      shadowColor:
                          Colors.black.withValues(alpha: 0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(
                          color: Color(0xFFB8CDD2),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: (item['warna'] as Color)
                                    .withValues(alpha: 0.12),
                                borderRadius:
                                    BorderRadius.circular(15),
                              ),
                              child: Icon(
                                item['ikon'] as IconData,
                                size: 32,
                                color: item['warna'] as Color,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item['judul'] as String,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['deskripsi'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Jelajahi Indonesia, cintai Nusantara 🇮🇩',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== HALAMAN KATEGORI ====================

class KategoriPage extends StatelessWidget {
  final String judul;
  final String namaTempat;
  final String gambar;
  final IconData ikon;
  final String deskripsi;
  final String lokasi;

  const KategoriPage({
    super.key,
    required this.judul,
    required this.namaTempat,
    required this.gambar,
    required this.ikon,
    required this.deskripsi,
    required this.lokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                gambar,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: const Color(0xFFE0F2F1),
                    child: Icon(
                      ikon,
                      size: 90,
                      color: const Color(0xFF087F8C),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            Text(
              namaTempat,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16324F),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF087F8C),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    lokasi,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Tentang Destinasi',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              deskripsi,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: namaTempat,
                  );
                },
                icon: const Icon(Icons.explore),
                label: const Text('Lihat Detail Wisata'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F8C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Beranda'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HALAMAN DETAIL ====================

class DetailPage extends StatelessWidget {
  final String namaTempat;

  const DetailPage({
    super.key,
    required this.namaTempat,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dataWisata = {
      'Pantai Kuta': 'assets/images/pantai_kuta.jpg',
      'Gunung Bromo': 'assets/images/gunung_bromo.jpg',
      'Tari Kecak': 'assets/images/tari_kecak.jpg',
      'Rendang': 'assets/images/rendang.jpg',
    };

    final gambar = dataWisata[namaTempat];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Wisata'),
        backgroundColor: const Color(0xFF087F8C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (gambar != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  gambar,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      width: double.infinity,
                      color: const Color(0xFFE0F2F1),
                      child: const Icon(
                        Icons.landscape,
                        size: 90,
                        color: Color(0xFF087F8C),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 22),

            const Text(
              'Destinasi Pilihanmu',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF087F8C),
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              namaTempat,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF16324F),
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              'Terima kasih telah menjelajahi wisata Indonesia! '
              'Indonesia memiliki beragam keindahan alam, budaya, '
              'dan kuliner yang menarik untuk dikenal. '
              'Jadikan perjalananmu sebagai pengalaman yang berkesan.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                height: 1.8,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Kategori'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF087F8C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}