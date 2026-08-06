
import 'package:intl/intl.dart';

void main() {
  final formatRupiah = NumberFormat('#,##0', 'id_ID');


  List<String> daftarNamaBarang = ["Buku Tulis", "Pulpen", "Penghapus", "Roti"];
  List<double> daftarHargaBarang = [3000.0, 2500.0, 1500.0, 5000.0];

  print("=== DAFTAR BARANG ===");
  for (int i = 0; i < daftarNamaBarang.length; i++) {
    print("${i + 1}. ${daftarNamaBarang[i]} - Rp. ${formatRupiah.format(daftarHargaBarang[i])}");
  }
  print("\n"); 

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

  // Menentukan harga berdasarkan status anggota (if/else)
  double hargaSatuan;
  String statusPembeli;

  if (anggota) {
    hargaSatuan = hargaAnggota;
    statusPembeli = "Anggota";
  } else {
    hargaSatuan = hargaUmum;
    statusPembeli = "Umum";
  }

  // Menghitung total sebelum diskon
  double total = jumlahBeli * hargaSatuan;


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
  hargaAkhir = total - nominalDiskon;

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

  // === TANTANGAN LEVEL 4: SIMULASI PENJUALAN DENGAN WHILE ===
  // RPL-12.2-303: Justifikasi dan Unggah
  // Jawaban:
  // Bahaya apa yang muncul bila kondisi berhenti pada while keliru?
  // Jika keliru (misal `while (stokBuku >= 0)` atau lupa menambahkan `stokBuku--`),
  // maka program bisa mengalami Infinite Loop (berputar tanpa henti menyebabkan crash/hang),
  // atau terus menjual barang meskipun stok sudah habis sehingga stok menjadi negatif (minus).
  // 
  // Bagaimana cara untuk memastikan koperasi tidak menjual melebihi stok?
  // 1. Selalu gunakan operator perbandingan yang ketat, misalnya `while (stokBuku > 0)`.
  // 2. Selalu pastikan ada variabel yang diubah nilainya (seperti `stokBuku--`) di dalam loop 
  //    agar kondisi berhenti suatu saat akan terpenuhi.
  int stokBuku = 3;
  print("---Penjualan Buku Tulis ---");
  while (stokBuku > 0) {
    stokBuku--; // Terjual 1, stok berkurang
    print("Terjual 1, sisa stok: $stokBuku");
  }
}
