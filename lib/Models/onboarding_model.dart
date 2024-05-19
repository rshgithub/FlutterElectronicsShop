class OnboardingModel {
  final String title;
  final String image;
  final String desc;

  OnboardingModel({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingModel> contents = [
  OnboardingModel(
    title: "View product 360 degrees",
    image: "assets/images/Illus-5.png",
    desc: "You can see the product with all angles, true and convenient.",
  ),
  OnboardingModel(
    title: "Find products easily",
    image: "assets/images/Illus-6.png",
    desc: "You just need to take a photo or upload and we will find similar products for you.",
  ),
  OnboardingModel(
    title: "Payment is easy",
    image: "assets/images/Illus-7.png",
    desc: "You just need to take a photo or upload and we will find similar products for you.",
  ),
];
