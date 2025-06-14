import fileinput
import datetime 

current_ts = datetime.datetime.now()

with fileinput.input(['beerwulf_dbt/seeds/user_events_mock.csv']) as source, open('beerwulf_dbt/seeds/user_events_mock_enrichied2.csv','w') as output:
    for line in source:
        if fileinput.isfirstline():
            updated_header = line.rstrip('\n') + ',ingestion_timestamp\n'
            output.write(updated_header)
        else:
            updated_line = line.rstrip('\n') + f',{current_ts}\n'
            output.write(updated_line)