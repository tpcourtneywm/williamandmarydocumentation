import findspark
findspark.init()
import pyspark # only run after findspark.init()


from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, StringType
from pyspark.ml.recommendation import ALS
import sys
import codecs

spark = SparkSession.builder.appName("ALSExample").getOrCreate()
    
moviesSchema = StructType([ \ #set up your schema
                     StructField("userID", IntegerType(), True), \
                     StructField("movieID", IntegerType(), True), \
                     StructField("rating", IntegerType(), True), \
                     StructField("timestamp", IntegerType(), True)])

    
ratings = spark.read.option("sep", "\t").schema(moviesSchema) \
    .csv("file:///SparkCourse/ml-100k/u.data") #bring in data

namesSchema = StructType([ \ #set the names schema
                     StructField("movieID1", IntegerType(), True), \
                     StructField("movieName",StringType(), True)])

names = spark.read.option("sep", "|").schema(namesSchema) \
    .csv("file:///SparkCourse/ml-100k/u.item") #set the names schema
    


ratings.drop("userID","timestamp") #drop unnescessary data points



topMovieIDs = ratings.groupBy("movieID").count().orderBy("count", ascending=False).cache() #count the number of ratings


from pyspark.sql.functions import col

topMovieIDs = topMovieIDs.select(col("movieID").alias("xxx"),col("count").alias("Count")) #rename so the join makes sense


inner_join = topMovieIDs.join(ratings, ratings.movieID == topMovieIDs.xxx) #join the data

inner_join = inner_join.select('movieID','count','rating') #join and select necessary columns


inner_join = inner_join.filter(inner_join['count']>100) #filter to only see ones greater than 100


avg_ratings=inner_join.groupBy("MovieID").avg('rating') #average the ratings


inner_join = inner_join.drop("rating") #drop the ratings duplicates
inner_join = inner_join.select(col("movieID").alias("movie_ID_xxx"),col("count").alias("Count")) 

final_view = inner_join.join(avg_ratings, avg_ratings.MovieID == inner_join.movie_ID_xxx) #join the average ratings and the counts
final_view = final_view.drop("Movie_ID_xxx")


final_view = final_view.distinct() #remove duplicate values

final_view_wNAMES = final_view.join(names, names.movieID1 == final_view.MovieID) #join names and average ratings
final_view_wNAMES = final_view_wNAMES.drop("MovieID", "movieID1") #drop unnecessary columns


final_view_wNAMES = final_view_wNAMES.orderBy(col("avg(rating)").desc()).show() #sort by average


# !spark-submit popular-movies-dataframe_FINAL.py > pmd_final.txt