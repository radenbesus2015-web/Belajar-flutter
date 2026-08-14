
import 'package:intl/intl.dart';
import 'barang.dart';

final formatRupiah = NumberFormat('#,##0', 'id_ID');


double hitungHarga(bool anggota, double hAnggota, double hUmum) {
  return anggota ? hAnggota : hUmum;
}

double hitungPotongan(bool anggota, double total) {
  if (anggota && total > 500000) return 15;
  if (total > 200000) return 10;
  if (total > 100000) return 5;
  return 0;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}


void prosesBeli(Barang barang, String inputJumlah) {
  try {
    int jumlah = int.parse(inputJumlah);
    if (jumlah > barang.stok) {
      throw RangeError("Jumlah beli ($jumlah) melebihi sisa stok (${barang.stok})!");
    }
    barang.jual(jumlah);
    print("✓ Transaksi berhasil! Terjual $jumlah ${barang.nama}. Sisa stok: ${barang.stok}");
  } on FormatException {
    print("✗ Input tidak valid! '$inputJumlah' bukan angka. Silakan ulangi.");
  } on RangeError catch (e) {
    print("✗ Kesalahan Stok: ${e.message}");
  } finally {
    print("📋 Transaksi dicatat di log.");
  }
}


Future<void> muatLaporan(List<Barang> daftarBarang) async {
  print("⏳ Menyiapkan laporan akhir hari...");
  await Future.delayed(Duration(seconds: 1)); 

  double totalNilai = 0;
  for (Barang b in daftarBarang) {
    totalNilai += b.nilaiStok();
  }
  print("✅ Laporan siap!");
  print("   Total nilai stok koperasi: Rp${formatRupiah.format(totalNilai)}");
}


Future<void> main() async {


  List<Barang> daftarBarang = [
    Barang("Buku Tulis", 3000.0, 10),
    Barang("Pulpen",     2500.0, 20),
    Barang("Roti",       5000.0,  3),
    Barang("Penghapus",  1500.0, 15),
  ];
  BarangPromo susultra = BarangPromo("Susu Ultra", 8000.0, 50, 20);

  
  print("===========================================");
  print("        SELAMAT DATANG DI BRANTAS MART     ");
  print("===========================================");
  print("\n=== DAFTAR BARANG ===");
  for (Barang b in daftarBarang) {
    b.tampilkan();
  }
  susultra.tampilkan(); 

  print("\n=== PROSES TRANSAKSI ===");
  Barang itemBeli  = daftarBarang[0]; 
  bool   isAnggota = true;
  int    jumlahBeli = 4;

  double hargaAnggota = itemBeli.harga * 0.95;
  double hargaUmum    = itemBeli.harga;
  double hargaPilih   = hitungHarga(isAnggota, hargaAnggota, hargaUmum);
  double total        = jumlahBeli * hargaPilih;
  double persen       = hitungPotongan(isAnggota, total);
  double hargaAkhir   = hitungHargaAkhir(total, persen);

  print("Pembeli  : ${isAnggota ? 'Anggota' : 'Umum'}");
  print("Barang   : ${itemBeli.nama}");
  print("Harga    : Rp${formatRupiah.format(hargaPilih)} / pcs");
  print("Jumlah   : $jumlahBeli pcs");
  print("Subtotal : Rp${formatRupiah.format(total)}");
  print("Diskon   : $persen%");
  print("TOTAL    : Rp${formatRupiah.format(hargaAkhir)}");

  print("");
  prosesBeli(itemBeli, "$jumlahBeli");  
  prosesBeli(itemBeli, "dua");         
  prosesBeli(itemBeli, "999");         


  print("\n===========================================");
  print("         LAPORAN AKHIR HARI                ");
  print("===========================================");
  await muatLaporan(daftarBarang);
  print("===========================================");
}
