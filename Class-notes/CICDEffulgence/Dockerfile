#Use the Amazon Linux 2 base images
FROM amazonlinux:2
MAINTAINER Brigthain Kargong
# Update the package manager and install httpd
RUN yum update -y && \
    yum install -y httpd && \
    yum clean all

# Copy the index.html file to the Apache document root
COPY index.html /var/www/html/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start the Apache service when the container starts
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

