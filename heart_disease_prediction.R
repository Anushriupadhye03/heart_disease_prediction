library(tidyverse)
data <- read.csv("C:/Users/aayus/Downloads/heart.csv")
head(data)
tail(data)
glimpse(data)
ncol(data)
nrow(data)
colnames(data)
summary(data)
data2 <- data %>%
  mutate(sex = if_else(sex == 1, "MALE", "FEMALE"),
         fbs = if_else(fbs == 1, ">120", "<=120"),
         exang = if_else(exang == 1, "YES" ,"NO"),
         cp = if_else(cp == 1, "ATYPICAL ANGINA",
                      if_else(cp == 2, "NON-ANGINAL PAIN", "ASYMPTOMATIC")),
         restecg = if_else(restecg == 0, "NORMAL",
                           if_else(restecg == 1, "ABNORMALITY", "PROBABLE OR DEFINITE")),
         slope = as.factor(slope),
         ca = as.factor(ca),
         thal = as.factor(thal),
         target = if_else(target == 1, "YES", "NO")
  ) %>% 
  mutate_if(is.character, as.factor) %>% 
  dplyr::select(target, sex, fbs, exang, cp, restecg, slope, ca, thal, everything())
# Bar Plot for target (heart disease)

ggplot(data2, aes(x=data2$target, fill=data2$target))+
  geom_bar()+
  xlab("Heart Disease")+
  ylab("count")+
  ggtitle("Presence & Absence of Heart Disease")+
  scale_fill_discrete(name= 'Heart Disease', labels =c("Absence", "Presence"))
prop.table(table(data2$target))
# count the frequency of the values of age

data2 %>%
  group_by(�..age) %>%
  count() %>%
  filter(n>10) %>%
  ggplot()+
  geom_col(aes(�..age, n), fill = 'green')+
  ggtitle("Age Analysis")+
  xlab("Age")+
  ylab("Agecount")
# comapre blood pressure across the chest pain

data2 %>%
  ggplot(aes(x=sex, y=trestbps))+
  geom_boxplot(fill ='purple')+
  xlab('sex')+
  ylab('BP')+
  facet_grid(~cp)
data %>%
  ggplot(aes(x=sex, y=trestbps))+
  geom_boxplot(fill ='purple')+
  xlab('sex')+
  ylab('BP')+
  facet_grid(~cp)
data2 %>%
  ggplot(aes(x=sex, y=chol))+
  geom_boxplot(fill ='orange')+
  xlab('sex')+
  ylab('Chol')+
  facet_grid(~cp)
install.packages("corrplot")
install.packages("ggplot2")
library(corrplot)
library(ggplot2)
cor_heart <- cor(data2[, 10:14])
cor_heart

corrplot(cor_heart, method ='square', type='upper')
