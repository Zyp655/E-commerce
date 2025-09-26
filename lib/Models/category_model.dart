class Category{
  final String name, image;
  Category({required this.name , required this.image});
}
final List<String> filterCategory =[
  'Filter',
  'Ratings',
  'Size',
  'Color',
  'Price',

];
List<Category> category=[
  Category(
      name: 'Women',
      image:'assets/woman.png'
  ),
  Category(
      name: 'kids',
      image:'assets/kids.png'
  ),
  Category(
      name: 'men',
      image:'assets/men.png'
  ),
  Category(
      name: 'teens',
      image:'assets/teen.png'
  ),
  Category(
      name: 'baby',
      image:'assets/baby.png'
  ),
];