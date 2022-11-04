import paho.mqtt.client as mqtt
import datetime
import time
import numpy as np
import json

### Define the client ###
# mqtt broker adress
broker_adress="broker.hivemq.com"
# define the client
client = mqtt.Client(client_id="P1jonasischready",clean_session=False) # use your own unique ID
# connect the client
client.connect(broker_adress)

# create sample json as dict
json_dict = {"fin":"WDDU411STM9032150", "zeit":"01.01.2020 15:34:05.123", "geschwindigkeit":200, "ort":1}

### Publish forever ###
# publish at nearly exact 5 s
target_time = time.perf_counter_ns()
while True:
    target_time += 5 * 10**9
    # change the time to the current time
    json_dict["zeit"] = str(datetime.datetime.now())
    json_dict["geschwindigkeit"] = np.random.randint(0, high=200)
    # publish the dict
    client.publish("DataMgmt/FIN",json.dumps(json_dict), qos=1)
    print(f"Published: {json.dumps(json_dict)}")

    # wait to get nearly exakt 5 s delay
    while time.perf_counter_ns() < target_time:
        pass


