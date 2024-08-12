#! /bin/bash
SERVER_ID_LIST=$(speedtest-cli --list | grep -oE '^[0-9]+')

speedtest-cli --csv-header &> speedtest_9.csv
while true; do
    for id in $SERVER_ID_LIST; do
        timestamp="$(date +"%T")"
        start_time=$(date +%s)

        echo "Initiating test with server ID: $id, $(date +%c)"
        speedtest-cli --csv --server $id &>> speedtest_9.csv
        result=$(speedtest-cli --csv --server $id)S
        end_time=$(date +%s)
        elapsed=$((end_time - start_time))
        echo "Test completed in $elapsed seconds."
        echo "Done"
    done
    
    if [[ -z "$1" ]]; then
        echo "No sleep time. Script ended."
        break
    else
        sleep_time="$1"
        echo "Sleeping for $sleep_time seconds..."S
        sleep $sleep_time
        echo "Repeating tests..."
    fi
done