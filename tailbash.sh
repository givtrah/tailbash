#!/usr/bin/env bash

# Check if the domain and optional dry-run flag are provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 domain [--dry-run]"
    exit 1
fi

domain=$1
dry_run=false

# Check for the dry-run flag
if [ $# -eq 2 ] && [ "$2" == "--dry-run" ]; then
    dry_run=true
    output_file="hosts.dryrun"
else
    output_file="/etc/hosts"
fi

# Comment to identify tailbash entries
comment="# tailbash"

# Remove existing tailbash entries
if [ "$dry_run" = false ]; then
    sudo sed -i "/$comment/d" "$output_file"
else
    sed -i "/$comment/d" "$output_file"
fi

# Process each line from the piped input
while read -r line; do
    # Extract IP address and hostname
    ip_address=$(echo "$line" | awk '{print $1}')
    hostname=$(echo "$line" | awk '{print $2}')

    # Append to the output file with a comment and domain
    if [ "$dry_run" = false ]; then
        echo "$ip_address $hostname $hostname.$domain $comment" | sudo tee -a "$output_file" > /dev/null
    else
        echo "$ip_address $hostname $hostname.$domain $comment" >> "$output_file"
    fi
done

if [ "$dry_run" = false ]; then
    echo "Hosts file updated successfully!"
else
    echo "Dry run completed. Check the file $output_file for the changes."
fi
