import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const ProfilMahasiswaApp());
}

class ProfilMahasiswaApp extends StatelessWidget {
  const ProfilMahasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
      ),
      home: const ProfilMahasiswaPage(),
    );
  }
}

class ProfilMahasiswaPage extends StatefulWidget {
  const ProfilMahasiswaPage({super.key});

  @override
  State<ProfilMahasiswaPage> createState() =>
      _ProfilMahasiswaPageState();
}

class _ProfilMahasiswaPageState
    extends State<ProfilMahasiswaPage> {
  String nama = 'Muhammad Adam Priatna';
  String nim = '2495114013';
  String jurusan = 'Teknik Informatika';
  String universitas = 'Nama Universitas';
  String semester = '5';
  String email = 'adam@example.com';
  String hobi = 'Teknologi dan pemrograman';

  String? fotoBase64;

  @override
  void initState() {
    super.initState();
    muatData();
  }

  void muatData() {
    try {
      final storage = html.window.localStorage;

      nama = storage['profil_nama'] ?? nama;
      nim = storage['profil_nim'] ?? nim;
      jurusan = storage['profil_jurusan'] ?? jurusan;
      universitas =
          storage['profil_universitas'] ?? universitas;
      semester = storage['profil_semester'] ?? semester;
      email = storage['profil_email'] ?? email;
      hobi = storage['profil_hobi'] ?? hobi;
      fotoBase64 = storage['profil_foto'];
    } catch (_) {
      // Gunakan data awal jika penyimpanan tidak tersedia.
    }
  }

  void simpanData() {
    try {
      final storage = html.window.localStorage;

      storage['profil_nama'] = nama;
      storage['profil_nim'] = nim;
      storage['profil_jurusan'] = jurusan;
      storage['profil_universitas'] = universitas;
      storage['profil_semester'] = semester;
      storage['profil_email'] = email;
      storage['profil_hobi'] = hobi;

      if (fotoBase64 != null) {
        storage['profil_foto'] = fotoBase64!;
      } else {
        storage.remove('profil_foto');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil disimpan'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data gagal disimpan di browser'),
        ),
      );
    }
  }

  ImageProvider? get fotoProvider {
    if (fotoBase64 == null || fotoBase64!.isEmpty) {
      return null;
    }

    try {
      return MemoryImage(base64Decode(fotoBase64!));
    } catch (_) {
      return null;
    }
  }

  Future<void> pilihFoto() async {
    final input = html.FileUploadInputElement()
      ..accept = 'image/*';

    input.click();
    await input.onChange.first;

    final files = input.files;
    if (files == null || files.isEmpty) return;

    final reader = html.FileReader()
      ..readAsDataUrl(files.first);

    await reader.onLoad.first;

    if (reader.result is! String) return;

    try {
      final dataUrl = reader.result as String;
      final bagian = dataUrl.split(',');

      if (bagian.length < 2) return;

      final bytes = base64Decode(bagian.last);
      final decoded = img.decodeImage(bytes);

      if (decoded == null) {
        if (!mounted) return;
        tampilkanPesan('File foto tidak dapat dibaca');
        return;
      }

      final fotoAsli = img.bakeOrientation(decoded);

      if (!mounted) return;

      final hasil = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => EditorFotoPage(fotoAsli: fotoAsli),
        ),
      );

      if (hasil == null || !mounted) return;

      setState(() {
        fotoBase64 = hasil;
      });

      simpanData();
    } catch (_) {
      if (!mounted) return;
      tampilkanPesan('Gagal memproses foto');
    }
  }

  void tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  Future<void> editProfil() async {
    final namaC = TextEditingController(text: nama);
    final nimC = TextEditingController(text: nim);
    final jurusanC = TextEditingController(text: jurusan);
    final universitasC =
        TextEditingController(text: universitas);
    final semesterC = TextEditingController(text: semester);
    final emailC = TextEditingController(text: email);
    final hobiC = TextEditingController(text: hobi);

    Map<String, String>? hasilEdit;

    try {
      final berhasil = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Edit Profil Mahasiswa'),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    kolomInput(
                      namaC,
                      'Nama Lengkap',
                      Icons.person_outline,
                    ),
                    kolomInput(
                      nimC,
                      'NIM',
                      Icons.badge_outlined,
                    ),
                    kolomInput(
                      jurusanC,
                      'Program Studi',
                      Icons.school_outlined,
                    ),
                    kolomInput(
                      universitasC,
                      'Universitas',
                      Icons.account_balance_outlined,
                    ),
                    kolomInput(
                      semesterC,
                      'Semester',
                      Icons.calendar_month_outlined,
                      angka: true,
                    ),
                    kolomInput(
                      emailC,
                      'Email',
                      Icons.email_outlined,
                    ),
                    kolomInput(
                      hobiC,
                      'Hobi / Deskripsi Singkat',
                      Icons.favorite_outline,
                      banyakBaris: 2,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(dialogContext, false),
                child: const Text('Batal'),
              ),
              FilledButton.icon(
                onPressed: () {
                  if (namaC.text.trim().isEmpty ||
                      nimC.text.trim().isEmpty) {
                    ScaffoldMessenger.of(dialogContext)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Nama dan NIM wajib diisi',
                        ),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(dialogContext, true);
                },
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan'),
              ),
            ],
          );
        },
      );

      if (berhasil == true) {
        hasilEdit = {
          'nama': namaC.text.trim(),
          'nim': nimC.text.trim(),
          'jurusan': jurusanC.text.trim(),
          'universitas': universitasC.text.trim(),
          'semester': semesterC.text.trim(),
          'email': emailC.text.trim(),
          'hobi': hobiC.text.trim(),
        };
      }
    } finally {
      namaC.dispose();
      nimC.dispose();
      jurusanC.dispose();
      universitasC.dispose();
      semesterC.dispose();
      emailC.dispose();
      hobiC.dispose();
    }

    if (hasilEdit == null || !mounted) return;

    setState(() {
      nama = hasilEdit!['nama']!;
      nim = hasilEdit['nim']!;
      jurusan = hasilEdit['jurusan']!;
      universitas = hasilEdit['universitas']!;
      semester = hasilEdit['semester']!;
      email = hasilEdit['email']!;
      hobi = hasilEdit['hobi']!;
    });

    simpanData();
  }

  Widget kolomInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool angka = false,
    int banyakBaris = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: angka
            ? TextInputType.number
            : TextInputType.text,
        maxLines: banyakBaris,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void tampilkanDetail() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person_pin, color: Colors.indigo),
            SizedBox(width: 8),
            Expanded(child: Text('Detail Mahasiswa')),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailBaris('Nama', nama),
              detailBaris('NIM', nim),
              detailBaris('Program Studi', jurusan),
              detailBaris('Universitas', universitas),
              detailBaris('Semester', semester),
              detailBaris('Email', email),
              detailBaris('Hobi', hobi),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget detailBaris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: nilai),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final foto = fotoProvider;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          tooltip: 'Menu',
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: 'Profil Mahasiswa',
              applicationVersion: '1.0',
              children: const [
                Text(
                  'Aplikasi praktikum Widget dan Layout Flutter.',
                ),
              ],
            );
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Menu lainnya',
            onSelected: (nilai) {
              if (nilai == 'edit') {
                editProfil();
              } else if (nilai == 'detail') {
                tampilkanDetail();
              } else if (nilai == 'foto') {
                pilihFoto();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit Profil'),
                ),
              ),
              PopupMenuItem(
                value: 'foto',
                child: ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text('Ganti Foto'),
                ),
              ),
              PopupMenuItem(
                value: 'detail',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Detail'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Foto dan nama mahasiswa.
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor:
                                  Colors.indigo.shade100,
                              backgroundImage: foto,
                              child: foto == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 72,
                                      color: Colors.indigo,
                                    )
                                  : null,
                            ),
                            Material(
                              color: Colors.indigo,
                              shape: const CircleBorder(),
                              child: IconButton(
                                tooltip: 'Pilih dan crop foto',
                                onPressed: pilihFoto,
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.camera_alt,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          nama,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          jurusan,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Mahasiswa Semester $semester',
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Informasi identitas.
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Mahasiswa',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          infoRow(
                            Icons.badge_outlined,
                            'NIM',
                            nim,
                          ),
                          infoRow(
                            Icons.school_outlined,
                            'Program Studi',
                            jurusan,
                          ),
                          infoRow(
                            Icons.account_balance_outlined,
                            'Universitas',
                            universitas,
                          ),
                          infoRow(
                            Icons.calendar_month_outlined,
                            'Semester',
                            semester,
                          ),
                          infoRow(
                            Icons.email_outlined,
                            'Email',
                            email,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Informasi tambahan sesuai wireframe.
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.interests_outlined,
                              size: 42,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informasi Tambahan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Hobi / Deskripsi Singkat',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hobi.isEmpty
                                      ? 'Belum ada deskripsi'
                                      : hobi,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Tombol aksi.
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: editProfil,
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit Profil'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: tampilkanDetail,
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Detail'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Profil Mahasiswa • Praktikum Flutter',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.indigo,
            size: 22,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditorFotoPage extends StatefulWidget {
  final img.Image fotoAsli;

  const EditorFotoPage({
    super.key,
    required this.fotoAsli,
  });

  @override
  State<EditorFotoPage> createState() => _EditorFotoPageState();
}

class _EditorFotoPageState extends State<EditorFotoPage> {
  double zoom = 1.0;
  double posisiX = 0.0;
  double posisiY = 0.0;

  int get sisiMinimum {
    final w = widget.fotoAsli.width;
    final h = widget.fotoAsli.height;
    return w < h ? w : h;
  }

  int get ukuranCrop {
    return (sisiMinimum / zoom)
        .round()
        .clamp(1, sisiMinimum);
  }

  int get cropX {
    final maxX = widget.fotoAsli.width - ukuranCrop;
    return ((maxX * (posisiX + 1) / 2).round())
        .clamp(0, maxX);
  }

  int get cropY {
    final maxY = widget.fotoAsli.height - ukuranCrop;
    return ((maxY * (posisiY + 1) / 2).round())
        .clamp(0, maxY);
  }

  Uint8List buatPreview() {
    final potongan = img.copyCrop(
      widget.fotoAsli,
      x: cropX,
      y: cropY,
      width: ukuranCrop,
      height: ukuranCrop,
    );

    final kecil = img.copyResize(
      potongan,
      width: 320,
      height: 320,
    );

    return Uint8List.fromList(
      img.encodeJpg(kecil, quality: 80),
    );
  }

  void resetPosisi() {
    setState(() {
      zoom = 1;
      posisiX = 0;
      posisiY = 0;
    });
  }

  void terapkanFoto() {
    final potongan = img.copyCrop(
      widget.fotoAsli,
      x: cropX,
      y: cropY,
      width: ukuranCrop,
      height: ukuranCrop,
    );

    final hasil = img.copyResize(
      potongan,
      width: 512,
      height: 512,
    );

    Navigator.pop(
      context,
      base64Encode(img.encodeJpg(hasil, quality: 90)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preview = buatPreview();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atur Foto Profil'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Sesuaikan Foto Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Atur zoom dan posisi foto sebelum diterapkan.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.indigo,
                        width: 4,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.memory(
                      preview,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.zoom_out),
                      const SizedBox(width: 8),
                      const Text('Zoom'),
                      Expanded(
                        child: Slider(
                          value: zoom,
                          min: 1,
                          max: 3,
                          divisions: 20,
                          label: '${zoom.toStringAsFixed(1)}x',
                          onChanged: (nilai) {
                            setState(() => zoom = nilai);
                          },
                        ),
                      ),
                      const Icon(Icons.zoom_in),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.swap_horiz),
                      const SizedBox(width: 8),
                      const Text('Horizontal'),
                      Expanded(
                        child: Slider(
                          value: posisiX,
                          min: -1,
                          max: 1,
                          onChanged: (nilai) {
                            setState(() => posisiX = nilai);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.swap_vert),
                      const SizedBox(width: 8),
                      const Text('Vertikal'),
                      Expanded(
                        child: Slider(
                          value: posisiY,
                          min: -1,
                          max: 1,
                          onChanged: (nilai) {
                            setState(() => posisiY = nilai);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: resetPosisi,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: terapkanFoto,
                          icon: const Icon(Icons.check),
                          label: const Text('Terapkan Foto'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}