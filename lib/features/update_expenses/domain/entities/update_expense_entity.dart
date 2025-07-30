class UpdateExpenseEntity {
  final int id;
  final String description;
  final double amount;
  final String type;
  final int categoryId;
  final String date;

  const UpdateExpenseEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.date,
  });
} 