DROP DATABASE IF EXISTS {db};
CREATE DATABASE {db};

DROP USER IF EXISTS "{db}"@"localhost";
CREATE USER "{db}"@"localhost" IDENTIFIED WITH mysql_native_password BY "{pass}";
GRANT ALL PRIVILEGES ON {db}.* to "{db}"@"localhost";

-- DROP USER IF EXISTS "{db}"@"{ip}";
-- CREATE USER "{db}"@"{ip}" IDENTIFIED WITH mysql_native_password BY "{pass}";
-- GRANT ALL PRIVILEGES ON {db}.* to "{db}"@"{ip}";

FLUSH PRIVILEGES;

SELECT user,host FROM mysql.user WHERE user = '{db}';
