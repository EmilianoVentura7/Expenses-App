class CategoryModel {
  final int id;
  final String name;
  final String color;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.color,
  });

  static List<CategoryModel> getCategories() {
    return [
      const CategoryModel(id: 1, name: 'Comida', color: '#FF6B6B'),
      const CategoryModel(id: 2, name: 'Transporte', color: '#4ECDC4'),
      const CategoryModel(id: 3, name: 'Entretenimiento', color: '#45B7D1'),
      const CategoryModel(id: 4, name: 'Salud', color: '#96CEB4'),
      const CategoryModel(id: 5, name: 'Educación', color: '#FFEAA7'),
      const CategoryModel(id: 6, name: 'Otros', color: '#DDA0DD'),
    ];
  }
}
