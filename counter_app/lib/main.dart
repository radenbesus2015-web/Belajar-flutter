void main() {
  // Deklarasi Variabel Awal
  String namaBarang = "Buku Tulis";
  double hargaAnggota = 3000.0;
  double hargaUmum = 3500.0;
  int jumlahStok = 40;
  bool tersedia = true;

  // Variabel untuk Perhitungan
  int jumlahBeli = 3;
  
  // Menghitung Total Anggota (Operator Perkalian: *)
  double totalAnggota = jumlahBeli * hargaAnggota;
  
  // Menghitung Total Umum
  double totalUmum = jumlahBeli * hargaUmum;
  
  // Menghitung Selisih (Operator Pengurangan: -)
  double selisih = totalUmum - totalAnggota;

  // Menampilkan ke Layar (Sesuai Contoh Hasil)
  print("=== KARTU DATA BARANG ===");
  print("Nama : $namaBarang");
  print("Harga Anggota : Rp$hargaAnggota");
  print("Harga Umum : Rp$hargaUmum");
  print("Stok : $jumlahStok");
  print("Tersedia : $tersedia");
  print("Total (anggota) $jumlahBeli pcs: Rp$totalAnggota");
  print("Selisih vs umum : Rp$selisih");
}

// Jawaban Mengapa Pemilihan Tipe Data Penting:
// Pemilihan tipe data yang tepat sangat penting agar perhitungan nilai uang dan jumlah stok
// bisa dieksekusi secara matematis dan akurat tanpa mengalami error sistem. Jika salah memilih tipe data 
// (misalnya menyimpan harga sebagai teks/String), maka program kasir koperasi tidak akan bisa
// melakukan operasi tambah/kali secara otomatis untuk menentukan total bayar dan kembalian.
