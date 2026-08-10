
import 'package:intl/intl.dart';

class Barang {
  String nama;
  double harga;
  int stok;

  // Konstruktor
  Barang(this.nama, this.harga, this.stok);

  // Method tampilkan
  void tampilkan() {
    final formatRupiah = NumberFormat('#,##0', 'id_ID');
    print("-------------------------");
    print("Nama Barang : $nama");
    print("Harga       : Rp${formatRupiah.format(harga)}");
    print("Stok        : $stok");
    print("-------------------------");
  }

  // Method nilaiStok
  double nilaiStok() {
    return harga * stok;
  }

  // Method bisaDijual 
  bool bisaDijual(int diminta) {
    return stok >= diminta;
  }
}

class Pembeli {
  String nama;
  bool statusAnggota; 

  Pembeli(this.nama, this.statusAnggota);
}

// === JAWABAN (Tantangan Level 3) ===
// Relasi apa yang wajar antara Pembeli & Barang dalam satu transaksi?
// Dalam sebuah skenario transaksi, relasi yang paling sering kita temui antara pembeli dan 
// barang adalah One-to-Many. Alasannya: satu orang pembeli bisa saja membeli Banyak Barang 
// yang berbeda-beda dalam satu struk pembelanjaan sekaligus. Namun, semua kumpulan barang 
// yang ada di dalam struk tersebut hanya milik dari satu pembeli itu saja.

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

void main() {
  final formatRupiah = NumberFormat('#,##0', 'id_ID');
  // Buat semua objek Barang sekaligus dalam List
  List<Barang> daftarBarang = [
    Barang("Buku Tulis", 3000.0, 10),
    Barang("Pulpen", 2500.0, 20),
    Barang("Roti", 5000.0, 3),
    Barang("Penghapus", 1500.0, 15),
  ];

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