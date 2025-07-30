class HomeEntity {
  final UserProfileEntity userProfile;
  final ExpenseSummaryEntity expenseSummary;
  final List<ExpenseEntity> recentExpenses;

  HomeEntity({
    required this.userProfile,
    required this.expenseSummary,
    required this.recentExpenses,
  });
}

class UserProfileEntity {
  final int id;
  final String name;
  final String email;

  UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}

class ExpenseSummaryEntity {
  final double totalIncome;
  final double totalExpenses;
  final double balance;
  final List<ExpenseCategoryEntity> expensesByCategory;

  ExpenseSummaryEntity({
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
    required this.expensesByCategory,
  });
}

class ExpenseCategoryEntity {
  final String name;
  final String color;
  final double total;
  final int count;

  ExpenseCategoryEntity({
    required this.name,
    required this.color,
    required this.total,
    required this.count,
  });
}

class ExpenseEntity {
  final int id;
  final String description;
  final double amount;
  final String type;
  final String date;
  final int categoryId;
  final CategoryEntity category;

  ExpenseEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.categoryId,
    required this.category,
  });
}

class CategoryEntity {
  final String name;
  final String color;

  CategoryEntity({required this.name, required this.color});
}
