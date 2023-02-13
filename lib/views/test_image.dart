// import 'package:flutter/material.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_picker/image_picker.dart';
// class TestFaceReco extends StatefulWidget {
//   const TestFaceReco({Key? key}) : super(key: key);
//
//   @override
//   State<TestFaceReco> createState() => _TestFaceRecoState();
// }
//
// class _TestFaceRecoState extends State<TestFaceReco> {
//   static final options = FaceDetectorOptions();
//   static final faceDetector = FaceDetector(options: options);
//   InputImage? image;
//
//   getImage()async{
//     XFile? i = await ImagePicker().pickImage(source: ImageSource.gallery);
//     image = InputImage.fromFilePath(i!.path);
//     setState(() {});
//     processImage();
//   }
//
//   processImage()async{
//     final List<Face> faces = await faceDetector.processImage(image!);
//     print("start");
//     for (Face face in faces) {
//       final Rect boundingBox = face.boundingBox;
//       print("start");
//       print("start ${boundingBox}");
//
//       // final double? rotX = face.headEulerAngleX; // Head is tilted up and down rotX degrees
//       final double? rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
//       final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
//
//       // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
//       // eyes, cheeks, and nose available):
//       // final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
//       // final FaceLandmark? noseBal = face.landmarks[FaceLandmarkType.noseBase];
//       // if (leftEar != null) {
//       //   // final Point<int> leftEarPos = leftEar.position;
//       //   print("sdf sdf  $leftEarPos");
//       // }
//
//       // print("face ${face.}");
//
//       // If classification was enabled with FaceDetectorOptions:
//       if (face.smilingProbability != null) {
//         final double? smileProb = face.smilingProbability;
//         print("smile prob $smileProb");
//       }
//
//       // If face tracking was enabled with FaceDetectorOptions:
//       if (face.trackingId != null) {
//         final int? id = face.trackingId;
//         print("tracking id $id");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialButton(onPressed: (){
//               getImage();
//             },child: Text("Pick"),)
//           ],
//         ),
//       ),
//     );
//   }
// }
