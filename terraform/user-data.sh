#!/bin/bash


# Wait for cloud-init to finish initializing the machine
cloud-init status --wait

# Setting DEBIAN_FRONTEND to ensure non-interactive operations for APT
export DEBIAN_FRONTEND=noninteractive

# update and set-up docker 
timeout 10m bash -c 'until sudo apt -qqq --yes update && \
 sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && \
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y && \
 sudo apt -qqq --yes install docker-ce; do sleep 10; \
done'

sudo usermod -aG docker ubuntu

# Create the script directory and script file
sudo mkdir --parents "/home/ubuntu/script"
sudo cat > /home/ubuntu/script/script.bash <<EOF
#!/bin/bash

# Define variables
IMAGE_NAME="kaytheog/cloudheight:edge"
CONTAINER_NAME="application"

# Function to check for new image on Docker Hub
check_for_new_image() {
    local latest_image=\$(docker pull \$IMAGE_NAME | grep "Status: Image is up to date" | wc -l)
    if [ \$latest_image -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Function to stop and remove the current container
stop_and_remove_container() {
    docker stop \$CONTAINER_NAME
    docker rm \$CONTAINER_NAME
}

# Function to run the new image in a container
run_new_image() {
    docker run -d --name \$CONTAINER_NAME -p 8080:8080  \$IMAGE_NAME
}

# Main function
main() {
    if check_for_new_image; then
        stop_and_remove_container
        run_new_image
        echo "New image pulled and container restarted."
    else
        echo "No new image available. Exiting."
    fi
}
main
EOF

# Make the script executable
sudo chmod +x /home/ubuntu/script/script.bash

# Setup cron job to run the script every minute
# for continoues
(sudo crontab -l 2>/dev/null; echo "* * * * * /home/ubuntu/script/script.bash > /home/ubuntu/script/script_log.txt 2>&1") | sudo crontab -

