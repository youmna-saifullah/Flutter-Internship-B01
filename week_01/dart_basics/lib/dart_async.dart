// dart_async.dart 
import 'dart:async';
import 'dart:math';

// ====================  Future Functions Simulating API Calls ====================

// 1. Future function simulating API call with delay
Future<String> fetchUserData(String userId, {int delaySeconds = 2}) async {
  print('📡 [START] Fetching user data for ID: $userId...');
  
  // Simulate network delay
  await Future.delayed(Duration(seconds: delaySeconds));
  
  // Simulate API response
  final userDatabase = {
    'user001': '{"id": "user001", "name": "Ali Ahmed", "email": "ali@example.com", "age": 25}',
    'user002': '{"id": "user002", "name": "Fatima Khan", "email": "fatima@example.com", "age": 30}',
    'user003': '{"id": "user003", "name": "Usman Malik", "email": "usman@example.com", "age": 28}',
    'user004': '{"id": "user004", "name": "Sara Zafar", "email": "sara@example.com", "age": 22}',
  };
  
  if (!userDatabase.containsKey(userId)) {
    throw Exception('❌ User with ID $userId not found');
  }
  
  print('✅ [SUCCESS] Fetched user data for ID: $userId');
  return userDatabase[userId]!;
}

// Additional Future functions for parallel execution
Future<String> fetchUserPosts(String userId, {int delaySeconds = 3}) async {
  print('📡 [START] Fetching posts for user: $userId...');
  
  await Future.delayed(Duration(seconds: delaySeconds));
  
  final postsDatabase = {
    'user001': '{"userId": "user001", "posts": ["Post 1", "Post 2", "Post 3"]}',
    'user002': '{"userId": "user002", "posts": ["Photo post", "Update post"]}',
    'user003': '{"userId": "user003", "posts": ["Blog post", "News update"]}',
  };
  
  if (!postsDatabase.containsKey(userId)) {
    return '{"userId": "$userId", "posts": []}';
  }
  
  print('✅ [SUCCESS] Fetched posts for user: $userId');
  return postsDatabase[userId]!;
}

Future<String> fetchUserFriends(String userId, {int delaySeconds = 4}) async {
  print('📡 [START] Fetching friends for user: $userId...');
  
  await Future.delayed(Duration(seconds: delaySeconds));
  
  // Simulate random network error
  final random = Random();
  if (random.nextDouble() < 0.3) { 
    throw Exception('🌐 Network error while fetching friends for $userId');
  }
  
  final friendsDatabase = {
    'user001': '{"userId": "user001", "friends": ["user002", "user003", "user004"]}',
    'user002': '{"userId": "user002", "friends": ["user001", "user003"]}',
    'user003': '{"userId": "user003", "friends": ["user001", "user004"]}',
  };
  
  if (!friendsDatabase.containsKey(userId)) {
    return '{"userId": "$userId", "friends": []}';
  }
  
  print('✅ [SUCCESS] Fetched friends for user: $userId');
  return friendsDatabase[userId]!;
}

Future<String> fetchUserSettings(String userId, {int delaySeconds = 1}) async {
  print('📡 [START] Fetching settings for user: $userId...');
  
  await Future.delayed(Duration(seconds: delaySeconds));
  
  print('✅ [SUCCESS] Fetched settings for user: $userId');
  return '{"userId": "$userId", "theme": "dark", "notifications": true, "language": "en"}';
}

// Function to parse and display user data
Map<String, dynamic> parseUserData(String jsonString) {
  // Simulate JSON parsing
  final json = {
    'id': jsonString.contains('"id":') ? 'user001' : 'unknown',
    'name': jsonString.contains('Ali') ? 'Ali Ahmed' : 
            jsonString.contains('Fatima') ? 'Fatima Khan' :
            jsonString.contains('Usman') ? 'Usman Malik' : 
            jsonString.contains('Sara') ? 'Sara Zafar' : 'Unknown',
    'email': jsonString.contains('@') ? 'email@gmail.com' : 'unknown@gmail.com',
    'age': jsonString.contains('age') ? 25 : 0,
  };
  
  return json;
}

// ==================== 6-10. Stream Implementation ====================

// 6. Simple stream that emits numbers
Stream<int> counterStream({int maxCount = 10, int delayMs = 500}) async* {
  print('🚀 Starting counter stream...');
  
  for (int i = 1; i <= maxCount; i++) {
    // Simulate delay between emissions
    await Future.delayed(Duration(milliseconds: delayMs));
    
    // Simulate random error
    if (i == 5) {
      print('⚠️ Simulating error at count 5');
      yield* Stream.error('Stream error: Count reached 5!');
    }
    
    yield i; // Emit value
  }
  
  print('🏁 Counter stream completed');
}

// 9. Manual StreamController implementation
class DataBroadcaster {
  final StreamController<String> _controller = StreamController<String>.broadcast();
  Timer? _timer;
  int _count = 0;
  
  Stream<String> get stream => _controller.stream;
  
  void startBroadcasting() {
    print('📢 Starting data broadcaster...');
    _count = 0;
    
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      _count++;
      
      if (_count > 10) {
        stopBroadcasting();
        return;
      }
      
      final messages = [
        'Live update $_count: Server status normal',
        'Live update $_count: New user registered',
        'Live update $_count: System update in progress',
        'Live update $_count: Database backup completed',
        'Live update $_count: API response received',
      ];
      
      final message = messages[Random().nextInt(messages.length)];
      _controller.sink.add(message);
      
      if (_count == 7) {
        _controller.sink.addError('⚠️ Critical error detected in update $_count!');
      }
    });
  }
  
  void stopBroadcasting() {
    print('🛑 Stopping data broadcaster...');
    _timer?.cancel();
    _controller.sink.close();
  }
  
  void dispose() {
    _controller.close();
  }
}

// ==================== Main Function Testing All Features ====================

Future<void> main() async {
  print('⚡️ Dart Async Programming Demonstration ⚡️\n');
  
  // ========== 2. Using async-await ==========
  print('1. Basic async-await Example:');
  print('-' * 50);
  
  try {
    // 2. Call async function with await
    print('⏳ Waiting for user data...');
    final userData = await fetchUserData('user001');
    final parsedData = parseUserData(userData);
    print('👤 User Data: ${parsedData['name']} (${parsedData['email']})');
  } catch (e) {
    print('❌ Error: $e');
  }
  
  // ========== 3. Error Handling with try-catch ==========
  print('\n2. Error Handling Example:');
  print('-' * 50);
  
  try {
    print('⏳ Trying to fetch non-existent user...');
    final nonExistentUser = await fetchUserData('user999');
    print('User data: $nonExistentUser');
  } catch (e) {
    print('❌ Caught error: $e');
  } finally {
    print('✅ Error handling completed');
  }
  
  // ========== 5. Future.wait() for Parallel Execution ==========
  print('\n3. Parallel Execution with Future.wait():');
  print('-' * 50);
  
  final stopwatch = Stopwatch()..start();
  
  try {
    final List<Future<String>> futures = [
      fetchUserData('user002', delaySeconds: 2),
      fetchUserPosts('user002', delaySeconds: 3),
      fetchUserFriends('user002', delaySeconds: 4),
      fetchUserSettings('user002', delaySeconds: 1),
    ];
    
    print('🚀 Starting parallel requests...');
    
    // 5. Execute all futures in parallel
    final results = await Future.wait(futures);
    
    stopwatch.stop();
    print('\n✅ All parallel requests completed in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds % 1000} seconds');
    
    for (int i = 0; i < results.length; i++) {
      print('Result ${i + 1}: ${results[i].substring(0, min(50, results[i].length))}...');
    }
    
  } catch (e) {
    print('❌ Parallel execution error: $e');
  }
  
  // ========== Future.wait with error handling ==========
  print('\n4. Future.wait() with Error Handling:');
  print('-' * 50);
  
  try {
    final futuresWithError = [
      fetchUserData('user003'),
      fetchUserPosts('user003'),
      fetchUserFriends('user003'), // Might throw error
      fetchUserSettings('user003'),
    ];
    
    print('🚀 Starting parallel requests (with possible error)...');
    
    // Using Future.wait with error handling per future
    final results = await Future.wait(
      futuresWithError.map((future) => future.catchError((e) => 'Error: $e'))
    );
    
    print('\n📊 Results (errors handled per future):');
    for (int i = 0; i < results.length; i++) {
      print('  Task ${i + 1}: ${results[i].toString().substring(0, min(60, results[i].toString().length))}');
    }
  } catch (e) {
    print('❌ Unhandled error: $e');
  }
  
  // ========== 7-8. Stream Listening with await for ==========
  print('\n5. Stream Example - Counter Stream:');
  print('-' * 50);
  
  // 7. Listen to stream with await for
  try {
    print('🎯 Listening to counter stream...');
    
    await for (final count in counterStream(maxCount: 8, delayMs: 300)) {
      print('   📊 Received count: $count');
    }
    
    print('✅ Stream listening completed');
  } catch (e) {
    // 8. Handle stream errors
    print('❌ Stream error caught: $e');
  }
  
  // ========== 9. Manual StreamController ==========
  print('\n6. Manual StreamController Example:');
  print('-' * 50);
  
  final broadcaster = DataBroadcaster();
  
  // Listen to the stream
  final subscription = broadcaster.stream.listen(
    (data) {
      print('   📡 Live update: $data');
    },
    onError: (error) {
      print('   ⚠️ Stream error: $error');
    },
    onDone: () {
      print('   ✅ Stream completed');
    },
  );
  
  // Start broadcasting
  broadcaster.startBroadcasting();
  
  // Wait for a few seconds
  await Future.delayed(Duration(seconds: 3));
  
  // Cancel subscription and stop broadcasting
  subscription.cancel();
  broadcaster.stopBroadcasting();
  broadcaster.dispose();
  
  // ========== 10. Stream Transformations ==========
  print('\n7. Stream Transformations:');
  print('-' * 50);
  
  // Create a stream
  final numberStream = Stream.periodic(
    Duration(milliseconds: 400),
    (count) => count + 1,
  ).take(10);
  
  // Apply transformations
  print('Original stream (1-10):');
  await for (final num in numberStream) {
    print('   Number: $num');
  }
  
  // Create new stream with transformations
  final transformedStream = Stream.periodic(
    Duration(milliseconds: 300),
    (count) => count + 1,
  ).take(10)
   .where((number) => number % 2 == 0) // Filter even numbers
   .map((number) => number * 2)        // Double each number
   .asyncMap((number) async {          // Simulate async operation
      await Future.delayed(Duration(milliseconds: 100));
      return number;
    });
  
  print('\nTransformed stream (even numbers doubled):');
  await for (final num in transformedStream) {
    print('   Transformed: $num');
  }
  
  // ========== Real-time Data Simulation ==========
  print('\n8. Real-time Data Simulation:');
  print('-' * 50);
  
  final stockStream = Stream.periodic(
    Duration(milliseconds: 500),
    (count) {
      final basePrice = 100.0;
      final randomChange = (Random().nextDouble() - 0.5) * 10; // -5 to +5
      return basePrice + randomChange + count * 0.5; // Slight upward trend
    },
  ).take(15);
  
  double previousPrice = 100.0;
  int updateCount = 0;
  
  await for (final price in stockStream) {
    updateCount++;
    final change = price - previousPrice;
    final changePercent = (change / previousPrice * 100);
    final changeSymbol = change >= 0 ? '📈' : '📉';
    
    print('   Stock Update #$updateCount: \$${price.toStringAsFixed(2)} '
          '$changeSymbol ${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)} '
          '(${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%)');
    
    previousPrice = price;
  }
  
  // ========== Advanced: Combine Futures and Streams ==========
  print('\n9. Combining Futures and Streams:');
  print('-' * 50);
  
  // Create a stream from a future
  final futureToStream = Stream.fromFuture(
    Future.delayed(Duration(seconds: 1), () => 'Future completed!')
  );
  
  // Combine multiple streams
  final stream1 = Stream.periodic(Duration(milliseconds: 400), (i) => 'A$i').take(3);
  final stream2 = Stream.periodic(Duration(milliseconds: 600), (i) => 'B$i').take(3);
  
  print('Combined stream output:');
  var StreamGroup;
  await for (final value in StreamGroup.merge([stream1, stream2])) {
    print('   Received: $value');
  }
  
  // ========== Cleanup and Summary ==========
  print('\n' + '=' * 50);
  print('🎉 Async Programming Demo Completed!');
  print('Concepts Covered:');
  print('  ✅ Future and async-await');
  print('  ✅ Error handling with try-catch');
  print('  ✅ Parallel execution with Future.wait()');
  print('  ✅ Stream creation and listening');
  print('  ✅ Stream transformations');
  print('  ✅ StreamController for manual control');
  print('  ✅ Real-time data simulation');
  print('=' * 50);
}

// ==================== Additional Helper Functions ====================

// Simulate API with retry logic
Future<String> fetchWithRetry(String userId, {int maxRetries = 3}) async {
  int attempts = 0;
  
  while (attempts < maxRetries) {
    try {
      attempts++;
      print('Attempt $attempts/$maxRetries for user $userId');
      return await fetchUserData(userId, delaySeconds: 1);
    } catch (e) {
      if (attempts == maxRetries) {
        rethrow;
      }
      print('⚠️ Retrying after error: $e');
      await Future.delayed(Duration(seconds: 1));
    }
  }
  
  throw Exception('Failed after $maxRetries attempts');
}

// Timeout example
Future<String> fetchWithTimeout(String userId) async {
  try {
    return await fetchUserData(userId, delaySeconds: 3)
        .timeout(Duration(seconds: 2), onTimeout: () {
          return '{"error": "Request timeout for $userId"}';
        });
  } catch (e) {
    return '{"error": "$e"}';
  }
}