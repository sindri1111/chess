


void boardAlg(int counter, int row) {
  if (counter == 7 && row < 1) {
    counter--;
  } else if (counter == 14 && row < 2) {
    counter--;
  } else if (counter == 21 && row < 3) {
    counter--;
  } else if (counter == 28 && row < 4) {
    counter--;
  } else if (counter == 35 && row < 5) {
    counter--;
  } else if (counter == 42 && row < 6) {
    counter--;
  } else if (counter == 49 && row < 7) {
    counter--;
  } else if (counter == 56 && row < 8) {
    counter--;
  }
}