
import 'package:intl/intl.dart';

import 'barang.dart';
double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHarga(bool anggota, double hAnggota, double hUmum) {
  if (anggota) {
    return hAnggota;
  } else {
    return hUmum;
  }
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}


double bayarAkhir(int jumlah, double harga, double persenPotongan) {
  double total = hitungTotal(jumlah, harga);
  return hitungHargaAkhir(total, persenPotongan);
}


void prosesBeli(Barang barang, String inputJumlah) {
  try {
    // 1. Coba konversi input menjadi angka
    int jumlah = int.parse(inputJumlah);
    
    // 2. Cek apakah jumlah melebihi stok, jika ya lempar galat (Exception)
    if (jumlah > barang.stok) {
      throw RangeError("Jumlah beli melebihi sisa stok!");
    }

    // 3. Proses penjualan
    bool berhasil = barang.jual(jumlah);
    if (berhasil) {
      print("✓ Transaksi berhasil! Terjual $jumlah ${barang.nama}. Sisa stok: ${barang.stok}");
    }
    
  } on FormatException {
    // Tangani galat 1: Input bukan angka
    print("✗ Kesalahan Format: '$inputJumlah' bukan angka, ulangi.");
  } on RangeError catch (e) {
    // Tangani galat 2: Jumlah beli melebihi stok
    print("✗ Kesalahan Stok: ${e.message}");
  } catch (e) {
    // Tangani galat tak terduga lainnya
    print("✗ Galat tak dikenal: $e");
  } finally {
    // Selalu dijalankan, baik berhasil maupun gagal
    print("📋 Transaksi dicatat di log.\n");
  }
}

// === JAWABAN (RPL-12.2-7S1 - HOTS-1) ===
// Mengapa pesan spesifik menolong petugas?
// Karena dengan adanya pesan yang spesifik kita petugas bisa tahu langsung apa 
// yang salah tidak perlu menebak atau mencari apa yang salah dari ketikan mereka

// === JAWABAN (RPL-12.2-7S2 - HOTS-2) ===
// Bagaimana merancang respons berbeda?
// Kita menggunakan "on FormatException" khusus untuk menangani galat ketikan (bukan angka), 
// dan menggunakan "throw RangeError" dipadukan dengan "on RangeError catch" khusus 
// untuk menangani jumlah stok yang kurang. Sehingga masing-masing galat akan 
// memberikan pesan yang spesifik kepada pengguna.

// === JAWABAN (RPL-12.2 - Tantangan Level 3) ===
// Apakah semua bagian program perlu try-catch atau hanya yang berisiko?
// Tidak, try-catch HANYA perlu digunakan pada bagian yang "berisiko" (seperti mengolah 
// input pengguna, membaca database, atau akses internet). 
// Berdasarkan prinsip efisiensi, alasannya adalah:
// 1. Beban Kinerja (Overhead): Mekanisme try-catch memakan lebih banyak waktu proses dan memori. 
//    Jika setiap baris kode sederhana dibungkus try-catch, aplikasi akan menjadi lambat.
// 2. Keterbacaan (Readability): Menabur try-catch di seluruh bagian program akan membuat 
//    kode menjadi panjang, kotor, dan sangat sulit dibaca (Spaghetti code).
// 3. Efisiensi Alur Logika (Anti-Pattern): Secara desain, fungsi try-catch diciptakan 
//    khusus untuk menangani kejadian "luar biasa" yang tidak terduga, BUKAN sebagai 
//    pengganti if-else. Menjadikan try-catch sebagai alat pengecekan rutin sehari-hari 
//    (exception-driven logic) adalah anti-pattern yang jauh lebih lambat dan memakan 
//    waktu ketimbang sekadar menggunakan validasi kondisi "if" sederhana.

// === JAWABAN (RPL-12.3 - Pemrograman Asinkron) ===
// Mengapa operasi yang butuh waktu (memuat laporan) sebaiknya asinkron?
// Operasi seperti memuat data (I/O, database, API) memakan waktu. Jika dilakukan secara 
// sinkron, program akan "membeku" (block) selama menunggu, dan pengguna tidak bisa 
// melakukan apa-apa. Dengan asinkron (async/await), program bisa tetap merespons 
// (tetap jalan di latar belakang) sementara menunggu proses tersebut selesai.
// 
// Apa yang dirasakan pengguna bila program membeku tanpa pemberitahuan?
// Pengguna akan merasa programnya rusak (crash atau hang), menjadi frustrasi, 
// dan cenderung akan mematikan program secara paksa (force close) padahal 
// program sebenarnya sedang bekerja lambat.

Future<void> muatLaporan() async {
  print("\n=== MEMUAT LAPORAN ===");
  print("Menyiapkan laporan...");
  await Future.delayed(Duration(seconds: 1)); // Simulasi jeda 1 detik
  print("Laporan siap!");
}

Future<void> main() async {

  final formatRupiah = NumberFormat('#,##0', 'id_ID');
  // Buat semua objek Barang sekaligus dalam List
  List<Barang> daftarBarang = [
    Barang("Buku Tulis", 3000.0, 10),
    Barang("Pulpen", 2500.0, 20),
    Barang("Roti", 5000.0, 3),
    Barang("Penghapus", 1500.0, 15),
  ];

  // === DEMO BARANG PROMO ===
  BarangPromo barangPromo = BarangPromo("Susu Ultra", 8000.0, 50, 20);
  barangPromo.tampilkan();
  print("");

  // === ENKAPSULASI ===
  print("=== UJI ENKAPSULASI (SEBELUM DISERANG) ===");
  Barang bukuTulis = Barang("Buku Tulis", 3000.0, 5);
  print("Stok awal: ${bukuTulis.stok}");
  bukuTulis.jual(3); // Berhasil, stok cukup
  print("Setelah jual 3 → Sisa stok: ${bukuTulis.stok}");
  bukuTulis.jual(5); // Gagal, stok tidak cukup
  print("");
  
  // === UJI SERANGAN ENKAPSULASI ===
  print("--- Uji Serangan ---");
  // bukuTulis._stok = 999; // ERROR! Sekarang ini ditolak oleh Dart karena beda file
  print("Serangan diblokir! Kita tidak bisa lagi mengubah _stok secara langsung.\n");

  print("=== UJI ENKAPSULASI (SETELAH DISERANG) ===");
  print("Stok awal: ${bukuTulis.stok}");
  bukuTulis.jual(3); // Berhasil, stok cukup
  print("Setelah jual 3 → Sisa stok: ${bukuTulis.stok}");
  bukuTulis.jual(5); // Tetap Gagal! Perlindungan berhasil
  print("Setelah jual 5 → Sisa stok: ${bukuTulis.stok}");
  print("==================================================\n");
  
  // === JAWABAN (Uji Serangan) ===
  // Apa yang terjadi & apa artinya bagi keamanan data?
  // Yang terjadi: Nilai stok BERHASIL diubah secara paksa menjadi 999.
  // Artinya: Keamanan data (enkapsulasi) ternyata masih jebol! 
  // Hal ini terjadi karena di bahasa Dart, variabel privat (_) hanya menyembunyikan 
  // data dari FILE LAIN (library-level privacy), BUKAN dari dalam file yang sama. 
  // Karena fungsi main() dan class Barang masih berada di satu file (main.dart) yang sama,
  // main() masih bisa menembus perlindungan _stok. 
  // Solusi sejati: class Barang harus dipisah ke file tersendiri (misal barang.dart) 
  // agar _stok benar-benar kebal dari serangan fungsi di luar kelasnya.

  // === DEMO prosesBeli (try-catch-finally) ===
  Barang penghapus = Barang("Penghapus", 1500.0, 10);
  print("=== DEMO PROSES BELI ===");
  prosesBeli(penghapus, "3");    // Input valid
  prosesBeli(penghapus, "dua"); // Input salah ketik (teks)
  prosesBeli(penghapus, "99");  // Input valid tapi stok tidak cukup

  // === JAWABAN Tabel G / Uji Ketahanan) ===
  // Bagaimana penanganan galat meningkatkan kepercayaan pengurus pada sistem?
  // Penanganan galat menggunakan try-catch membuat program menjadi lebih tangguh atau kuat.
  // Ketika pengurus tidak sengaja memasukkan huruf "dua" saat diminta memasukkan angka, 
  // sistem tidak akan berhenti mendadak (crash). Sebaliknya, sistem menangkap error tersebut,
  // memberikan pesan peringatan yang ramah dan jelas, lalu tetap melanjutkan operasionalnya. 
 
  // === DAFTAR BARANG ===
  print("=== DAFTAR BARANG ===");
  for (Barang barang in daftarBarang) {
    barang.tampilkan();
  }
  print("\n");

  // JAWABAN: Apa yang lebih baik dibanding cara Sprint 3?
  // Dengan menggunakan list bisa lebih rapi daripada membuat 3 list terpisah 
  // (list nama, list harga, list stok). Karena datanya sekarang dibungkus dalam satu objek utuh,
  // data tidak akan lagi tertukar atau tidak sesuai urutannya meskipun 
  // ada ratusan atau beribu-ribu barang baru yang ditambahkan, dihapus, atau diurutkan ulang.

  // === RPL-12.2-3S1 - HOTS-1: AKUMULASI NILAI STOK ===
  double totalNilaiStok = 0;
  for (Barang b in daftarBarang) {
    totalNilaiStok += b.nilaiStok(); // Akumulasi memanggil method nilaiStok()
  }
  
  // JAWABAN (HOTS-1): Untuk apa angka total nilai stok berguna bagi laporan aset koperasi?
  // Angka ini berguna untuk menunjukkan total harta mati yang sedang tersimpan di koperasi 
  // berupa fisik barang. Informasi seperti ini sangat krusial untuk laporan keuangan agar 
  // pengurusnya tahu berapa banyak modal uang yang sedang tertahan dalam bentuk stok barang 
  // yang belum berhasil terjual.
  print("=== TOTAL NILAI SELURUH STOK KOPERASI ===");
  print("Rp${formatRupiah.format(totalNilaiStok)}");
  print("=========================================\n");

  print("=== LAPORAN STOK MENIPIS (< 5) ===");
  bool adaBarangMenipis = false;
  for (Barang b in daftarBarang) {
    if (b.stok < 5) {
      print("- ${b.nama} sisa stok: ${b.stok}");
      adaBarangMenipis = true;
    }
  }
  if (!adaBarangMenipis) {
    print("Semua stok barang masih aman (>= 5).");
  }
  print("==================================\n");

  // === jawaban (LKPD-5) ===
  // Apa keuntungan memodelkan barang sebagai objek bagi pengembangan sistem koperasi ke depan?
  // 1. mudah saat ingin di kembangkan lagi karena kita hanya perlu nambah atribut baru saja
  //    tidak perlu mengubah semuanya secara manual, misal jika koperasi ingin menambah data baru 
  //    seperti tanggal kadaluarsa.
  // 2. data tidak mudah tertukar pada bagian urutanya lagi karena sudah menjadi 1 object.
  // 3. bisa digunakan ulang (reusable) yang mana itu memudahkan kita sebagai programmer 
  //    karena tidak perlu menulis ulang strukturnya lagi.

  // === JAWABAN (Tantangan Level 2) ===
  // Mengapa menaruh pengecekan (bisaDijual) di dalam objek Barang lebih baik?
  // Karena pengecekan ketersediaan suatu stock itu adalah urusan internal dari barang 
  // itu sendiri dan dengan meletakkanya di dalam class barang kita hanya perlu memanggil 
  // method barang.bisaDijual(diminta) dari mana saja tanpa harus mengulang-ulang 
  // logika pengecekan stock secara manual.

  // === DATA BARANG TRANSAKSI ===
  String namaBarang = "Sepatu Olahraga";
  double hargaAnggota = 90000.0;
  double hargaUmum = 100000.0;
  int jumlahBeli = 4;

  // === KATEGORI BARANG ===
  String kategori = "atk";
  String lokasiRak;

  switch (kategori) {
    case "atk":
      lokasiRak = "Rak 1";
      break;
    case "makanan":
      lokasiRak = "Rak 2";
      break;
    case "minuman":
      lokasiRak = "Rak 3";
      break;
    default:
      lokasiRak = "Rak lain";
  }

  // Variabel bool status anggota
  bool anggota = true;

  // Menentukan harga menggunakan fungsi hitungHarga
  double hargaSatuan = hitungHarga(anggota, hargaAnggota, hargaUmum);
  String statusPembeli = anggota ? "Anggota" : "Umum";

  // Menghitung total menggunakan pemanggilan fungsi hitungTotal
  double total = hitungTotal(jumlahBeli, hargaSatuan);


  if (total < 0) {
    print("===========================================");
    print("                 Damn mart                 ");
    print("===========================================");
    print("ERROR: Transaksi ditolak!");
    print("Alasan: Total belanja bernilai negatif (Rp${formatRupiah.format(total)}).");
    print("Hal ini terjadi karena ada kesalahan input (misal jumlah beli negatif).");
    print("===========================================");
    return; 
  }

  double persenDiskon;
  double nominalDiskon;
  double hargaAkhir;

  if (anggota && total > 500000) {
    persenDiskon = 15;
  } else if (total > 200000) {
    persenDiskon = 10;
  } else if (total > 100000) {
    persenDiskon = 5;
  } else {
    persenDiskon = 0;
  }

  nominalDiskon = total * (persenDiskon / 100);
  
  // Menghitung harga akhir menggunakan pemanggilan fungsi komposisi
  hargaAkhir = bayarAkhir(jumlahBeli, hargaSatuan, persenDiskon);

  // Menampilkan hasil
  print("===========================================");
  print("                 Damn mart                 ");
  print("===========================================");
  print("Nama Barang   : $namaBarang");
  print("Kategori      : $kategori  →  $lokasiRak");
  print("Status Pembeli: $statusPembeli");
  print("Harga Satuan  : Rp${formatRupiah.format(hargaSatuan)}");
  print("Jumlah Beli   : $jumlahBeli pcs");
  print("-------------------------------------------");
  print("Total Belanja : Rp${formatRupiah.format(total)}");

  if (persenDiskon > 0) {
    print("Diskon        : $persenDiskon% (Rp${formatRupiah.format(nominalDiskon)})");
  } else {
    print("Diskon        : Tidak ada diskon");
  }

  print("-------------------------------------------");
  print("HARGA AKHIR   : Rp${formatRupiah.format(hargaAkhir)}");
  print("===========================================\n");

  int stokBuku = 3;
  print("---Penjualan Buku Tulis ---");
  while (stokBuku > 0) {
    stokBuku--; // Terjual 1, stok berkurang
    print("Terjual 1, sisa stok: $stokBuku");
  }

  // Memanggil fungsi asinkron di akhir hari
  await muatLaporan();
}

// JAWABAN :
// Bila aturan potongan koperasi diubah (misal persen diskon berubah atau rumus baru),
// cukup ubah baris di dalam fungsi hitungHargaAkhir di satu tempat ini saja.
// Semua bagian program yang memanggil fungsi ini akan otomatis mengikuti perubahan,
// tanpa perlu mencari dan mengubah kode satu per satu di seluruh program.

// Host 1 JAWABAN - Mengapa memindahkan keputusan ini ke fungsi mengurangi risiko salah?
// Logika pemilihan harga (anggota/umum) hanya ditulis di SATU tempat (fungsi ini).
// Jika programmer lupa menulis kondisi `if (anggota)` di suatu transaksi,
// atau menulisnya tidak konsisten, maka harga yang diberikan bisa salah.
// Dengan fungsi, cukup panggil hitungHarga() dan hasilnya selalu benar dan seragam.
