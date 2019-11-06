# Amazon-Vacuum-Cleaners-Clustering

Amazon vacuum cleaners clustering is a project of where data is extracted using web scraping techniques, cleaned so that data can be used and them a clustering algorithm is used to identify the groups of the vacuum cleaners.

Data is extracted with the file "Extract.R" and scraped from [Amazon][1] were 200 types of Vacuum cleaners and their description would be saved in the file "raw_data.csv".

After extracting, the process of data wragling starts cleaning values, filling missing data and saving a new file "clean_data.csv" where all data is found.

To make sure data can be used in a unsupervised machine learning algorithm, data is scaled and saved in the file "data.csv" elbow method is applied to know what is the best number of clusters, this all happens in the file "Applying Kmeans.R".

Once that the number of cluster is known a description of the information can be seen in radarchart graphics.

An interactive app is also used ([Shiny app][2]), and the variables to be evaluated can be paired and the number of clusters changeable.

[1]: https://www.amazon.es/s?k=aspiradoras&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&ref=nb_sb_noss_2
[2]: https://shiny.rstudio.com/gallery/kmeans-example.html
