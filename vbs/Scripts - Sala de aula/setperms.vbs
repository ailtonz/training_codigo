Set dse = GetObject("LDAP://RootDSE")
Set domain = GetObject( "LDAP://" & dse.Get("defaultNamingContext"))



set usr = GetObject("LDAP:// CN=SQLAdmin1, OU=SQL Administrators, OU=Vancouver, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin2, OU=SQL Administrators, OU=Denver, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin3, OU=SQL Administrators, OU=Perth, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin4, OU=SQL Administrators, OU=Brisbane, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin5, OU=SQL Administrators, OU=Lisbon, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin6, OU=SQL Administrators, OU=Bonn, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin7, OU=SQL Administrators, OU=Lima, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin8, OU=SQL Administrators, OU=Santiago, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin9, OU=SQL Administrators, OU=Bangalore, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin10, OU=SQL Administrators, OU=Singapore, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin11, OU=SQL Administrators, OU=Casablanca, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin12, OU=SQL Administrators, OU=Tunis, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin13, OU=SQL Administrators, OU=Acapulco, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin14, OU=SQL Administrators, OU=Miami, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin15, OU=SQL Administrators, OU=Auckland, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin16, OU=SQL Administrators, OU=Suva, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin17, OU=SQL Administrators, OU=Stockholm, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin18, OU=SQL Administrators, OU=Moscow, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin19, OU=SQL Administrators, OU=Caracas, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin20, OU=SQL Administrators, OU=Montevideo, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin21, OU=SQL Administrators, OU=Manila, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin22, OU=SQL Administrators, OU=Tokyo, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin23, OU=SQL Administrators, OU=Khartoum, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo

set usr = GetObject("LDAP:// CN=SQLAdmin24, OU=SQL Administrators, OU=Nairobi, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo


set usr = GetObject("LDAP:// CN=SQLService, CN=Users, DC=nwtraders, DC=msft")
usr.SetPassword("sqlservice")
usr.SetInfo

set usr = GetObject("LDAP:// CN=Exservice, CN=Users, DC=nwtraders, DC=msft")
usr.SetPassword("password")
usr.SetInfo
