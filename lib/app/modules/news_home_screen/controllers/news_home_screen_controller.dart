import 'package:fourdimensions/app/modules/news_home_screen/models/news_model.dart';
import 'package:get/get.dart';

class NewsHomeScreenController extends GetxController {
  var newsList = <NewsModel>[].obs;

  void loadManualNews() {
    newsList.value = [
      NewsModel(
        title:
            "Kate and Queen lay Armistice Day wreaths as nation pays tribute",
        imageUrl: "assets/images/one.jpg",
        time: "5h ago",
        description:
            "The Princess of Wales and the Queen have joined services to mark Armistice Day in the UK as events took place around the world. Catherine stood at the ceremony at the National Memorial Arboretum in Staffordshire, where the Last Post signalled the start of a national two-minute silence at 11:00 GMT to mark the end of World War One. Queen Camilla was at Paddington Station in London for the wreath-laying ceremony, having travelled by train.The Prince of Wales has also delivered a video message to young people, sharing his views on the importance of wearing a red poppy and to say that remembrance is for everyone.",
        isFeatured: true,
      ),
      NewsModel(
        title: "UK unemployment rate rises to 5% as jobs market weakens",
        imageUrl: "assets/images/two.webp",
        time: "30 mins ago",
        description:
            "The rate of UK unemployment has risen to 5% in the three months to September, showing signs the jobs market has weakened, according to new official figures. It is the highest rate since the period covering December 2020 to February 2021, according to the Office for National Statistics (ONS) - boosting expectations of a December interest rate cut. The increase in the unemployment rate was higher than expected, coming in above the 4.9% projected by many analysts ahead of the Budget on 26 November. Average wage growth was 4.6% in the third quarter, down from 4.7% over the three months to August.",
        isFeatured: false,
      ),
      NewsModel(
        title:
            "NWe've got to fight for our journalism,' BBC director general tells staff",
        imageUrl: "assets/images/three.webp",
        time: "40 mins ago",
        description:
            "BBC director general Tim Davie has told staff that we've got to fight for our journalism after Donald Trump threatened to sue the corporation for 1bn (£760m) over a Panorama programme.It comes after a leaked internal BBC memo, published by the Telegraph last Monday, said the film had misled viewers by splicing together parts of the US president's speech on 6 January 2021 and made it appear as if he had explicitly encouraged the Capitol Hill riot.We have made some mistakes that have cost us, but we need to fight,Davie, who resigned on Sunday alongside BBC News CEO Deborah Turness after mounting pressure over the memo, said on Tuesday.This narrative will not just be given by our enemies, it's our narrative, he added. He said the BBC went through difficult times… but it just does good work, and that speaks louder than any newspaper, any weaponisation.Trump threatened to take legal action if the BBC did not make a full and fair retraction of the programme by Friday. The corporation has said it will reply in due course.BBC chair Samir Shah said in a letter to the Culture, Media and Sport Committee (CMS) on Monday that the corporation would like to apologise for the edit, which he called an error of judgement which gave the impression of a direct call for violent action.",
        isFeatured: false,
      ),
      NewsModel(
        title: "Hundreds arrested in High Street crime crackdown",
        imageUrl: "assets/images/four.webp",
        time: "12h ago",
        description:
            "Targeted raids on High Street premises such as mini-marts, vape shops, barbers and takeaways have seen more than 920 people arrested, in the largest action of its kind coordinated by the National Crime Agency (NCA). More than 340 notices for illegal working and renting were issued by authorities, which could see businesses and landlords fined tens of thousands of pounds. Last week the BBC exposed Kurdish crime fixers who claimed to be able to make £60,000 illegal working fines disappear. The BBC's reporting also uncovered a Kurdish criminal network using ghost directors to represent companies' official paperwork while remaining uninvolved in day-to-day operations.",
        isFeatured: false,
      ),
      NewsModel(
        title: "Jilly Cooper died from head injury, says coroner",
        imageUrl: "assets/images/five.webp",
        time: "3h ago",
        description:
            "Dame Jilly Cooper suffered a fatal head injury during a fall at her Gloucestershire home, an inquest was told. The writer - known for her steamy romantic novels such as Riders, Rivals and Polo - was found by family at her home in Bisley at about 17:00 BST on 4 October. Gloucestershire Coroners' Court was told Dame Jilly was initially alert and taken by paramedics to Gloucestershire Royal Hospital, but her condition deteriorated. She died in hospital, with her family present, at 08.30 BST on 5 October.",
        isFeatured: true,
      ),
      NewsModel(
        title: "Ex-MP Mordaunt 'feared violence' by alleged stalker",
        imageUrl: "assets/images/six.webp",
        description:
            "Dame Penny Mordaunt has told a court she feared sexual violence from a man accused of stalking her, and that his actions were more concerning than threats from others to shoot her and her family. Edward Brandt, 61, denies stalking intending serious alarm or distress against the former MP for Portsmouth North. He sent multiple emails and phone messages to Dame Penny and also turned up at her Portsmouth office out of hours in a bid to meet her, Southampton Crown Court heard. The trial was told Mr Brandt's references to wanting a personal relationship with Dame Penny caused her to fear sexual violence, which is extremely alarming. Her voice breaking with emotion, Dame Penny, 52, told the court: This comes after the spate of 13 emails plus voice messages, it's after he came to my office out of hours, it's after the police intervened and our letter of cease and desist.He wants to meet me after hours, the way he is talking about my physical appearance and so forth, it's clear that this is not a normal pattern of behaviour. The alleged offending occurred between 11 September 2023 and 12 May 2024.",
        time: "3h ago",
        isFeatured: false,
      ),
    ];
  }

  final count = 0.obs;
  @override
  void onInit() {
    loadManualNews();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    newsList.close();
    super.onClose();
  }

  void increment() => count.value++;
}
