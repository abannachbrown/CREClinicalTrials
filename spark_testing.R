# spark testing with SQL


# install.packages("httpuv")
# install.packages("sparklyr")
# install.packages("SparkR")
library(sparklyr)
library(SparkR)


spark_install(version = "2.1.0")


# connect to local version of spark
sc <- spark_connect(master = "local")

# connect to MySQL database
config <- spark_config()
config$`sparklyr.shell.driver-class-path` <- 
  "~/Downloads/mysql-connector-java-5.1.48/mysql-connector-java-5.1.48-bin.jar"

sc <- spark_connect(master = "local", config = config)

spark_read_jdbc(sc, "person_jdbc",  options = list(
  url = "jdbc:mysql://localhost:3306/sparklyr",
  user = "root", password = "<password>",
  dbtable = "person"))

# open the Spark UI. Connections tab, Spark UI, opens browser
spark_web(sc)

# load data into the spark cluster

library(dplyr)
library(RSQLite)
ucsSat_tbl <- copy_to(sc, con, "PMCdb")

# if you receive MalformedInputException, check encoding of source data
src_tbls(sc) # shows tables in spark

# use dplyr (tidyverse) to manipulate Spark
ucsSat_tbl %>% filter(Class_of_Orbit == "LEO")

# or use SQL
library(DBI)
dbGetQuery(sc, "SELECT `Class_of_ORBIT` FROM spark_ucs LIMIT 5")  

# connect to db

df <- sparklyr::spark_read_jdbc(sc, 
                                name ="my_table" , 
                                options = list(url = "jdbc:sqlserver://<servername>.database.windows.net:<port>;database=<databasename>", 
                                               user = "<username>",
                                               driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver",
                                               password = secret$secret,
                                               dbtable = "<tablename>")) %>% 
  sparklyr::collect()

# maek SQL library in spark


