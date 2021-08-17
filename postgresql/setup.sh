psql -f create-database.sql postgres postgres
psql -f create-tables.sql mercurii mercurius
psql -f insert-tables.sql mercurii mercurius