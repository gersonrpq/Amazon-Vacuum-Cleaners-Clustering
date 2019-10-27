data <- read.csv('clean_data.csv')
data <- data[,-c(1,2)]

data <- scale(data)
write.csv(data,'data.csv')

wss<-(nrow(data-1)*sum(apply(data,2,var)))
for(i in 2:20) wss[i] <- sum(kmeans(data,center=i)$withinss)
plot(1:20, wss, type="b",xlab="Number of clusters", ylab = "Withinss")

#According to Elbow Method, the best number of cluster would be 8

mycluster<- kmeans(data, 8, nstart=5, iter.max = 50)

{library(fmsb)
par(mfrow=c(2,4))

dat<- as.data.frame(t(mycluster$centers[1,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[2,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[3,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[4,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[5,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[6,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[7,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)

dat<- as.data.frame(t(mycluster$centers[8,]))
dat <- rbind(rep(2,10),rep(-1.4,10),dat)
radarchart(dat)
}

# The radarchart graphics can be seen to know the 
#characteristics of every cluster