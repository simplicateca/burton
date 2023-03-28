-- fixes/prevents a weird bug related to Mysql Server 8 and Docker
-- https://stackoverflow.com/questions/49019652/not-able-to-connect-to-mysql-docker-from-local
-- https://stackoverflow.com/questions/56052177/alter-user-rootlocalhost-identified-via-mysql-native-password-fails-with-sy
ALTER USER 'project'@'%' IDENTIFIED WITH mysql_native_password BY 'project';
