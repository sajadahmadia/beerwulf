# Answers

## Introduction: 
For this project, I used a tech stack of dbt and postges. I chose dbt because of its capablities that let us bring best practicies in software engineering to the world of sql scripts. It comes in with extendable modules, yml config files, built-in CI/CD capablities, data quality tests, and has an open source version. 
The reason that I chose postgres was because it is an open source database (as required by the case) and also we can create multiple schemas under one database (I used this feature for implementing the medallion architecture of my transformation logic).
- To get a visual picture of the project, you can use the 3 pictures provided in the `docs` directory. 

The instructions on how to run the project are given in the `HOW_TO_RUN.md` file. 

## Tech Stack:
* database: Postgressql (via Docker)
* Transformation: DBT 

## Answers to the main questions:
Below, you can find the answers and instructions regarding my implementation of the project:

* The final fact-dimension modeling scripts are provided in the beerwulf_dbt/models directory. 
    - I followed a Medallion architecture (bronze-silver-gold) for better structuring the project. The scripts for each layer is located at its corresponding folder.
    - To run the project, please visit the HOW_TO_RUN.md file. There, you can find detailed instructions on how to run this project.
    - Load scripts: The load scripts are located in the `initdb` directory. 
        * initdb/00-create-schemas.sql: creates schemas 
        * initdb/01-ingestion_zone_ddl.sql: ddl scripts, with relaxed (loosened) schema, to make the ingestion process more resilient, allowing raw data to be loaded even when it doesn’t fully conform to strict types or constraints.
        * notice that based on the HOW_TO_RUN.md, I've made some shell scripts (in the `shell_scripts` directory) that run the mentioned load scripts automatically. scripts are re-runable, so you can run it as many times as you want with affecting the final results.
        * ERD file of the final model is provided at this path `beerwulf_dbt/assets/gold_schema_erd.png`. It will also render in the first page of the dbt documentation server when you run it. ![star schema](https://github.com/sajadahmadia/beerwulf/blob/main/beerwulf_dbt/assets/gold_schema_erd.png)
   

* Answers to the business questions using the created fact-dimension model:
    - The sql scripts for this part are located at `beerwulf_dbt/models/marts`. 

    a. What are the bottom 3 nations in terms of revenue?
        - script: `beerwulf_dbt/models/marts/bottom_3_nations_by_revenue.sql`
        - results: 

        | nation_name    | total_revenue |
        |----------------|---------------|
        | FRANCE         | 54431694      |
        | CHINA          | 65868584      |
        | UNITED STATES  | 65951276      |


    b. From the top 3 nations, what is the most common shipping mode?
        - script: `beerwulf_dbt/models/marts/top_3_nations_shipping_mode.sql`
        - results: 

        | top_shipment_method | shipment_count |
        |---------------------|----------------|
        | MAIL                | 1326           |


    c. What are the top 5 selling months? calculated based on total revenue
        - script: `beerwulf_dbt/models/marts/top_5_selling_months.sql`
        - results: 

        | year | month | month_name | monthly_revenue | order_count |
        |------|-------|------------|-----------------|-------------|
        | 1993 | 10    | October    | 31176188        | 201         |
        | 1993 | 12    | December   | 31122508        | 216         |
        | 1992 | 1     | January    | 30878747        | 203         |
        | 1996 | 8     | August     | 30497241        | 210         |
        | 1995 | 12    | December   | 30439158        | 217         |

    d. Who are the top customer(s) in terms of either revenue or quantity?
        - script: `beerwulf_dbt/models/marts/top_customers_revenue_quantity.sql`
        - results: 

    | customer_key | customer_name        | total_revenue | total_line_item_quantity | total_order_count |
    |-------------:|:---------------------|--------------:|-------------------------:|------------------:|
    |         1489 | Customer#000001489   |       5457271 |                     3868 |                29 |
    |          214 | Customer#000000214   |       4742500 |                     3369 |                25 |
    |           73 | Customer#000000073   |       4714756 |                     3384 |                30 |
    |         1396 | Customer#000001396   |       4678180 |                     3408 |                28 |
    |         1246 | Customer#000001246   |       4676316 |                     3226 |                27 |
    |          643 | Customer#000000643   |       4585648 |                     3201 |                32 |
    |         1150 | Customer#000001150   |       4557905 |                     3181 |                28 |
    |         1318 | Customer#000001318   |       4545914 |                     3229 |                29 |
    |          898 | Customer#000000898   |       4527601 |                     3309 |                32 |
    |          943 | Customer#000000943   |       4513235 |                     3229 |                29 |

    e.Compare the sales revenue on a financial year-to-year (01 July to 30 June) basis.
    - script: `beerwulf_dbt/models/marts/fiscal_revenue_comparison.sql`
    - results: 

    | fiscal_year | current_year_revenue | previous_year_revenue | revenue_growth_pct |
    |-----------:|---------------------:|----------------------:|-------------------:|
    |        1991 |           166760066 |                  NULL |              NULL |
    |        1992 |           316312476 |             166760066 |             89.68 |
    |        1993 |           342780431 |             316312476 |              8.37 |
    |        1994 |           317890996 |             342780431 |             -7.26 |
    |        1995 |           325880103 |             317890996 |              2.51 |
    |        1996 |           335094235 |             325880103 |              2.83 |
    |        1997 |           318227058 |             335094235 |             -5.03 |
    |        1998 |            29245339 |             318227058 |            -90.81 |
