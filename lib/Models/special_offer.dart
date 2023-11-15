class SpecialOffer {
  final String discount;
  final String title;
  final String detail;
  final String icon;

  SpecialOffer({
    required this.discount,
    required this.title,
    required this.detail,
    required this.icon,
  });
}

final homeSpecialOffers = <SpecialOffer>[
  SpecialOffer(
    discount: 'Kotec',
    title: "",
    detail: '',
    icon: "assets/images/aiclop.png",
  ),
  SpecialOffer(
    discount: 'Innoson',
    title: "",
    detail: '',
    icon: "assets/images/ClaireDark.png",
  ),
  SpecialOffer(
    discount: 'Kotec',
    title: "",
    detail: '',
    icon: "assets/images/Speak_No_Evil_Monkey_Emoji.png",
  ),
  SpecialOffer(
    discount: 'Innoson',
    title: "",
    detail: '',
    icon: "assets/images/chat_logo.png",
  ),
  SpecialOffer(
    discount: 'Kotec',
    title: "",
    detail: '',
    icon: "assets/images/person.png",
  ),
];
