void main() {
  // 1. IF - ELSE
  var usia = 5;

  print('1. IF - ELSE');

  if (usia < 12) {
    print('Anak-anak');
  } else if (usia >= 12 && usia <= 17) {
    print('Remaja');
  } else if (usia >= 18 && usia <= 64) {
    print('Dewasa');
  } else {
    print('Lansia');
  }

  // 2. FOR
  print('\n2. FOR');

  for (int angka = 1; angka <= 50; angka++) {
    print(angka);
  }

  // 3. WHILE
  print('\n3. WHILE');

  var angka = 3;

  while (angka <= 15) {
    print(angka);
    angka += 3;
  }

  // 4. SWITCH - CASE
  print('\n4. SWITCH - CASE');

  var bulan = 10;

  switch (bulan) {
    case 1:
      print('Januari: 31 hari');
      break;
    case 2:
      print('Februari: 28 hari');
      break;
    case 3:
      print('Maret: 31 hari');
      break;
    case 4:
      print('April: 30 hari');
      break;
    case 5:
      print('Mei: 31 hari');
      break;
    case 6:
      print('Juni: 30 hari');
      break;
    case 7:
      print('Juli: 31 hari');
      break;
    case 8:
      print('Agustus: 31 hari');
      break;
    case 9:
      print('September: 30 hari');
      break;
    case 10:
      print('Oktober: 31 hari');
      break;
    case 11:
      print('November: 30 hari');
      break;
    case 12:
      print('Desember: 31 hari');
      break;
    default:
      print('Nomor bulan tidak valid');
  }
}