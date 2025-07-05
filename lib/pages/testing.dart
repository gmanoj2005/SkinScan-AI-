import 'dart:io';
import 'dart:developer' as devtools;
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

import '../features/mlresult.dart';
//import 'package:tflite/tflite.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';
class  Testing extends StatefulWidget{
  final  String docId;
  const Testing({Key? key, required this.docId}) : super(key: key);

  @override
  TakeImg  createState(){
    return  TakeImg();
  }

}

class  TakeImg extends State<Testing>{
  bool isAboutExpanded = false;
  bool isSymptomsExpanded = false;
  bool isTreatmentExpanded = false;
  bool isImagesExpanded = false;
  bool isLiked = false;
  String about="• Please Upload Valid Image",treatment="• Please Upload Valid Image";
  List<String> symptoms=['Please Upload Valid Image'];
  String label = '';
  double confidence = 0.0;
  File? filePath;
  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final  image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
    );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
      if(label=="Actinic keratoses and intraepithelial carcinomae")
        {
          about="Actinic keratosis (AK) is a common skin condition caused by prolonged exposure to ultraviolet (UV) light, often from the sun or tanning bedssymptoms. Intraepithelial carcinoma, often referred to as carcinoma in situ (CIS), is a term used to describe a group of cancers that are confined to the epithelial layer of tissue and have not invaded deeper structures.";
          treatment="Cryotherapy involves freezing lesions with liquid nitrogen to destroy precancerous cells. Topical therapies include fluorouracil (5-FU), which is applied as a cream or solution to stimulate the immune system to fight cancer cells. Another option is imiquimod, a cream that not only boosts the immune response but also promotes apoptosis, or cell death. Ingenol mebutate is a gel that causes cell death and encourages apoptosis as well. Chemical peels, which involve applying a solution to remove the top layers of skin, can help eliminate actinic keratoses (AKs). Additionally, laser therapy, both ablative and non-ablative, can effectively remove AKs and promote collagen production. Surgical excision is another approach, where the AK is removed through a surgical incision and suturing. For optimal results, combination therapy, which utilizes two or more treatment modalities, may be employed.";
          symptoms=['Location:Often found on sun-exposed areas, such as the face, ears, hands, and arms',
            'Size: AKs can range from a few millimeters to several centimeters in diameter',
            'Shape: Lesions may be irregular, oval, or circular',
            'Color: May be pink, red, brown, or flesh-colored',
            'Texture: Scaly, rough, or smooth',
            'Pain: AKs are usually asymptomatic, but may cause mild itching or discomfort',
            'Bleeding: May bleed easily if scratched or irritated'];
        }
      else if(label=="Basal cell carcinoma"){
        about="Basal cell carcinoma (BCC) is the most common type of skin cancer, accounting for approximately 30% of all skin cancer cases in the US. It typically appears as a painless, raised area of skin, which may be shiny with small blood vessels running over it or ulcerated.";
        treatment="Local surgical procedures are the most common and effective treatments for basal cell carcinoma (BCC). For specific lesions, dermatologists may consider topical therapeutic options, such as creams or ointments. Your dermatologist will discuss these various options based on the characteristics of the BCC, aiming to effectively remove or destroy the cancerous cells while minimizing damage to healthy tissue. In rare cases, if the BCC has spread to other parts of the body, systemic treatments like sonidegib (Odomzo) or vismodegib (Erivedge) may prescribed.";
        symptoms=['Size: Typically small to medium-sized',
          'Color: Pink, red, or flesh-toned.',
          'Location: Commonly appears on sun-exposed areas such as the face, neck, and shoulders.',
          'Pain: Generally painless.',
          'Texture: Shiny or pearly, sometimes with a waxy feel.',
          'Appearance: May have visible blood vessels or a central indentation and can bleed occasionally.'];

      }
      else if(label=="Benign keratosis-like lesions"){
        about='Benign keratosis-like lesions are common, non-cancerous growths that appear on the skin. They are characterized by a thickened, scaly, or waxy appearance, and can vary in size, shape, and color. These lesions are often referred to as "Seborrheic keratoses" .';
        treatment="Cryotherapy involves freezing the lesion with liquid nitrogen to effectively remove it. Another method, shave excision, entails cutting off the top layer of the lesion using a surgical blade. Electrocautery uses electrical current to burn and eliminate the lesion, while laser therapy targets the pigment within the lesion with a laser to facilitate its removal. Additionally, curettage involves scraping off the lesion using a specialized instrument.";
        symptoms=[ 'Size: Small, usually less than 1 cm in diameter.',
          'Color: Pink, red, brown, or purple.',
          'Location: Commonly found on the legs, arms, and occasionally other areas.',
          'Pain: Typically painless, but may be tender when pressed.',
          'Texture: Firm and rubbery, often feels like a hard nodule under the skin.',
          'Appearance: Dome-shaped or slightly raised, with a smooth or slightly scaly surface; often has a central dimple when pinched.'];

      }
      else if(label=="Dermatofibroma"){
        about="Dermatofibromas are usually painless and can occur as a result of mild trauma, such as an injury or insect bite.They typically range from 0.2 cm to 2 cm in size, but larger examples have been reported. Dermatofibromas can occur on various areas of the body, including the legs, elbows, and chest, with a higher prevalence in women.";
        treatment="Cryotherapy involves freezing lesions with liquid nitrogen to destroy precancerous cells. Topical therapies include fluorouracil (5-FU), which is applied as a cream or solution to stimulate the immune system to fight cancer cells. Another option is imiquimod, a cream that not only boosts the immune response but also promotes apoptosis, or cell death. Ingenol mebutate is a gel that causes cell death and encourages apoptosis as well. Chemical peels, which involve applying a solution to remove the top layers of skin, can help eliminate actinic keratoses (AKs). Additionally, laser therapy, both ablative and non-ablative, can effectively remove AKs and promote collagen production. Surgical excision is another approach, where the AK is removed through a surgical incision and suturing. For optimal results, combination therapy, which utilizes two or more treatment modalities, may be employed.";
        symptoms=[ ' Size: Small, usually less than 1 cm in diameter.',
      'Color: Pink, red, brown, or purple.',
      'Location: Commonly found on the legs, arms, and occasionally other areas.',
      'Pain: Typically painless, but may be tender when pressed.',
      'Texture: Firm and rubbery, often feels like a hard nodule under the skin.',
      'Appearance: Dome-shaped or slightly raised, with a smooth or slightly scaly surface; often has a central dimple when pinched.'];

      }
      else if(label=="Melanocytic nevi"){
        about="Melanocytic nevi, commonly referred to as moles, are benign growths on the skin caused by the proliferation of pigment-producing cells called melanocytes. They can appear at birth or develop within the first few weeks of life, and are characterized by benign proliferations of nevomelanocytes.";
        treatment="Other treatment methods for dermatofibromas include freezing the growth with liquid nitrogen, injecting it with corticosteroids, or using laser procedures. However, these methods may not always be effective. Currently, there are no known techniques to permanently change the size of a dermatofibroma, and while a growth may occasionally shrink or disappear on its own, this is rare. It is important for individuals not to attempt to remove these growths at home, as improper removal can lead to deep scarring, infection, and inadequate healing.";
        symptoms=['Size: Varies from small (a few millimeters) to larger than 1 cm.',
          'Color: Usually brown or black, but can also be tan, pink, or flesh-colored.',
          'Location: Can appear anywhere on the body, including the face, torso, arms, and legs',
          'Pain: Painless.',
          'Texture: Smooth, can be flat or slightly raised.',
          'Appearance: Round or oval with well-defined borders, often uniform in color and shape.'];

      }
      else if(label=="Pyogenic granulomas and hemorrhage"){
        about="Pyogenic granulomas are benign, reactive skin lesions characterized by an excessive growth of blood vessels. They typically appear as red, smooth, or lobulated bumps on the skin, often with a moist surface. One of the distinctive features of pyogenic granulomas is their tendency to bleed easily due to the high number of blood vessels present. Hemorrhage refers to the escape of blood from the circulatory system, which can occur internally or externally. It can result from various causes, including injury, trauma, medical conditions, or surgical procedures.";
        treatment="Surgical treatments for lesions include curettage, which involves scraping away the lesion with a surgical instrument, and cautery, where heat is applied to seal the skin and prevent bleeding. Laser therapy can also be utilized, using vascular lasers to destroy the abnormal tissue. Full-thickness surgical excision is another option, wherein the lesion is removed through a cut, and the skin is closed with stitches. In addition to these surgical methods, regular monitoring through check-ups with a healthcare provider is important to observe the lesion’s size and any bleeding. Topical antibiotics may be applied to prevent infection, and in some cases, oral medications can be prescribed to reduce the size of the lesion or alleviate symptoms.";
        symptoms=['Size: Small, usually less than 1 cm in diameter.',
          'Color: Bright red, reddish-purple, or brown.',
          'Location: Common on the hands, fingers, face, and inside the mouth.',
          'Pain: Can be tender or bleed easily with minor trauma.',
          'Texture: Smooth and moist, often feels like a soft, raised nodule.',
          'Appearance: Dome-shaped or polyp-like with a glistening surface; prone to bleeding due to rich blood supply.'];

      }
      else if(label=="Melanoma"){
        about="Melanoma is the most serious type of skin cancer, accounting for only about 1% of all skin cancers but causing the majority of skin cancer-related deaths. It develops from the malignant transformation of melanocytes, the cells responsible for producing melanin, the pigment that gives skin its color.";
        treatment="Surgery is the main treatment for melanoma, which includes excising the primary tumor and removing a larger area of healthy tissue around it through a procedure known as wide local excision. Immunotherapy is another approach that stimulates the immune system to attack cancer cells, while targeted therapy focuses on specific molecular pathways or proteins involved in melanoma growth and progression. Chemotherapy serves as a systemic treatment to kill cancer cells throughout the body, and intralesional therapy involves the local injection of medication directly into the tumor to reduce its size and spread. Palliative local therapy is used to relieve symptoms and improve quality of life for patients with advanced or metastatic melanoma. Treatment options vary based on the stage of melanoma: for Stage 0, excision is the standard treatment; for Stage I, wide local excision is the primary treatment, with possible additional interventions for high-risk features; for Stage II-III, wide local excision is followed by immunotherapy, targeted therapy, or chemotherapy, depending on tumor characteristics; and for Stage IV, a combination of immunotherapy, targeted therapy, and chemotherapy is often utilized, along with palliative local therapy to manage symptoms.";
        symptoms=['Size: Varies, often larger than 6 mm, but can be smaller.',
          'Color: Mixture of black, brown, and tan, sometimes with areas of white, gray, red, or blue.',
          'Location: Common on sun-exposed areas like the back, legs, arms, and face, but can appear anywhere on the body.',
          'Pain: May be painless but can itch, bleed, or become tender as it progresses.',
          'Texture: Can be smooth or slightly raised with an uneven or rough surface.',
          'Appearance: Asymmetrical with irregular, poorly defined borders; shows multiple colors and may grow or change overtime'];

      }



      Update().updateUserData(label+"/"+confidence.toString(), widget.docId);
      print(label);
    });
  }
  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final  image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
    );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
      if(label=="Actinic keratoses and intraepithelial carcinomae")
      {
        about="Actinic keratosis (AK) is a common skin condition caused by prolonged exposure to ultraviolet (UV) light, often from the sun or tanning bedssymptoms. Intraepithelial carcinoma, often referred to as carcinoma in situ (CIS), is a term used to describe a group of cancers that are confined to the epithelial layer of tissue and have not invaded deeper structures.";
        treatment="Cryotherapy involves freezing lesions with liquid nitrogen to destroy precancerous cells. Topical therapies include fluorouracil (5-FU), which is applied as a cream or solution to stimulate the immune system to fight cancer cells. Another option is imiquimod, a cream that not only boosts the immune response but also promotes apoptosis, or cell death. Ingenol mebutate is a gel that causes cell death and encourages apoptosis as well. Chemical peels, which involve applying a solution to remove the top layers of skin, can help eliminate actinic keratoses (AKs). Additionally, laser therapy, both ablative and non-ablative, can effectively remove AKs and promote collagen production. Surgical excision is another approach, where the AK is removed through a surgical incision and suturing. For optimal results, combination therapy, which utilizes two or more treatment modalities, may be employed.";
        symptoms=['Location:Often found on sun-exposed areas, such as the face, ears, hands, and arms',
          'Size: AKs can range from a few millimeters to several centimeters in diameter',
          'Shape: Lesions may be irregular, oval, or circular',
          'Color: May be pink, red, brown, or flesh-colored',
          'Texture: Scaly, rough, or smooth',
          'Pain: AKs are usually asymptomatic, but may cause mild itching or discomfort',
          'Bleeding: May bleed easily if scratched or irritated'];
      }
      else if(label=="Basal cell carcinoma"){
        about="Basal cell carcinoma (BCC) is the most common type of skin cancer, accounting for approximately 30% of all skin cancer cases in the US. It typically appears as a painless, raised area of skin, which may be shiny with small blood vessels running over it or ulcerated.";
        treatment="Local surgical procedures are the most common and effective treatments for basal cell carcinoma (BCC). For specific lesions, dermatologists may consider topical therapeutic options, such as creams or ointments. Your dermatologist will discuss these various options based on the characteristics of the BCC, aiming to effectively remove or destroy the cancerous cells while minimizing damage to healthy tissue. In rare cases, if the BCC has spread to other parts of the body, systemic treatments like sonidegib (Odomzo) or vismodegib (Erivedge) may prescribed.";
        symptoms=['Size: Typically small to medium-sized',
          'Color: Pink, red, or flesh-toned.',
          'Location: Commonly appears on sun-exposed areas such as the face, neck, and shoulders.',
          'Pain: Generally painless.',
          'Texture: Shiny or pearly, sometimes with a waxy feel.',
          'Appearance: May have visible blood vessels or a central indentation and can bleed occasionally.'];

      }
      else if(label=="Benign keratosis-like lesions"){
        about='Benign keratosis-like lesions are common, non-cancerous growths that appear on the skin. They are characterized by a thickened, scaly, or waxy appearance, and can vary in size, shape, and color. These lesions are often referred to as "Seborrheic keratoses" .';
        treatment="Cryotherapy involves freezing the lesion with liquid nitrogen to effectively remove it. Another method, shave excision, entails cutting off the top layer of the lesion using a surgical blade. Electrocautery uses electrical current to burn and eliminate the lesion, while laser therapy targets the pigment within the lesion with a laser to facilitate its removal. Additionally, curettage involves scraping off the lesion using a specialized instrument.";
        symptoms=[ 'Size: Small, usually less than 1 cm in diameter.',
          'Color: Pink, red, brown, or purple.',
          'Location: Commonly found on the legs, arms, and occasionally other areas.',
          'Pain: Typically painless, but may be tender when pressed.',
          'Texture: Firm and rubbery, often feels like a hard nodule under the skin.',
          'Appearance: Dome-shaped or slightly raised, with a smooth or slightly scaly surface; often has a central dimple when pinched.'];

      }
      else if(label=="Dermatofibroma"){
        about="Dermatofibromas are usually painless and can occur as a result of mild trauma, such as an injury or insect bite.They typically range from 0.2 cm to 2 cm in size, but larger examples have been reported. Dermatofibromas can occur on various areas of the body, including the legs, elbows, and chest, with a higher prevalence in women.";
        treatment="Cryotherapy involves freezing lesions with liquid nitrogen to destroy precancerous cells. Topical therapies include fluorouracil (5-FU), which is applied as a cream or solution to stimulate the immune system to fight cancer cells. Another option is imiquimod, a cream that not only boosts the immune response but also promotes apoptosis, or cell death. Ingenol mebutate is a gel that causes cell death and encourages apoptosis as well. Chemical peels, which involve applying a solution to remove the top layers of skin, can help eliminate actinic keratoses (AKs). Additionally, laser therapy, both ablative and non-ablative, can effectively remove AKs and promote collagen production. Surgical excision is another approach, where the AK is removed through a surgical incision and suturing. For optimal results, combination therapy, which utilizes two or more treatment modalities, may be employed.";
        symptoms=[ ' Size: Small, usually less than 1 cm in diameter.',
          'Color: Pink, red, brown, or purple.',
          'Location: Commonly found on the legs, arms, and occasionally other areas.',
          'Pain: Typically painless, but may be tender when pressed.',
          'Texture: Firm and rubbery, often feels like a hard nodule under the skin.',
          'Appearance: Dome-shaped or slightly raised, with a smooth or slightly scaly surface; often has a central dimple when pinched.'];

      }
      else if(label=="Melanocytic nevi"){
        about="Melanocytic nevi, commonly referred to as moles, are benign growths on the skin caused by the proliferation of pigment-producing cells called melanocytes. They can appear at birth or develop within the first few weeks of life, and are characterized by benign proliferations of nevomelanocytes.";
        treatment="Other treatment methods for dermatofibromas include freezing the growth with liquid nitrogen, injecting it with corticosteroids, or using laser procedures. However, these methods may not always be effective. Currently, there are no known techniques to permanently change the size of a dermatofibroma, and while a growth may occasionally shrink or disappear on its own, this is rare. It is important for individuals not to attempt to remove these growths at home, as improper removal can lead to deep scarring, infection, and inadequate healing.";
        symptoms=['Size: Varies from small (a few millimeters) to larger than 1 cm.',
          'Color: Usually brown or black, but can also be tan, pink, or flesh-colored.',
          'Location: Can appear anywhere on the body, including the face, torso, arms, and legs',
          'Pain: Painless.',
          'Texture: Smooth, can be flat or slightly raised.',
          'Appearance: Round or oval with well-defined borders, often uniform in color and shape.'];

      }
      else if(label=="Pyogenic granulomas and hemorrhage"){
        about="Pyogenic granulomas are benign, reactive skin lesions characterized by an excessive growth of blood vessels. They typically appear as red, smooth, or lobulated bumps on the skin, often with a moist surface. One of the distinctive features of pyogenic granulomas is their tendency to bleed easily due to the high number of blood vessels present. Hemorrhage refers to the escape of blood from the circulatory system, which can occur internally or externally. It can result from various causes, including injury, trauma, medical conditions, or surgical procedures.";
        treatment="Surgical treatments for lesions include curettage, which involves scraping away the lesion with a surgical instrument, and cautery, where heat is applied to seal the skin and prevent bleeding. Laser therapy can also be utilized, using vascular lasers to destroy the abnormal tissue. Full-thickness surgical excision is another option, wherein the lesion is removed through a cut, and the skin is closed with stitches. In addition to these surgical methods, regular monitoring through check-ups with a healthcare provider is important to observe the lesion’s size and any bleeding. Topical antibiotics may be applied to prevent infection, and in some cases, oral medications can be prescribed to reduce the size of the lesion or alleviate symptoms.";
        symptoms=['Size: Small, usually less than 1 cm in diameter.',
          'Color: Bright red, reddish-purple, or brown.',
          'Location: Common on the hands, fingers, face, and inside the mouth.',
          'Pain: Can be tender or bleed easily with minor trauma.',
          'Texture: Smooth and moist, often feels like a soft, raised nodule.',
          'Appearance: Dome-shaped or polyp-like with a glistening surface; prone to bleeding due to rich blood supply.'];

      }
      else if(label=="Melanoma"){
        about="Melanoma is the most serious type of skin cancer, accounting for only about 1% of all skin cancers but causing the majority of skin cancer-related deaths. It develops from the malignant transformation of melanocytes, the cells responsible for producing melanin, the pigment that gives skin its color.";
        treatment="Surgery is the main treatment for melanoma, which includes excising the primary tumor and removing a larger area of healthy tissue around it through a procedure known as wide local excision. Immunotherapy is another approach that stimulates the immune system to attack cancer cells, while targeted therapy focuses on specific molecular pathways or proteins involved in melanoma growth and progression. Chemotherapy serves as a systemic treatment to kill cancer cells throughout the body, and intralesional therapy involves the local injection of medication directly into the tumor to reduce its size and spread. Palliative local therapy is used to relieve symptoms and improve quality of life for patients with advanced or metastatic melanoma. Treatment options vary based on the stage of melanoma: for Stage 0, excision is the standard treatment; for Stage I, wide local excision is the primary treatment, with possible additional interventions for high-risk features; for Stage II-III, wide local excision is followed by immunotherapy, targeted therapy, or chemotherapy, depending on tumor characteristics; and for Stage IV, a combination of immunotherapy, targeted therapy, and chemotherapy is often utilized, along with palliative local therapy to manage symptoms.";
        symptoms=['Size: Varies, often larger than 6 mm, but can be smaller.',
          'Color: Mixture of black, brown, and tan, sometimes with areas of white, gray, red, or blue.',
          'Location: Common on sun-exposed areas like the back, legs, arms, and face, but can appear anywhere on the body.',
          'Pain: May be painless but can itch, bleed, or become tender as it progresses.',
          'Texture: Can be smooth or slightly raised with an uneven or rough surface.',
          'Appearance: Asymmetrical with irregular, poorly defined borders; shows multiple colors and may grow or change overtime'];

      }
      Update().updateUserData(label+"/"+confidence.toString(), widget.docId);
    });
  }
  Future<void> _tfLteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
        true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
        false // defaults to false, set to true to use GPU delegate
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tfLteInit();
  }

    @override
    Widget build(BuildContext context) {
    
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
              "Test Your Skin",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(25,0,25,25),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.blue[200],
                    elevation: 10,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      //width: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Container(
                              //backgroundcolor: Colors.blue[200],
                              height: 280,
                              width: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/upload.jpg'),
                                ),
                              ),
                              child: filePath == null
                                  ? const Text('')
                                 : Image.file(
                                filePath!,
                                fit: BoxFit.fill,
                             ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    label,textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "The Accuracy is ${confidence.toStringAsFixed(0)}%",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  _buildExpandableSection(
                                    title: "Description",
                                    content: Text(about,style: TextStyle(fontSize:20 ),),
                                    isExpanded: isAboutExpanded,
                                    onToggle: () => setState(() => isAboutExpanded = !isAboutExpanded),
                                  ),
                                  _buildExpandableSection(

                                    title: "Symptoms",
                                    content: _buildSymptomsList(symptoms),
                                    isExpanded: isSymptomsExpanded,
                                    onToggle: () => setState(() => isSymptomsExpanded = !isSymptomsExpanded),
                                  ),
                                  _buildExpandableSection(
                                    title: "Treatment",
                                    content: Text(treatment,style: TextStyle(fontSize:20 )),
                                    isExpanded: isTreatmentExpanded,
                                    onToggle: () => setState(() => isTreatmentExpanded = !isTreatmentExpanded),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(

                    onPressed: () {
                      pickImageCamera();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        foregroundColor: Colors.black),
                    child: const Text(
                      "Take a Photo",style: TextStyle(color: Colors.white,fontSize:25),)
                    ),

                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pickImageGallery();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: Color(0xFF0F52BA),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        foregroundColor: Colors.black),
                    child: const Text(
                      "Pick from gallery",style: TextStyle(color: Colors.white,fontSize:25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

  Widget _buildExpandableSection({
    required String title,
    required Widget content,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          trailing: Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          onTap: onToggle,
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: content,
          ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSymptomsList(List<String> symptoms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: symptoms.map((symptom) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text('• $symptom', style: TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
  }
