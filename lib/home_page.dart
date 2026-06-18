import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();

  void simpanData() {
    String nim = nimController.text.trim();
    String nama = namaController.text.trim();

    if (nim.isEmpty || nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIM dan nama wajib diisi.')),
      );
      return;
    }

    final box = Hive.box('mahasiswaBox');
    box.put(nim, {'nim': nim, 'nama': nama});

    setState(() {});
    nimController.clear();
    namaController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil disimpan.')),
    );
  }

  void tambahData() {
    simpanData();
  }

  void editData(String oldNim) {
    String nimBaru = nimController.text.trim();
    String namaBaru = namaController.text.trim();

    if (nimBaru.isEmpty || namaBaru.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data yang diedit tidak boleh kosong.')),
      );
      return;
    }

    final box = Hive.box('mahasiswaBox');

    if (box.containsKey(oldNim)) {
      box.delete(oldNim);
      box.put(nimBaru, {'nim': nimBaru, 'nama': namaBaru});
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diedit.')),
      );
    }
  }

  @override
  void dispose() {
    nimController.dispose();
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Hive mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}