Set acc2007 = CreateObject("DAO.DBEngine.36")
acc2007.CompactDatabase "C:\TMP\dbWolters-v02_111015-1822.mdb", "C:\TMP\dbWolters-v02_111015-18222.mdb", Nothing, Nothing, ";pwd=abc"
Set acc2007 = Nothing