// dart_collections.dart 

void main() {
  print('=== Dart Collections & Student Management System ===\n');

  // 1. Create List of integers and demonstrate add, remove, insert
  print('1. List Operations:');
  List<int> numbers = [10, 20, 30, 40, 50];
  print('   Initial List: $numbers');
  
  numbers.add(60); // Add at the end
  print('   After add(60): $numbers');
  
  numbers.insert(2, 25); // Insert at index 2
  print('   After insert(2, 25): $numbers');
  
  numbers.remove(30); // Remove element 30
  print('   After remove(30): $numbers');
  
  numbers.removeAt(0); // Remove at index 0
  print('   After removeAt(0): $numbers');
  
  numbers.removeWhere((num) => num > 40); // Remove elements > 40
  print('   After removeWhere(>40): $numbers');
  
  // 2. Create Set and show unique elements
  print('\n2. Set Operations (Unique Elements):');
  Set<String> fruits = {'apple', 'banana', 'orange', 'apple', 'banana'};
  print('   Initial Set: $fruits');
  print('   Size: ${fruits.length} (Duplicates auto-removed)');
  
  fruits.add('grape');
  fruits.add('orange'); // Won't add duplicate
  print('   After adding grape & orange: $fruits');
  
  Set<int> numbersSet = {1, 2, 3, 4, 5, 1, 2, 3};
  print('   Number Set: $numbersSet');
  
  // 3. Create Map with key-value pairs
  print('\n3. Map Operations:');
  Map<String, dynamic> student = {
    'name': 'Ali Ahmed',
    'age': 21,
    'grade': 'A',
    'courses': ['Math', 'Physics', 'CS']
  };
  print('   Student Map:');
  student.forEach((key, value) {
    print('     $key: $value');
  });
  
  student['email'] = 'ali@university.edu'; // Add new key
  student['age'] = 22; // Update existing key
  print('   After adding email and updating age:');
  print('     $student');
  
  // 4. Use list.map() to transform data
  print('\n4. Using map() to transform data:');
  List<int> scores = [85, 90, 78, 92, 88];
  List<String> gradeLetters = scores.map((score) {
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    return 'F';
  }).toList();
  
  print('   Scores: $scores');
  print('   Grades: $gradeLetters');
  
  // Square all numbers
  List<int> squaredNumbers = numbers.map((n) => n * n).toList();
  print('   Numbers: $numbers → Squared: $squaredNumbers');
  
  // 5. Use list.where() for filtering
  print('\n5. Using where() for filtering:');
  List<int> evenNumbers = scores.where((score) => score % 2 == 0).toList();
  List<int> highScores = scores.where((score) => score > 85).toList();
  
  print('   All scores: $scores');
  print('   Even scores: $evenNumbers');
  print('   High scores (>85): $highScores');
  
  // 6. Implement list.reduce() for sum
  print('\n6. Using reduce() for aggregation:');
  int totalScore = scores.reduce((value, element) => value + element);
  double averageScore = totalScore / scores.length;
  int maxScore = scores.reduce((a, b) => a > b ? a : b);
  int minScore = scores.reduce((a, b) => a < b ? a : b);
  
  print('   Scores: $scores');
  print('   Total: $totalScore');
  print('   Average: ${averageScore.toStringAsFixed(2)}');
  print('   Maximum: $maxScore');
  print('   Minimum: $minScore');
  
  // 7 & 8. Create List<Map<String, dynamic>> for students and add 5 records
  print('\n7 & 8. Student Management System:');
  List<Map<String, dynamic>> students = [
    {
      'name': 'oumna saifullah',
      'roll': 101,
      'marks': 88,
      'department': 'Computer System Engineering'
    },
    {
      'name': 'Atal',
      'roll': 102,
      'marks': 92,
      'department': 'Mathematics'
    },
    {
      'name': 'Laiba',
      'roll': 103,
      'marks': 75,
      'department': 'Physics'
    },
    {
      'name': 'Manahil',
      'roll': 104,
      'marks': 81,
      'department': 'Zology'
    },
    {
      'name': 'Haris Ahmed',
      'roll': 105,
      'marks': 69,
      'department': 'Bcom'
    },
    {
      'name': 'Gulalai Khan',
      'roll': 106,
      'marks': 95,
      'department': 'English'
    },
    {
      'name': 'Omar Farooq',
      'roll': 107,
      'marks': 72,
      'department': 'Mathematics'
    }
  ];
  
  print('   Total Students: ${students.length}');
  
  // Display all students
  print('\n   All Student Records:');
  printStudentRecords(students);
  
  // 9. Sort by marks descending
  print('\n9. Students Sorted by Marks (Descending):');
  List<Map<String, dynamic>> sortedStudents = List.from(students);
  sortedStudents.sort((a, b) => (b['marks']).compareTo(a['marks']));
  printStudentRecords(sortedStudents);
  
  // 10. Filter students with marks > 75
  print('\n10. Students with Marks > 75:');
  List<Map<String, dynamic>> highAchievers = students.where((student) => student['marks'] > 75).toList();
  printStudentRecords(highAchievers);
  
  // Additional filter: Computer Science students
  print('\n   Computer Science Students:');
  List<Map<String, dynamic>> csStudents = students.where((student) => student['department'] == 'Mathematics').toList();
  printStudentRecords(csStudents);
  
  // 11. Search student by name
  print('\n11. Search Student by Name:');
  String searchName = 'Manahil';
  Map<String, dynamic>? foundStudent = searchStudentByName(students, searchName);
  
  if (foundStudent != null) {
    print('   Found: ${foundStudent['name']} - Roll: ${foundStudent['roll']} - Marks: ${foundStudent['marks']}');
  } else {
    print('   Student "$searchName" not found');
  }
  
  // Search with partial name
  print('\n   Search for names containing "Khan":');
  List<Map<String, dynamic>> khanStudents = searchStudentsByPartialName(students, 'Khan');
  printStudentRecords(khanStudents);
  
  // 12. Print formatted output
  print('\n12. Formatted Student Report:');
  printFormattedReport(students);
  
  // Additional operations using forEach()
  print('\nAdditional Operations using forEach():');
  print('   Student Names:');
  students.forEach((student) {
    print('     - ${student['name']}');
  });
  
  print('\n   Marks Summary:');
  students.forEach((student) {
    String status = student['marks'] >= 80 ? 'Excellent' : 
                    student['marks'] >= 70 ? 'Good' : 'Needs Improvement';
    print('     ${student['name']}: ${student['marks']} ($status)');
  });
  
  print('\n=== End of Collections Demo ===');
}

// Function to print student records
void printStudentRecords(List<Map<String, dynamic>> students) {
  print('   ┌──────────────┬───────┬───────┬──────────────────┐');
  print('   │ Name         │ Roll  │ Marks │ Department       │');
  print('   ├──────────────┼───────┼───────┼──────────────────┤');
  
  students.forEach((student) {
    print('   │ ${student['name'].toString().padRight(12)} '
          '│ ${student['roll'].toString().padLeft(5)} '
          '│ ${student['marks'].toString().padLeft(5)} '
          '│ ${student['department'].toString().padRight(16)} │');
  });
  
  print('   └──────────────┴───────┴───────┴──────────────────┘');
}

// Function to search student by exact name
Map<String, dynamic>? searchStudentByName(List<Map<String, dynamic>> students, String name) {
  return students.firstWhere(
    (student) => student['name'].toString().toLowerCase() == name.toLowerCase(),
    orElse: () => {},
  );
}

// Function to search students by partial name
List<Map<String, dynamic>> searchStudentsByPartialName(List<Map<String, dynamic>> students, String partialName) {
  return students.where((student) => 
    student['name'].toString().toLowerCase().contains(partialName.toLowerCase())
  ).toList();
}

// Function to print formatted report
void printFormattedReport(List<Map<String, dynamic>> students) {
  print('   ╔════════════════════════════════════════════════════════════╗');
  print('   ║                  STUDENT PERFORMANCE REPORT                ║');
  print('   ╠════════════════════════════════════════════════════════════╣');
  
  students.forEach((student) {
    String grade = getGrade(student['marks']);
    String status = getStatus(student['marks']);
    
    print('   ║  Name: ${student['name'].toString().padRight(20)} '
          'Roll: ${student['roll'].toString().padLeft(3)}          ║');
    print('   ║  Marks: ${student['marks'].toString().padRight(3)} '
          'Grade: $grade  Status: $status${' '.padRight(15)}║');
    print('   ║  Department: ${student['department'].toString().padRight(30)}║');
    print('   ║  ${'-'.padRight(55)}║');
  });
  
  // Calculate statistics
  double averageMarks = students.map((s) => s['marks'] as int).reduce((a, b) => a + b) / students.length;
  int topMark = students.map((s) => s['marks'] as int).reduce((a, b) => a > b ? a : b);
  int passCount = students.where((s) => s['marks'] >= 70).length;
  
  print('   ╠════════════════════════════════════════════════════════════╣');
  print('   ║  SUMMARY:                                                 ║');
  print('   ║  • Total Students: ${students.length.toString().padRight(40)}║');
  print('   ║  • Average Marks: ${averageMarks.toStringAsFixed(2).padRight(40)}║');
  print('   ║  • Highest Mark: $topMark${' '.padRight(40)}║');
  print('   ║  • Students Passed: $passCount/${students.length}${' '.padRight(35)}║');
  print('   ╚════════════════════════════════════════════════════════════╝');
}

String getGrade(int marks) {
  if (marks >= 90) return 'A+';
  if (marks >= 85) return 'A';
  if (marks >= 80) return 'A-';
  if (marks >= 75) return 'B+';
  if (marks >= 70) return 'B';
  if (marks >= 65) return 'C+';
  if (marks >= 60) return 'C';
  return 'F';
}

String getStatus(int marks) {
  if (marks >= 80) return 'Excellent';
  if (marks >= 70) return 'Good';
  if (marks >= 60) return 'Satisfactory';
  return 'Needs Improvement';
}