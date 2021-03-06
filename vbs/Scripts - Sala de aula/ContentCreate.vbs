'Constant definitions

'General Messages
Const L_TrackingError_DialogTitle = "BizTalk Document Tracking Error"
Const L_AppTitle_Text = "BizTalk Document Tracking"
Const L_Msg_Style = 64
Const L_InvalidParameter_ErrorMessage = "This page is entered with invalid parameters."
Const L_GetData_ErrorMessage = "Unable to retrieve information from database."
Const L_LoadingPage_ErrorMessage = "Unable to load this page."
Const L_CreatingFile_ErrorMessage = "Error processing data."
Const L_SavingFile_ErrorMessage = "Unable to save data to file."
Const L_PointingFrame_ErrorMessage = "Unable to set the frame location."
Const L_Show_ToolTip = "Show"
Const L_Hide_ToolTip = "Hide"
Const L_TimezoneLocal_Text = "Local Time"
Const L_TimezoneUTC_Text = "UTC"

Const strCustomSearch_Text = "<CustomSearch>"
Const strContains_Text = "contains"
Const strDoesNotContain_Text = "does not contain"

'XML Related
Const XMLHEADER = "<?xml version=""1.0"" encoding=""unicode""?>"
Const XML_LOWERCASE = "xml"
Const TXT_LOWERCASE = "txt"
Const TMP_LOWERCASE = "tmp"

'BizTalk Version
const C_BIZTALK_VERSION = 1000

'Data size
Const DATA_CUTOFF = 1000000
'Default settings
DEFAULT_LINESPERPAGE = 10
MAX_LINESPERPAGE = 10

'Database enums
Const DATATYPE_REAL = 1
Const DATATYPE_INT = 2
Const DATATYPE_DATE = 3
Const DATATYPE_STRING = 4
Const MSG_LEVEL_ERROR = 1
Const MSG_LEVEL_WARNING = 2
Const MSG_LEVEL_INFO = 3
Const DIRECTION_IN = 1
Const DIRECTION_OUT = 0

'Captured Field Expression Separators
Const SEP_EXP_FIELD = "~"
Const SEP_EXP_CLAUSE = "|"

'OrgApp List separators
Const SEP_ORGAPPLIST_ORG = ";"
Const SEP_ORGAPPLIST_ORGAPP = ":"
Const SEP_ORGAPPLIST_APP = ","
Const SEP_DOCTYPE = ","

Const SEP_TREEVIEWKEY_ORGAPP = ":"

'sproc names
Const SP_GET_SELECTION_SRC = "dta_ui_get_selection_src"
Const SP_GET_SELECTION_DEST = "dta_ui_get_selection_dest"

'Database field names
Const FIELDNAME_SRCORG = "nvcSrcOrgName"
Const FIELDNAME_SRCAPP = "nvcSrcAppName"
Const FIELDNAME_DESTORG = "nvcDestOrgName"
Const FIELDNAME_DESTAPP = "nvcDestAppName"

'Direction definition, used when building OrgApp whereclause
Const DIRECTION_SOURCE = "Source"
Const DIRECTION_DESTINATION = "Destination"

'Parameters passed bwteen pages
Const PARAM_NAME_SRCORGAPP = "SrcOrgApp"
Const PARAM_NAME_DESTORGAPP = "DestOrgApp"
Const PARAM_NAME_UIDAGREEMENT = "uidAgreement"
Const PARAM_NAME_TIMEZONE = "Timezone"
Const PARAM_NAME_DISPLAYPARAMS = "DisplayParams"
Const PARAM_NAME_DISPLAYALL = "DisplayAll"
Const PARAM_NAME_LINESPERPAGE = "LinesPerPage"
Const PARAM_NAME_DOCTYPE = "DocType"
Const PARAM_NAME_FROMDATE = "FromDate"
Const PARAM_NAME_TODATE = "ToDate"
Const PARAM_NAME_SORTORDER = "SortOrder"
Const PARAM_NAME_SORTBYINCOMING = "SortByIncoming"
Const PARAM_NAME_OPEN = "OpenAgreement"
Const PARAM_NAME_SHOWDOCS = "ShowDocs"
Const PARAM_NAME_ISFROMRESULTS = "IsFromResults"
Const PARAM_NAME_CAPTUREEXPRESSIONVALUE = "CaptureExpressionValue"
Const PARAM_NAME_CAPTUREEXPRESSIONNAME = "CaptureExpressionName"
Const PARAM_NAME_DIRECTION = "tnDirection"
Const PARAM_NAME_DOCUMENTKEY = "nDocumentKey"
Const PARAM_NAME_INTERCHANGEKEY = "nInterchangeKey"
Const PARAM_NAME_ISNEWEXPRESSION = "IsNewExpression"
Const PARAM_NAME_ISFROMBROWSE = "IsFromBrowse"
Const PARAM_NAME_USERQUERYKEY = "nUserQueryKey"
Const PARAM_NAME_ACTIVITYKEY = "nActivityKey"
Const PARAM_NAME_DIRECTINTERCHANGELOOKUP = "nDirectInterchangeLookup"

'Logical Operators
Const OP_GROUPING_AND = "AND"
Const OP_GROUPING_OR = "OR"

Const PARAM_SEP = "&"
Const PARAM_EQ = "="
Const PARAM_VALUE_YES = "Yes"
Const PARAM_VALUE_NO = "No"  
Const PARAM_VALUE_TIMEZONE_LOCAL = "Local"
Const PARAM_VALUE_TIMEZONE_UTC = "UTC"
Const PARAM_VALUE_OPENSRC = "OpenSrc"
Const PARAM_VALUE_OPENDEST = "OpenDest"
Const PARAM_VALUE_DIRECTION_IN = 1
Const PARAM_VALUE_DIRECTION_OUT = 0

'Cookie Names
Const COOKIE_SORTBYINCOMING = "SortByIncoming"
Const COOKIE_SORT1 = "Sort1"
Const COOKIE_SORT2 = "Sort2"
Const COOKIE_SORT3 = "Sort3"
Const COOKIE_SORT4 = "Sort4"
Const COOKIE_SORT5 = "Sort5"
Const COOKIE_SORT6 = "Sort6"
Const COOKIE_TIMESETTING = "Timesetting"
