
import 'package:intl/intl.dart';


void main() {
  final formatRupiah = NumberFormat('#,##0', 'id_ID');


  List<double> listTotal = [50000, 150000, 250000, 600000];
  bool anggota = true;

  print("=================================================================");
  print("         PERBANDINGAN URUTAN LOGIKA IF POTONGAN DISKON          ");
  print("=================================================================");
  print("\n[!] Status pembeli: ${anggota ? 'Anggota' : 'Umum'}\n");

  for (double total in listTotal) {

    double diskonBenar;
    if (anggota && total > 500000) {
      diskonBenar = 15;
    } else if (total > 200000) {
      diskonBenar = 10;
    } else if (total > 100000) {
      diskonBenar = 5;
    } else {
      diskonBenar = 0;
    }

//jika dibalik
    double diskonSalah;
    if (total > 100000) {
      diskonSalah = 5;                    
    } else if (total > 200000) {
      diskonSalah = 10;                 
    } else if (anggota && total > 500000) {
      diskonSalah = 15;                   
    } else {
      diskonSalah = 0;
    }


    String status = (diskonBenar == diskonSalah) ? "✓ BENAR" : "✗ SALAH";

    print("Total: Rp${formatRupiah.format(total)}");
    print("  Diskon seharusnya : $diskonBenar%");
    print("  Diskon bila dibalik: $diskonSalah%  → $status");
    print("  -------------------------------------------------------");
  }

  print("\n=================================================================");
  print("  KESIMPULAN:                                                    ");
  print("=================================================================");
  print("  Bila kondisi if dibalik (kecil dulu), kondisi > 100.000");
  print("  akan SELALU terpenuhi lebih dulu untuk semua total > 100rb.");
  print("  Akibatnya, blok else-if berikutnya TIDAK PERNAH dieksekusi,");
  print("  meskipun nilai totalnya memenuhi syarat diskon yang lebih besar.");
}
