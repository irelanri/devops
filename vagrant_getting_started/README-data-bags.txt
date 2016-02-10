 The following command is used to create (and open editor for) a new data bag item.
 Do not need to create files, or folders, before running this.

 "passwords" is the name of the bag (and folder)
 "db_admin_password" is the name of the item, or attribute

 secret-file should not normally be checked-in/committed like this, but just
 for convenience here. This file should be securely copied to the target servers. Not sure how vagrant recommends doing this..

 > knife solo data bag create passwords db_admin_password --secret-file ./encrypted_data_bag_secret --editor notepad

