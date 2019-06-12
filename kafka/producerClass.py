import os
import json
from kafka import KafkaProducer


class Kafka_producer:
    kafka_service = os.environ.get('KAFKA_SERVER')
    kafka_port = os.environ.get('KAFKA_PORT')
    server = kafka_service + ':' + kafka_port
    topic = "myTopic"


    def __init__(self):
        self.producer = KafkaProducer(bootstrap_servers=[self.server],
                        value_serializer=lambda x:
                        json.dumps(x).encode('utf-8'))

    def send_data(self, data):
        jsonSchema = self.__read_json_data(data)
        self.producer.send(self.topic, value=jsonSchema)
        self.producer.flush()

    def __read_json_data(self,jsonData):
        with open(jsonData,'r') as schema_file:
            schema_data = schema_file.read()
        schema = json.loads(schema_data)
        return schema

    def set_producer_topic(self, kafka_topic):
        self.kafka_topic = kafka_topic

def main():
    print("Testing kafka producer class")

if __name__ == '__main__':
    main()

