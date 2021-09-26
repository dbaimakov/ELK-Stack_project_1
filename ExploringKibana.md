## Activity File: Exploring Kibana

1. Add the sample web log data to Kibana.

2. Answer the following questions:

    - In the last 7 days, how many unique visitors were located in India?
    246

    - In the last 24 hours, of the visitors from China, how many were using Mac OSX?
    6
    - In the last 2 days, what percentage of visitors received 404 errors? How about 503 errors?
    5.479% and 4.11% 
    
    - In the last 7 days, what country produced the majority of the traffic on the website?
    China 306(19.2%)
    
    - Of the traffic that's coming from that country, what time of day had the highest amount of activity?
    12-1p.m.
    - List all the types of downloaded files that have been identified for the last 7 days, along with a short description of each file type
    css - A CSS file is a cascading style sheet (CSS) file used to format the contents of a webpage.
    deb - A file with the DEB file extension is a Debian Software Package file. They're used mainly in Unix-based operating systems, including Ubuntu and iOS.
    gz -  Files with GZ extension are compressed archives that are created by the standard GNU zip (gzip) compression algorithm.
    rpm - similar to the deb files, Red Hat Package Manager file that's used to store installation packages on Linux operating system.
    zip - ZIP is an archive file format that supports lossless data compression.
    
3. Now that you have a feel for the data, Let's dive a bit deeper. Look at the chart that shows Unique Visitors Vs. Average Bytes.
     - Locate the time frame in the last 7 days with the most amount of bytes (activity).
     Average Bytes: 15709
     Unique visitors: 1
     
     - In your own words, is there anything that seems potentially strange about this activity?
The number of unique visitors is very low in comparison to other times. During other times, such low number of unique visitors corresponds with lower number of 
bytes. Could be a sign of a user extracting data, but further research is needed.

4. Filter the data by this event.
     - What is the timestamp for this event?
     2021-09-19 22:57:28.552
     - What kind of file was downloaded?
     rpm
     - From what country did this activity originate?
     India
     - What HTTP response codes were encountered by this visitor?
     200

5. Switch to the Kibana Discover page to see more details about this activity.
     - What is the source IP address of this activity?
     35.143.166.159
     - What are the geo coordinates of this activity?
     "lat": 43.34121,
     "lon": -73.6103075
  - What OS was the source machine running?
  Win 8
     - What is the full URL that was accessed?
 https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.2-i686.rpm     
 - From what website did the visitor's traffic originate?
 http://facebook.com/success/jay-c-buckey
 
6. Finish your investigation with a short overview of your insights. 

     - What do you think the user was doing?
     Trying to download some free software
     - Was the file they downloaded malicious? If not, what is the file used for?
     They download the metricbeats file, which is used to show processing data
     - Is there anything that seems suspicious about this activity?
     Not really since it is normal to download files of the website
     - Is any of the traffic you inspected potentially outside of compliance guidlines?
     Not really, unless there was a big data download that would cap bandwidth; I would say this falls within normal behavior.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  
