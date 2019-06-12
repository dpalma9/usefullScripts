import json
from kafka import KafkaConsumer

kafka_server='kafkaServer:9092'
consumer = KafkaConsumer(bootstrap_servers=kafka_server,
                         auto_offset_reset='earliest',
                         value_deserializer=lambda m: json.loads(m.decode('utf-8')))

topic="myTopic"
consumer.subscribe([topic])
for message in consumer:
    print ("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,
                                          message.offset, message.key,
                                          message.value))
