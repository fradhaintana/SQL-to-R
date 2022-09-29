library(DBI)
library(RSQLite)
library(tidyverse)

Dating <- DBI::dbConnect(RSQLite::SQLite(),
                             "C:/Users/icebb/Downloads/S2 IPB/Semester 1/Data Sains/Pertemuan 2/users_lovoo_v3.db")
class(Dating)
RSQLite::dbListTables(Dating) #MAU MELIHAT TABEL yang ada di data
ob <-dplyr::tbl(Dating,"objects") #mau panggil tabel mana yang digunakan
class(ob)
ob #meilihat isi dari tabel ob ada apa aja
#kalau mau analisis data harus pakai package dplyr ke data SQL kita

a <- ob%>% #harus dikasih nama baru agar data yang terbaru yang terpanggil berikutnya
  select(name, age, gender, city)%>% #urutan jadinya
  filter(age>20)%>%
  group_by(city)%>%
  arrange(age)
a

#kalau mau lihat hasil syntax kita diatas ketika diimport ke SQL seperti apa
dplyr::show_query(a)

#kalau mau ngetik di R tapi formatnya SQL
tbl(Dating, sql("SELECT name, age, gender, city FROM objects
WHERE age > 20 ORDER BY age LIMIT 10"))

#SYNTAX DI R mau lihat dan pakai limit
tbl(Dating,"objects")%>%
  select(city)%>%
  head(n=10)
