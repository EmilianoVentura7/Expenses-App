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
 