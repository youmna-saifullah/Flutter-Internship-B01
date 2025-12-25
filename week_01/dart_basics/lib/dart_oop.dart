// dart_oop.dart 
import 'dart:math';

// ==================== 1. User Class with Encapsulation ====================
class User {
  // Private variables (encapsulation)
  String _name;
  String _email;
  int _id;
  DateTime _createdAt;
  
  // Static variable (class-level)
  static int _userCount = 0;
  
  //  Named constructor
  User.withDetails(this._name, this._email) 
      : _id = ++_userCount,
        _createdAt = DateTime.now();
  
  // Default constructor
  User() 
      : _name = 'Anonymous',
        _email = 'anonymous@example.com',
        _id = ++_userCount,
        _createdAt = DateTime.now();
  
  // 3. Getters and setters
  String get name => _name;
  String get email => _email;
  int get id => _id;
  DateTime get createdAt => _createdAt;
  static int get userCount => _userCount;
  
  set name(String newName) {
    if (newName.length >= 2) {
      _name = newName;
    } else {
      print('Error: Name must be at least 6 characters long');
    }
  }
  
  set email(String newEmail) {
    if (newEmail.contains('@')) {
      _email = newEmail;
    } else {
      print('Error: Invalid email format');
    }
  }
  
  // Public method
  void displayInfo() {
    print('User Info:');
    print('  ID: $_id');
    print('  Name: $_name');
    print('  Email: $_email');
    print('  Created: ${_createdAt.toLocal()}');
  }
  
  // 5. Override toString() method
  @override
  String toString() {
    return 'User(id: $_id, name: "$_name", email: "$_email")';
  }
}

// ==================== 4. Admin Class (Inheritance) ====================
class Admin extends User {
  List<String> _permissions;
  String _adminLevel;
  
  Admin(String name, String email, this._adminLevel) 
      : _permissions = ['create', 'update', 'delete'],
        super.withDetails(name, email);
  
  // Additional properties for Admin
  List<String> get permissions => List.from(_permissions);
  String get adminLevel => _adminLevel;
  
  void addPermission(String permission) {
    if (!_permissions.contains(permission)) {
      _permissions.add(permission);
      print('Permission "$permission" added to admin $name');
    }
  }
  
  void removePermission(String permission) {
    if (_permissions.contains(permission)) {
      _permissions.remove(permission);
      print('Permission "$permission" removed from admin $name');
    }
  }
  
  // Method overriding (polymorphism)
  @override
  void displayInfo() {
    print('Admin Info:');
    print('  ID: $id');
    print('  Name: $name');
    print('  Email: $email');
    print('  Admin Level: $_adminLevel');
    print('  Permissions: ${_permissions.join(", ")}');
  }
  
  @override
  String toString() {
    return 'Admin(id: $id, name: "$name", email: "$email", level: "$_adminLevel")';
  }
}

// ====================  Abstract Class and Inheritance ====================
// 6. Create abstract class Animal
abstract class Animal {
  String name;
  int age;
  
  Animal(this.name, this.age);
  
  // 8. Abstract method (must be implemented by subclasses)
  void makeSound();
  
  // Concrete method (can be inherited)
  void sleep() {
    print('$name is sleeping...');
  }
  
  void eat(String food) {
    print('$name is eating $food');
  }
  
  void displayInfo() {
    print('Animal: $name, Age: $age years');
  }
}

// 7. Implement Dog class
class Dog extends Animal {
  String breed;
  
  Dog(String name, int age, this.breed) : super(name, age);
  
  @override
  void makeSound() {
    print('$name says: Woof! Woof!');
  }
  
  void fetch(String item) {
    print('$name is fetching the $item');
  }
  
  @override
  void displayInfo() {
    print('Dog: $name, Breed: $breed, Age: $age');
  }
}

// 7. Implement Cat class
class Cat extends Animal {
  String color;
  
  Cat(String name, int age, this.color) : super(name, age);
  
  @override
  void makeSound() {
    print('$name says: Meow! Meow!');
  }
  
  void climbTree() {
    print('$name is climbing a tree');
  }
  
  @override
  void displayInfo() {
    print('Cat: $name, Color: $color, Age: $age');
  }
}

// ==================== 9. Product Class ====================
class Product {
  String name;
  double price;
  String? description;
  String category;
  int _stock;
  
  Product({
    required this.name,
    required this.price,
    this.description,
    required this.category,
    int stock = 0,
  }) : _stock = stock;
  
  // Getter for stock
  int get stock => _stock;
  
  // Method to check if product is in stock
  bool get isInStock => _stock > 0;
  
  // Method to update stock
  void updateStock(int quantity) {
    if (_stock + quantity >= 0) {
      _stock += quantity;
      print('Stock updated: $name now has $_stock units');
    } else {
      print('Error: Cannot reduce stock below 0');
    }
  }
  
  // Method to apply discount
  double applyDiscount(double percentage) {
    if (percentage > 0 && percentage <= 100) {
      double discountAmount = price * (percentage / 100);
      return price - discountAmount;
    }
    return price;
  }
  
  @override
  String toString() {
    return 'Product: $name (\$${price.toStringAsFixed(2)}) - $category';
  }
}

// ====================  ShoppingCart Class ====================
class ShoppingCart {
  List<Product> _items = [];
  String customerName;
  DateTime _createdAt;
  
  ShoppingCart(this.customerName) : _createdAt = DateTime.now();
  
  // 11. Add product to cart
  void addProduct(Product product, [int quantity = 1]) {
    if (product.isInStock) {
      for (int i = 0; i < quantity; i++) {
        _items.add(product);
      }
      print('Added $quantity x ${product.name} to cart');
    } else {
      print('Cannot add ${product.name} - Out of stock');
    }
  }
  
  // 11. Remove product from cart
  bool removeProduct(Product product) {
    if (_items.contains(product)) {
      _items.remove(product);
      print('Removed ${product.name} from cart');
      return true;
    }
    print('${product.name} not found in cart');
    return false;
  }
  
  // 11. Calculate total price
  double calculateTotal() {
    if (_items.isEmpty) return 0.0;
    
    return _items.fold(0.0, (total, product) => total + product.price);
  }
  
  // Calculate total with discount
  double calculateTotalWithDiscount(double discountPercentage) {
    double total = calculateTotal();
    if (discountPercentage > 0 && discountPercentage <= 100) {
      return total * (1 - discountPercentage / 100);
    }
    return total;
  }
  
  // Get cart items (read-only)
  List<Product> get items => List.from(_items);
  
  // Get item count
  int get itemCount => _items.length;
  
  // Check if cart is empty
  bool get isEmpty => _items.isEmpty;
  
  // Clear cart
  void clearCart() {
    _items.clear();
    print('Cart cleared');
  }
  
  // Display cart contents
  void displayCart() {
    print('\n===== Shopping Cart =====');
    print('Customer: $customerName');
    print('Created: ${_createdAt.toLocal()}');
    print('Items: $itemCount');
    print('-------------------------');
    
    if (_items.isEmpty) {
      print('Cart is empty');
    } else {
      // Group similar products
      Map<Product, int> productCount = {};
      for (var product in _items) {
        productCount[product] = (productCount[product] ?? 0) + 1;
      }
      
      productCount.forEach((product, count) {
        double subtotal = product.price * count;
        print('$count x ${product.name}: \$${product.price.toStringAsFixed(2)} each = \$${subtotal.toStringAsFixed(2)}');
      });
      
      print('-------------------------');
      print('Subtotal: \$${calculateTotal().toStringAsFixed(2)}');
      print('Total: \$${calculateTotal().toStringAsFixed(2)}');
    }
    print('=========================\n');
  }
}

void main() {
  print('=== Dart OOP Concepts Demonstration ===\n');
  
  // ========== Testing User Class ==========
  print('1. User Class (Encapsulation):');
  print('-' * 40);
  
  // Create users using different constructors
  User user1 = User.withDetails('Ali Ahmed', 'ali.ahmed@email.com');
  User user2 = User(); // Default constructor
  
  // Using getters
  print('User 1: ${user1.name} - ${user1.email}');
  print('User 2: ${user2.name} - ${user2.email}');
  
  // Using setters with validation
  user1.name = 'Ali'; // Valid
  user1.name = 'A'; // Invalid - will show error
  
  user1.email = 'new.ali@email.com'; // Valid
  user1.email = 'invalid-email'; // Invalid - will show error
  
  user1.displayInfo();
  print('Total users created: ${User.userCount}\n');
  
  // ========== Testing Admin Class (Inheritance) ==========
  print('2. Admin Class (Inheritance & Polymorphism):');
  print('-' * 40);
  
  Admin admin1 = Admin('Admin User', 'admin@company.com', 'Super Admin');
  print(admin1.toString());
  admin1.displayInfo(); // Overridden method
  
  // Admin-specific methods
  admin1.addPermission('manage_users');
  admin1.removePermission('delete');
  print('Admin permissions: ${admin1.permissions}\n');
  
  // ========== Testing Animal Hierarchy (Abstraction & Polymorphism) ==========
  print('3. Animal Hierarchy (Abstraction & Polymorphism):');
  print('-' * 40);
  
  // Cannot instantiate abstract class
  // Animal animal = Animal('Generic', 5); // Error!
  
  // But can create instances of concrete subclasses
  Dog dog = Dog('Buddy', 3, 'Golden Retriever');
  Cat cat = Cat('Whiskers', 2, 'Tabby');
  
  // Using polymorphism - treating different objects as Animals
  List<Animal> animals = [dog, cat];
  
  for (var animal in animals) {
    animal.displayInfo();
    animal.makeSound(); // Each implements differently
    animal.eat('food');
    animal.sleep();
    
    // Type checking and specific methods
    if (animal is Dog) {
      animal.fetch('ball');
    } else if (animal is Cat) {
      animal.climbTree();
    }
    print('');
  }
  
  // ========== Testing Product Class ==========
  print('4. Product Class:');
  print('-' * 40);
  
  Product laptop = Product(
    name: 'Dell XPS 15',
    price: 1299.99,
    description: 'High-performance laptop',
    category: 'Electronics',
    stock: 10,
  );
  
  Product book = Product(
    name: 'Dart Programming Guide',
    price: 39.99,
    category: 'Books',
    stock: 5,
  );
  
  Product phone = Product(
    name: 'iPhone 14',
    price: 999.00,
    description: 'Latest smartphone',
    category: 'Electronics',
    stock: 0, // Out of stock
  );
  
  print(laptop);
  print(book);
  print('Is phone in stock? ${phone.isInStock}');
  
  // Apply discount
  double discountedPrice = laptop.applyDiscount(15);
  print('Laptop after 15% discount: \$${discountedPrice.toStringAsFixed(2)}\n');
  
  // ========== Testing ShoppingCart Class ==========
  print('5. ShoppingCart Class:');
  print('-' * 40);
  
  ShoppingCart cart = ShoppingCart('Ali Ahmed');
  
  // Add products to cart
  cart.addProduct(laptop);
  cart.addProduct(book, 2);
  cart.addProduct(phone); // Should fail - out of stock
  
  // Display cart
  cart.displayCart();
  
  // Calculate total
  print('Cart Total: \$${cart.calculateTotal().toStringAsFixed(2)}');
  print('Total with 10% discount: \$${cart.calculateTotalWithDiscount(10).toStringAsFixed(2)}');
  
  // Remove product
  cart.removeProduct(book);
  cart.displayCart();
  
  // Clear cart
  cart.clearCart();
  cart.displayCart();
  
  // ========== Additional Demonstrations ==========
  print('6. Additional OOP Demonstrations:');
  print('-' * 40);
  
  // Factory pattern example
  print('User count: ${User.userCount}');
  
  // Demonstrating runtime polymorphism
  User polymorphicUser = Admin('Poly Admin', 'poly@test.com', 'Manager');
  print('Polymorphic user type: ${polymorphicUser.runtimeType}');
  polymorphicUser.displayInfo(); // Calls Admin's displayInfo
  
  // Using 'is' and 'as' operators
  if (polymorphicUser is Admin) {
    Admin admin = polymorphicUser as Admin;
    print('Cast successful: ${admin.adminLevel}');
  }
  
  print('\n=== End of OOP Demonstration ===');
}

// Bonus: Factory Pattern Implementation
class UserFactory {
  static User createUser(String type, String name, String email) {
    switch (type.toLowerCase()) {
      case 'admin':
        return Admin(name, email, 'Standard');
      case 'premium':
        return _PremiumUser(name, email);
      default:
        return User.withDetails(name, email);
    }
  }
}

// Private class (only accessible within this file)
class _PremiumUser extends User {
  double _discountRate;
  
  _PremiumUser(String name, String email) 
      : _discountRate = 0.1,
        super.withDetails(name, email);
  
  double getDiscountRate() => _discountRate;
}