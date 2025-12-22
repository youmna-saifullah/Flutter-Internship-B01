void main() {
print('=== Dart Basics ===\n');
// 1. Demonstrate var, final, const declarations
  print('1. var, final, const declarations:');

// Type inferred as String if you give it like var age=34 it as variable type integer.
  var name = 'Ali'; 
//const is fixed at compile-time and is deeply immutable,
// while final is fixed at run-time and only prevents reassignment.
  final age = 25; 
  const pi = 3.14159; 

  print('   var name = $name');
  print('   final age = $age');
  print('   const pi = $pi');
// Allowed - var can be reassigned
name = 'Ahmed'; 
// age = 26; // ERROR: final cannot be reassigned
// pi = 3.14; // ERROR: const cannot be reassigned
print('   Updated name = $name\n');

// Runtime vs Compile-time difference
final currentTime = DateTime.now(); // Allowed - runtime value
// const currentTime2 = DateTime.now(); // ERROR: Requires compile-time constant

// 2. Show int, double, String, bool data types
  print('2. Data Types:');
  
  int wholeNumber = 42;
  double decimalNumber = 3.14;
  String text = 'Hello Dart!';
  bool isTrue = true;
  
  print('   int: $wholeNumber');
  print('   double: $decimalNumber');
  print('   String: "$text"');
  print('   bool: $isTrue');
  
  // Type checking
  print('   Type of wholeNumber: ${wholeNumber.runtimeType}');
  print('   Type of text: ${text.runtimeType}\n');

  // 3. Implement if-else conditions
  print('3. If-Else Conditions:');
  
  int score = 85;
  
  if (score >= 90) {
    print('   Grade: A');
  } else if (score >= 80) {
    print('   Grade: B (Score: $score)');
  } else if (score >= 70) {
    print('   Grade: C');
  } else {
    print('   Grade: F');
  }

  // Ternary operator
  String result = score >= 60 ? 'Pass' : 'Fail';
  print('   Result: $result\n');


  // 4. Create for, while loops examples
  print('4. Loops:');
  
  print('   For loop:');
  for (int i = 1; i <= 3; i++) {
    print('     Iteration $i');
  }
  
  print('\n   While loop:');
  int counter = 1;
  while (counter <= 3) {
    print('     Counter: $counter');
    counter++;
  }
  
  print('\n   For-in loop with List:');
  List<int> numbers = [10, 20, 30];
  for (var number in numbers) {
    print('     Number: $number');
  }
  // 5. Write function int sum(int a, int b)
  print('\n5. Sum Function:');
  int sumResult = sum(15, 25);
  print('   sum(15, 25) = $sumResult');
  
  // 6. Create factorial function using recursion
  print('\n6. Factorial Function (Recursion):');
  int n = 5;
  int factorialResult = factorial(n);
  print('   factorial($n) = $factorialResult');
  
  print('   Factorial breakdown:');
  for (int i = 1; i <= n; i++) {
    print('     factorial($i) = ${factorial(i)}');
  }
// 7. Implement isPrime() function
  print('\n7. Prime Number Check:');
  
  List<int> testNumbers = [2, 3, 4, 7, 10, 13, 17, 20, 23];
  
  for (var number in testNumbers) {
    bool primeCheck = isPrime(number);
    print('   $number is prime? $primeCheck');
  }
  
  print('\n=== End Dart _Basics ===');
}

factorial(int i) {
   if (i <= 1) {
    return 1;
  }
  return i * factorial(i - 1);
}

int sum(int i, int j) {
  return i+j;
}

bool isPrime(int number) {
  if (number <= 1) return false;
  if (number == 2) return true;
  if (number % 2 == 0) return false;
  
  for (int i = 3; i * i <= number; i += 2) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}