from pyspark.sql import SparkSession

def init():
    spark = SparkSession.builder.appName("HelloWorld").getOrCreate()
    sc = spark.sparkContext
    return spark,sc

def main():
    spark,sc = init()
    nums = sc.parallelize([1,2,3,4])
    loggerFactory = sc._jvm.org.apache.log4j 
    logger = loggerFactory.LogManager.getLogger("helloworld-spark") 

    configurations = spark.sparkContext.getConf().getAll()
    for conf in configurations:
        logger.info(conf)

    logger.info("Application Started")
    logger.info(nums.map(lambda x: x*x).collect())
    logger.info("Application Finished")

if __name__ == '__main__':
    main()
