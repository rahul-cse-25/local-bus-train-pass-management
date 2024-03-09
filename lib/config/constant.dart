import 'dart:math';

const MONGO_URL = 'mongodb+srv://rahul7507:rahul7507@cluster0.b2cmv2p.mongodb.net/PassInfo?retryWrites=true&w=majority&appName=Cluster0';
const USER_DETAILS_COLLECTION = 'userDetails';
const TRAIN_TRANSPORTATION_COLLECTION = 'trainTransportationDetails';
const AADHAR_DETAILS_COLLECTION = 'aadharDetails';
const BUS_TRANSPORTATION_COLLECTION = 'busTransportationDetails';
const PASS_DETAILS_COLLECTION = 'passDetails';
const TC_DETAILS_COLLECTION = 'tcDetails';



// to import the csv file into mongodb
// mongoimport --uri "mongodb+srv://rahul7507:rahul7507@cluster0.b2cmv2p.mongodb.net/PassInfo?retryWrites=true&w=majority&appName=Cluster0" --collection aadharDetails --type csv --headerline --file "E:\Mini_Project\public_transit_pass_info\assets\dataSets\indianAadharDataset.csv"

const APP_LINK_OF_PLAYSTORE = 'https://bit.ly/ovadrive-invite';


class ConstantServices {
  // only call it when user complete their profile
  static String generateReferralCode({int length = 8}){
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    String referral =  String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));

    // write logic to check generated referral is unique or not
    // if unique then send referral else generate new one

    return referral;
  }

  static bool isValidReferralCode(String referralCode){

    // match the referral code from all user's data from database
    // to perform this we need to add fields in database named as userReferralCode which generate only when user complete their profile and isReferralCodeApplied
    // these two fields have to enter in our database

    // i am writing basic logic to implement it

    // int initialize the firstUserOfDatabase = 0;
    // while(lastUserOfDatabase){
    //     return referralCode.text.toString().compareTo(databaseUserReferralCodeString) == 0;
    //     incrementTheUser++;
    // }
    // return false;

    // for testing purpose i am returning it as true
    return true;
  }

}