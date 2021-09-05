# Use base image tidyverse
FROM rocker/tidyverse

# copy the app to the image
RUN mkdir /root/app
COPY  app.r /root/app/

# copy library requirements to the image
COPY Rpackages .

# install R libraries to the image
RUN Rscript Rpackages

# expose shiny port 3838 
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/app/app.r', port = 3838, host = '0.0.0.0')"]

