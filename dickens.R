library(dplyr)
library(gutenbergr)
library(tidytext)
library(wordcloud)

gutenberg_works(title=='A Tale of Two Cities')

dickens<-gutenberg_download(98)

nrc<-get_sentiments('nrc')
unique(nrc$sentiment)

fear_words<-nrc%>%
  filter(sentiment == 'fear')

dickens_words<-dickens%>%
                  unnest_tokens(word,text)

dickens_words$gutenberg_id<-NULL



dickens_fear<-inner_join(dickens_words,fear_words)



fear_freq<-dickens_fear%>%
                  group_by(word)%>%
                  summarize(count=n())

wordcloud(fear_freq$word,fear_freq$count,min.freq=5)

########################################################
joy_words<-nrc%>%
  filter(sentiment == 'joy')

dickens_words<-dickens%>%
  unnest_tokens(word,text)

dickens_words$gutenberg_id<-NULL

dickens_joy<-inner_join(dickens_words,joy_words)

joy_freq<-dickens_joy%>%
  group_by(word)%>%
  summarize(count=n())

wordcloud(joy_freq$word,joy_freq$count,min.freq=3)