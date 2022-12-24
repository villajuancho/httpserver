FROM ubuntu:latest

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/init-cron
ADD initset.sh /etc/cron.d/run/initset.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/init-cron
RUN chmod 0777 /etc/cron.d/run/initset.sh

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron


# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
