import fileinput
import datetime
import csv

current_timestamp = datetime.datetime.now().isoformat()


with open('beerwulf_dbt/seeds/user_events_mock.csv', 'r') as source, open('beerwulf_dbt/seeds/user_events_mock_enriched.csv', 'w', newline='') as target:
    reader = csv.reader(source)
    rows = list(reader)

    writer = csv.writer(target)
    header = rows[0] + ['ingestion_timestamp']
    writer.writerow(header)

    for row in rows[1:]:
        writer.writerow(row + [current_timestamp])
