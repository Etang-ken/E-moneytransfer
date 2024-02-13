
class OnbordingContent {
  String image;
  String heading;
  String description;
  String title;

  OnbordingContent(
      {required this.image,
      required this.heading,
      required this.description,
      required this.title});
}

List<OnbordingContent> content = [
  OnbordingContent(
    heading: 'pro4home',
    image: 'assets/images/onboarding_img1.png',
    title:
        "Advertise your Services or Find Technical Service Providers",
    description: 'Advertise Services or Find Service Providers',
  ),
  OnbordingContent(
    heading: 'pro4home',
    image: 'assets/images/onboarding_img2.png',
    title:
    "Advertise your Services or Find Technical Service Providers",
    description: 'Advertise Services or Find Service Providers',
  ),
  OnbordingContent(
    heading: 'pro4home',
    image: 'assets/images/onboarding_img3.png',
    title:
    "Advertise your Services or Find Technical Service Providers",
    description: 'Advertise Services or Find Service Providers',
  ),
];
