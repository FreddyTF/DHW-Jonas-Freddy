import paho.mqtt.client as mqtt
import psycopg2
import numpy as np
import json
import datetime

### Connection to the database ###
# connect to the database
conn = psycopg2.connect("dbname='staging' user='postgres' password='postgreSQL' host='localhost' port='5432'")
# create a cursor
cur = conn.cursor()

### Test the connection to the db and show the version ###
# execute a statement
print('PostgreSQL database version:')
cur.execute('SELECT version()')
# display the PostgreSQL database server version
db_version = cur.fetchone()
print(db_version)


def on_message(client, userdata, msg):
    print(f"Message received [{msg.topic}]: {msg.payload}")
    json_object = None
    try:
        json_object = json.loads(msg.payload.decode("utf-8"))
    except:
        print("invalid json")
        json_object = None
    if json_object:
        sql = f"INSERT INTO staging.messung(payload, erstellt_am ,quelle) VALUES ('{msg.payload.decode('utf-8')}', '{json_object['zeit']}','S1freddyischread');"
        print(f"SQL Statement: {sql}")
        try:
            # execute the INSERT statement
            cur.execute(sql)
            # commit the changes to the database
            conn.commit()
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally:
            pass


def on_connect(client, userdata, flags, rc):
    # This will be called once the client connects
    print(f"Connected with result code {rc}")
    # Subscribe here!
    client.subscribe("DataMgmt/FIN", qos=1)

### The the mqtt client ###
# define the broker adress
broker_address="broker.hivemq.com"
# create the client
client = mqtt.Client(client_id="S1freddyischread", clean_session=False) #use your own unique ID
# define the callbacks
client.on_connect = on_connect
client.on_message = on_message
# connect to the broker
client.connect(broker_address)
# run the client
client.loop_forever()