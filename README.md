# PostgresqlMonitor

Projekt ASK
Damian Tabański
Temat: Web application for monitoring Postgres database (transactions, stats, long queries)

1.	Wybrana technologia
Aplikacja ASP .NET WebForms + Entity Framework

2.	Użyte biblioteki
- jquery
- bootstrap (layout, multiselect, left menu)
- Chart.js

3.	Opis projektu
Celem aplikacji jest monitorowanie baz danych opartych na serwerze bazodanowym Postgres. Dane do aplikacji dostarczane z dzięki modułowi 
pg_stat_statements, który można skonfigurować w pliku konfiguracyjnym postgresql.conf. Moduł ten dostarcza wszystkie dane, które są 
wyświetlane w aplikacji. Do przedstawiania danych w czytelnej formie użyłem tabelę, która obsługuje paginacje oraz sortowanie 
(po wszystkich kolumnach). Dodatkowo możemy w dowolny sposób modyfikować wyświetlane kolumny jak i nałożyć założyć filtr na dane.
Tabela automatycznie odświeżana jest co 30 sekund. W każdym momencie możemy zmienić widok strony na podgląd wykresu zależności QueryId 
od Calls. Wykres generowany jest z obecnie wyświetlanych danych w tabelce.
