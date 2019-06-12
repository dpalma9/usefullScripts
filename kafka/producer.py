from kafka import KafkaProducer
import json

server="kafkaSever:9092"
producer = KafkaProducer(bootstrap_servers=[server],
                         value_serializer=lambda x:
                         json.dumps(x).encode('utf-8'))

#Send json
data = {'Prueba1': "cosaaas"}
topic = 'myTopic'
producer.send(topic, value=data)
producer.flush()

