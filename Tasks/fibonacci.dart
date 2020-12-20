import 'dart:io';

int fibonacciNaive(int n) {
  if (n <= 1) return n;

  return fibonacciNaive(n - 1) + fibonacciNaive(n - 2);
}

int fibonacciFast(int n) {
  List<int> arr = List(n + 1);
  if (n > 1) {
    arr[0] = 0;
    arr[1] = 1;
    for (var i = 2; i <= n; ++i) {
      arr[i] = (arr[i - 1] + arr[i - 2]);
    }
  } else {
    return n % 10;
  }
  return arr[n];
}

void main() {
  print("inter number: ");
  int n = int.parse(stdin.readLineSync());
  print(fibonacciNaive(n));
  print(fibonacciFast(n));
}
