
import 'package:intl/intl.dart';

void main() {
  final formatRupiah = NumberFormat('#,##0', 'id_ID');

  // ============================================================
  // RPL-12.2-204: UJI DAN JUSTIFIKASI — 3 SKENARIO (Tabel C)
  // ============================================================

  // Kategori barang koperasi (switch-case)
  // Switch lebih rapi daripada banyak if karena langsung mencocokkan
  // satu nilai ke beberapa case tetap tanpa mengulang "kategori ==" berkali-kali.
  String kategori = "makanan";
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

  print("===========================================");
  print("                 Damn mart                 ");
  print("===========================================");

  // ─── SKENARIO A: Anggota, total 250.000 ────────────────────
  bool anggotaA   = true;
  double hargaA   = 250000.0;  // harga satuan
  int jumlahA     = 1;
  double totalA   = jumlahA * hargaA;
  double diskonA  = (totalA > 200000) ? 10 : (totalA > 100000) ? 5 : 0;
  double nomDisA  = totalA * (diskonA / 100);
  double akhirA   = totalA - nomDisA;

  print("\n[A] Anggota — Total Rp${formatRupiah.format(totalA)}");
  print("    Harga      : ${anggotaA ? 'Anggota' : 'Umum'}");
  print("    Potongan   : ${diskonA.toInt()}% (Rp${formatRupiah.format(nomDisA)})");
  print("    Harga Akhir: Rp${formatRupiah.format(akhirA)}");
  print("    Kategori   : $kategori → $lokasiRak");

  // ─── SKENARIO B: Umum, total 150.000 ───────────────────────
  bool anggotaB   = false;
  double hargaB   = 150000.0;
  int jumlahB     = 1;
  double totalB   = jumlahB * hargaB;
  double diskonB  = (totalB > 200000) ? 10 : (totalB > 100000) ? 5 : 0;
  double nomDisB  = totalB * (diskonB / 100);
  double akhirB   = totalB - nomDisB;

  print("\n[B] Umum — Total Rp${formatRupiah.format(totalB)}");
  print("    Harga      : ${anggotaB ? 'Anggota' : 'Umum'}");
  print("    Potongan   : ${diskonB.toInt()}% (Rp${formatRupiah.format(nomDisB)})");
  print("    Harga Akhir: Rp${formatRupiah.format(akhirB)}");
  print("    Kategori   : $kategori → $lokasiRak");

  // ─── SKENARIO C: Umum, total 50.000 ────────────────────────
  bool anggotaC   = false;
  double hargaC   = 50000.0;
  int jumlahC     = 1;
  double totalC   = jumlahC * hargaC;
  double diskonC  = (totalC > 200000) ? 10 : (totalC > 100000) ? 5 : 0;
  double nomDisC  = totalC * (diskonC / 100);
  double akhirC   = totalC - nomDisC;

  print("\n[C] Umum — Total Rp${formatRupiah.format(totalC)}");
  print("    Harga      : ${anggotaC ? 'Anggota' : 'Umum'}");
  print("    Potongan   : ${diskonC.toInt()}% (tidak ada diskon)");
  print("    Harga Akhir: Rp${formatRupiah.format(akhirC)}");
  print("    Kategori   : $kategori → $lokasiRak");

  // ─── TABEL C RINGKASAN ──────────────────────────────────────
  print("\n===========================================");
  print("           HASIL PENGUJIAN                ");
  print("===========================================");
  print("Ske | Status  | Total      | Diskon | Akhir");
  print("----+---------+------------+--------+-----------");
  print(" A  | Anggota | Rp250.000  |   10%  | Rp${formatRupiah.format(akhirA)}");
  print(" B  | Umum    | Rp150.000  |    5%  | Rp${formatRupiah.format(akhirB)}");
  print(" C  | Umum    | Rp50.000   |    0%  | Rp${formatRupiah.format(akhirC)}");
  print("===========================================");
}
