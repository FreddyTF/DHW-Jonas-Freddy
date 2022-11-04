import paho.mqtt.client as mqtt
import datetime
import time

### Define the client ###
# mqtt broker adress
broker_adress="broker.hivemq.com"
# define the client
client = mqtt.Client(client_id="P1freddyischready",clean_session=False) # use your own unique ID
# connect the client
client.connect(broker_adress)

# create sample json as dict
json_dict = {"fin":"lustigeFin", "zeit":"01.01.2020 15:34:05.123", "geschwindigkeit":60, "ort":10}

### Publish forever ###
# publish at nearly exact 5 s
target_time = time.perf_counter_ns()
while True:
    target_time += 5 * 10**9
    # change the time to the current time
    json_dict["zeit"] = str(datetime.datetime.now())
    # publish the dict
    client.publish("DataMgmt/FIN",str(json_dict), qos=1)
    print(f"Published_ {json_dict}")

    # wait to get nearly exakt 5 s delay
    while time.perf_counter_ns() < target_time:
        pass


