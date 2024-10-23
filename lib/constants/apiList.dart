import 'baseUrl.dart';

class Api{
  static String Login =Constants.BASE_URL+'api/auth/signin';
  static String Client =Constants.BASE_URL+'api/clients_rfi/getAll/';
  static String ClientMaker =Constants.BASE_URL+'api/clients_rfi/clientsRfiAndroid/';
  static String ProjectMaker =Constants.BASE_URL+'api/projects_rfi/getProjectsByUserIdAndRoleAndroid/';
  static String WorkTypeMaker =Constants.BASE_URL+'api/activity_sequence/getActivitySequencesAndroid/';
  static String structureMaker =Constants.BASE_URL+'StructureRfi/getStructure/';
  static String stageMaker =Constants.BASE_URL+'stage/getStage/';
  static String UnitMaker =Constants.BASE_URL+'unitRfi/getUnit/';
  static String SubUnitMaker =Constants.BASE_URL+'SubUnitRfi/getSubUnit/';
  static String CheckList =Constants.BASE_URL+'ActivityChecklistSeqRfi/getChecklistsAndroid/';
  static String GroupList =Constants.BASE_URL+'GroupRfiController/getGroupsAndroid/';
  static String QuestionRFI =Constants.BASE_URL+'QuestionRfi/getQuestionsAndroid/';
  static String UploadRFI =Constants.BASE_URL+'rfi/createRFI';
  static String UploadImage =Constants.BASE_URL+'RfiDetails/uploadRfiDetailsImageS/';


  static String ClientRFI =Constants.BASE_URL+'api/rfi/createRFI';
  static String project =Constants.BASE_URL+'api/client_projects/getByClientId/';
  static String Struture =Constants.BASE_URL+'StructureRfi/getByClientAndProjectId/';
  static String Stage =Constants.BASE_URL+'stage/findByClientProjectStructureid/';
  static String Unit =Constants.BASE_URL+'unitRfi/GetByMultipleIds/';
  static String Subunit =Constants.BASE_URL+'SubUnitRfi/getByMultipleIds/';
  static String Checklist =Constants.BASE_URL+'api/checklist_rfi/getByClientIdprojectId/';
  static String Group =Constants.BASE_URL+'GroupRfiController/getByGroupChecklistId/';

}