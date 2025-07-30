class HomeModel {
  final UserProfileModel userProfile;
  final ExpenseSummaryModel expenseSummary;
  final List<ExpenseModel> recentExpenses;

  HomeModel({
    required this.userProfile,
    required this.expenseSummary,
    required this.recentExpenses,
  });

  factory HomeModel.fromJson({
    required Map<String, dynamic> profileJson,
    required Map<String, dynamic> summaryJson,
    required dynamic expensesJson,
  }) {
    List<ExpenseModel> expensesList = [];

    if (expensesJson is List) {
      expensesList =
          expensesJson.where((e) => e is Map<String, dynamic>).map((e) {
            return ExpenseModel.fromJson(e);
          }).toList();
    }

    return HomeModel(
      userProfile: UserProfileModel.fromJson(profileJson['user']),
      expenseSummary: ExpenseSummaryModel.fromJson(summaryJson),
      recentExpenses: expensesList,
    );
  }
}

class UserProfileModel {
  final int id;
  final String name;
  final String email;

  UserProfileModel({required this.id, required this.name, required this.email});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class ExpenseSummaryModel {
  final double totalIncome;
  final double totalExpenses;
  final double balance;
  final List<ExpenseCategoryModel> expensesByCategory;

  ExpenseSummaryModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
    required this.expensesByCategory,
  });

  factory ExpenseSummaryModel.fromJson(Map<String, dynamic> json) {
    final raw = json['expensesByCategory'];
    final list = (raw is List) ? raw : <dynamic>[];
    return ExpenseSummaryModel(
      totalIncome: _toDouble(json['totalIncome']),
      totalExpenses: _toDouble(json['totalExpenses']),
      balance: _toDouble(json['balance']),
      expensesByCategory:
          list
              .where((e) => e is Map<String, dynamic>)
              .map((category) => ExpenseCategoryModel.fromJson(category))
              .toList(),
    );
  }
}

class ExpenseCategoryModel {
  final String name;
  final String color;
  final double total;
  final int count;

  ExpenseCategoryModel({
    required this.name,
    required this.color,
    required this.total,
    required this.count,
  });

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseCategoryModel(
      name: json['name'],
      color: json['color'],
      total: _toDouble(json['total']),
      count: json['count'] ?? 0,
    );
  }
}

class ExpenseModel {
  final int id;
  final String description;
  final double amount;
  final String type;
  final String date;
  final int categoryId;
  final CategoryModel category;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.categoryId,
    required this.category,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      amount: _toDouble(json['amount']),
      type: json['type'] ?? 'expense',
      date: json['date'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      category:
          json['Category'] != null
              ? CategoryModel.fromJson(json['Category'])
              : CategoryModel(name: 'Sin categoría', color: '#808080'),
    );
  }
}

class CategoryModel {
  final String name;
  final String color;

  CategoryModel({required this.name, required this.color});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? 'Sin categoría',
      color: json['color'] ?? '#808080',
    );
  }
}

// Utilidad para convertir cualquier valor a double de forma segura

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
