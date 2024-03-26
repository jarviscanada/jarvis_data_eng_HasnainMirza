# Initialize Variables 

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5


# Error check for number of arguments 

if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Initialize hardware specs to variables

vmstat_mb=$(vmstat --unit M)
hostname=$(hostname -f)
vmstat_disk=$(vmstat -d)

# Save the values of the harware specs with meaninhful variables

# host_id = $(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)
timestamp=$(vmstat -t | awk '{print $18" "$19}'| tail -n1)
memory_free=$(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)
cpu_idle=$(echo "$vmstat_mb"| awk '{print $15}' | tail -n1 | xargs)
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $14}' | tail -n1 |xargs)
disk_io=$(echo "$vmstat_disk" | awk '{print $10}' | tail -n1 | xargs)
disk_available=$(df -BM / | awk '{print $4}' | tail -n1 | sed 's/M//')

# SQL Query for host id 
#host_id="(SELECT id FROM host_info WHERE hostname='$hostname')"
insert_stmt="INSERT INTO host_usage (\"timestamp\", memory_free, cpu_idle, cpu_kernel, disk_io, disk_available) 
VALUES('$timestamp',$memory_free,$cpu_idle,$cpu_kernel,$disk_io,$disk_available);"

# Set the Psql instance  
export PGPASSWORD=$psql_password 
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
