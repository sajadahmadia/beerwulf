Instructions on how to run this project:
To implement the following steps, you need to be in the root folder of the current directory:
1. create a python environment using `python3.11 -m venv .venv` and activate it `source .venv/bin/activate`. 
2. install the required libraries using `pip install -r requirements.txt`
3. run the dockerized postgres service `docker-compose up -d`
    - it loads the postgres service on port 5435 of your local machine
    - a UI interface (adminer) to interact with the database will be provided on port 8083 of your local machine. you can interact with it using:
            - POSTGRES_USER: admin
            - POSTGRES_DB: bearwulf
            - POSTGRES_PASSWORD: pgadmin_bear
4. install libpq on your OS. it gives access to psql commands that the upcoming shell scripts will use.
5. make all the shell scripts in the ./shell_scripts directory executable using: `chmod +x shell_scripts/*.sh`
6. run all of the shell scripts in the shell_scripts directory using:
    - ./shell_scripts/00_create_schemas.sh to (drop current schemas on cascase) adn create 5 new schemas
    - ./shell_scripts/01_create_landing_zone_tables.sh to create landing_zone schema tables using the provided schema at `initdb/01-ingestion_zone_ddl.sql` (relaxed schema to make the ingestion process more resilient)
    - ./shell_scripts/02_remove_trailer.sh to remove the trailing pipe (|) at the end of lines
    - ./shell_scripts/03_import_table_data.sh to import the data into the landing_zone tables
    - ./shell_scripts/04_assertion_row_counts.sh: assertion for the number of lines in the tables to be equal to the number of lines in the files
    - ./shell_scripts/05_create_dbt_profile.sh: creates the profile.yml file of dbt

    ```bash
    find shell_scripts -maxdepth 1 -type f -name "*.sh" \
    | sort -V \
    | while read script; do
        echo "↪︎ Running $script…"
        bash "$script"
        done

7. notice: checkc you have installed dbt core and dbt-postgres, if not, run: `pip install dbt-core dbt-postgres`
8. create a dbt project in the current root: `dbt init beerwulf_dbt`
9. check dbt profile.yml content to correspond with the connection config for your database: nano ~/.dbt/profiles.yml
10. check beerwulf_dbt/dbt_project.yml and make sure that profile parameter is set to: 'beerwulf_profile'
11. move to beerwulf_dbt via cli (cd beerwulf_dbt), and run (dbt debug) to make sure dbt is connected to the database and your profile and prject yml files are aligned. you should see: All checks passed! 
12. from now on, the transformation starts. we use dbt and its connection to transform our data, create the tables in the bronze, silver, gold, and marts schemas. 
    * notice that to run any dbt commands, your current directory should be `beerwulf_dbt`
13. change your director to `beerwulf_dbt` and install dbt packages: `dbt deps`
14. run dbt transformations: `dbt run`
15. run dbt tests: `dbt test`
16. generate and view documentation: `dbt docs generate && dbt docs serve`
    - it will use the port 8080 of your machine, make sure it's available. otherwise, first run `dbt docs generate` and then serve it on an available port like `dbt docs serve --port 8888`