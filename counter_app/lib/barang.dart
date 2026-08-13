import 'package:intl/intl.dart';

class Barang {
  String nama;
  double harga;
  int _stok; // Privat: hanya bisa diubah lewat method yang sah

  // Konstruktor
  Barang(this.nama, this.harga, this._stok);

  // === JAWABAN (Enkapsulasi) ===
  // Bagaimana enkapsulasi mencegah stok diubah sembarangan?
  // Dengan menjadikan _stok privat, tidak ada kode di luar kelas ini yang bisa langsung
  // menulis atau mengubah nilainya (misal: barang._stok = 999 akan error).
  // Satu-satunya cara mengubah stok adalah lewat method jual() yang sudah memiliki
  // pengecekan kecukupan stok di dalamnya. Dengan cara ini, angka stok dijamin
  // hanya berubah lewat proses penjualan yang sah dan terkendalikan.

  // === JAWABAN: Mengapa melindungi _stok penting bagi integritas data koperasi? ===
  // Karena stok adalah data keuangan nyata yang mewakili aset fisik barang di gudang.
  // Jika _stok bisa diubah sembarangan dari mana saja, laporan total nilai stok akan kacau 
  // dan tidak mencerminkan kondisi di kenyataan. Pengurus koperasi bisa saja malah salah  
  // mengambil keputusan contoh: si pengurus membeli stok baru padahal di gudang sebenarnya  
  // masih penuh. Dengan melindunginya, data stok hanya bisa berubah melalui transaksi jual 
  // yang tercatat dan sah, sehingga data koperasi tetap akurat.

  // Getter: agar kode luar bisa MEMBACA stok, tapi tidak bisa MENGUBAH langsung
  int get stok => _stok;

  // Method jual: mengurangi stok hanya bila mencukupi (enkapsulasi)
  bool jual(int n) {
    if (_stok >= n) {
      _stok -= n;
      return true; // Berhasil dijual
    } else {
      print("Stok $nama tidak mencukupi! (Sisa: $_stok, Diminta: $n)");
      return false; // Gagal dijual
    }
  }

  // Method tampilkan
  void tampilkan() {
    final formatRupiah = NumberFormat('#,##0', 'id_ID');
    print("-------------------------");
    print("Nama Barang : $nama");
    print("Harga       : Rp${formatRupiah.format(harga)}");
    print("Stok        : $_stok");
    print("-------------------------");
  }

  // Method nilaiStok
  double nilaiStok() {
    return harga * _stok;
  }

  // Method bisaDijual 
  bool bisaDijual(int diminta) {
    return _stok >= diminta;
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

class BarangPromo extends Barang {
  double diskon; 

  BarangPromo(String nama, double harga, int stok, this.diskon)
      : super(nama, harga, stok);

  double hargaPromo() {
    return harga - (harga * diskon / 100);
  }

  // Override tampilkan() agar menampilkan label PROMO & harga coret
  @override
  void tampilkan() {
    final formatRupiah = NumberFormat('#,##0', 'id_ID');
    print("=========================");
    print("*** PROMO ***");
    print("Nama Barang : $nama");
    print("Harga Normal: Rp${formatRupiah.format(harga)} (coret)");
    print("Diskon      : ${diskon.toInt()}%");
    print("Harga Promo : Rp${formatRupiah.format(hargaPromo())}");
    print("Stok        : $stok");
    print("=========================");
  }

  // === JAWABAN: Apa manfaat override di sini? ===
  // Kita bisa membuat barang promo tampil lebih lengkap tanpa harus mengacak-acak 
  // atau mengubah kode aslinya. Jadi, dengan override ini, setiap jenis barang (baik 
  // barang biasa maupun barang promo) bebas menentukan cara tampilnya masing-masing 
  // secara otomatis sesuai kebutuhannya.
}

class BarangGrosir extends Barang {
  int minimalBeli;

  BarangGrosir(String nama, double harga, int stok, this.minimalBeli)
      : super(nama, harga, stok);

  // Method khusus grosir
  bool cekGrosir(int jumlahBeli) {
    return jumlahBeli >= minimalBeli;
  }
}

// === JAWABAN (Tantangan Level 2 - Pewarisan) ===
// Kapan pewarisan (inheritance) tepat digunakan?
// Tepat ketika ada hubungan logika "ADALAH SEBUAH" (IS-A relationship). 
// Contoh: BarangGrosir "adalah sebuah" Barang. Ia butuh semua sifat dasar barang 
// (nama, harga, stok), tapi punya tambahan aturan khusus (minimalBeli).
//
// Kapan pewarisan TIDAK tepat?
// Tidak tepat jika hanya ingin meminjam fungsi dari kelas lain tanpa ada 
// hubungan hierarki yang logis, atau jika perbedaannya sangat sepele sehingga 
// cukup diselesaikan dengan menambahkan satu atribut saja (misal atribut boolean 
// isGrosir di dalam kelas Barang biasa).

