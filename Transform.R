raw_data <- read.csv('raw_data.csv')
raw_data <- as.data.frame(raw_data)
raw_data <- raw_data[,2:8]

library(stringr)

#Processing Price
raw_data$Price <- as.character(raw_data$Price)
raw_data$Price <- gsub('€','',raw_data$Price)
raw_data$Price <- gsub(',','.',raw_data$Price)
raw_data$Price <- as.numeric(raw_data$Price)
mean_price <- mean(raw_data$Price, na.rm = TRUE)
raw_data$Price[is.na(raw_data$Price)] <- mean_price

#Processing Opinions
raw_data$Opinions <- as.character(raw_data$Opinions)
raw_data$Opinions <- gsub('opiniones de clientes','',raw_data$Opinions)
raw_data$Opinions <- gsub('opinión de cliente','',raw_data$Opinions)
raw_data$Opinions <- gsub(',','',raw_data$Opinions)
raw_data$Opinions <- as.numeric(raw_data$Opinions)
mean_opinion <- as.integer(mean(raw_data$Opinions, na.rm = TRUE))
raw_data$Opinions[is.na(raw_data$Opinions)] <- mean_opinion

#Processing Product_Weight
raw_data$Product_Weight <- as.character(raw_data$Product_Weight)
raw_data$Product_Weight <- gsub('Kg','',raw_data$Product_Weight)
raw_data$Product_Weight <- gsub(',','.',raw_data$Product_Weight)
raw_data$Product_Weight[str_detect(raw_data$Product_Weight,'g')] = as.numeric(gsub('g','',raw_data$Product_Weight[str_detect(raw_data$Product_Weight,'g')]))/1000
raw_data$Product_Weight <- gsub('-1',NA,raw_data$Product_Weight)
raw_data$Product_Weight[raw_data$Product_Weight < 0.1 ] = NA
raw_data$Product_Weight <- as.numeric(raw_data$Product_Weight)
mean_product_weight <- mean(raw_data$Product_Weight, na.rm = TRUE)
raw_data$Product_Weight[is.na(raw_data$Product_Weight)] <- mean_product_weight

#Processing Product_Dimensions
raw_data$Product_Dimensions <- as.character(raw_data$Product_Dimensions)
raw_data$Product_Dimensions <- gsub('cm','',raw_data$Product_Dimensions)
raw_data$Product_Dimensions <- gsub(',','.',raw_data$Product_Dimensions)

dimensions <- as.data.frame(str_split_fixed(raw_data$Product_Dimensions,'x',3))
colnames(dimensions) <- c('Height','Width','Depth')

dimensions$Height <- gsub('-1','',dimensions$Height)
dimensions$Height <- as.numeric(dimensions$Height)
mean_height <- mean(dimensions$Height, na.rm=TRUE)
dimensions$Height[is.na(dimensions$Height)] <- mean_height

dimensions$Width[dimensions$Width==''] = NA
dimensions$Width <- as.numeric(dimensions$Width)
mean_width <- mean(dimensions$Width, na.rm=TRUE)
dimensions$Width[is.na(dimensions$Width)] <- mean_width

dimensions$Depth[dimensions$Depth==''] = NA
dimensions$Depth <- as.numeric(dimensions$Depth)
mean_depth <- mean(dimensions$Depth, na.rm=TRUE)
dimensions$Depth[is.na(dimensions$Depth)] = mean_depth

raw_data <- as.data.frame(c(raw_data,dimensions))
raw_data <- raw_data[,-5]

#Processing Volume
raw_data$Volume <- as.character(raw_data$Volume)
raw_data$Volume <- gsub('litros','',raw_data$Volume)
raw_data$Volume <- gsub('-1','',raw_data$Volume)
raw_data$Volume <- as.numeric(raw_data$Volume)                                
mean_volume <- mean(raw_data$Volume, na.rm=TRUE)
raw_data$Volume[is.na(raw_data$Volume)] <- mean_volume

#Processing Power
raw_data$Power <- as.character(raw_data$Power)
raw_data$Power <- gsub('vatios','',raw_data$Power)
raw_data$Power <- gsub('watt_hours','',raw_data$Power)
raw_data$Power <- gsub('kW','',raw_data$Power)
raw_data$Power <- gsub('-1','',raw_data$Power)
raw_data$Power <- as.numeric(raw_data$Power)
mean_power <- mean(raw_data$Power, na.rm=TRUE)
raw_data$Power[is.na(raw_data$Power)] <- mean_power


clean_data <- raw_data

write.csv(clean_data,'clean_data.csv')
