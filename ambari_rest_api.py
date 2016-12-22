#!/usr/bin/env python

import sys
import json
import subprocess
import traceback
import shlex
import time
import logging
from pprint import pprint
from StringIO import StringIO
from urlparse import urljoin

CLUSTER_NAME = "ggg"
AMBARI_REST_TEMPLATE = "/usr/bin/curl -u admin:admin "
AMBARI_POST_TEMPLATE = "-H 'X-Requested-By: ambari' -X PUT "
AMBARI_ENDPOINT = "http://c6801.ambari.apache.org:8080/api/v1/"

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

class AmbariClient(object):
    def __init__(self, cluster_name):
        self._endpoint = AMBARI_ENDPOINT
        self._cluster_name = cluster_name

    def _get(self, locate):
        command = "{0} -G '{1}'".format(
            AMBARI_REST_TEMPLATE, urljoin(AMBARI_ENDPOINT, locate))
        logger.debug("Actual command: `{0}`".format(command))
        p = subprocess.Popen(shlex.split(command),
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        return json.loads(stdout)

    def _post(self, request, locate):
        command = "{0} {1} -d '{2}' {3}".format(
            AMBARI_REST_TEMPLATE, AMBARI_POST_TEMPLATE, json.dumps(request),
            urljoin(AMBARI_ENDPOINT, locate))
        logger.debug("Actual command: `{0}`".format(command))
        p = subprocess.Popen(shlex.split(command),
            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, _ = p.communicate()
        return json.loads(stdout)

    def get_services(self):
        return self._get("clusters/{0}/services".format(self._cluster_name))

    def get_service_info(self, service_name):
        return self._get("clusters/{0}/services/{1}".format(self._cluster_name, service_name))

    def start_all_services(self):
        request = {"RequestInfo": {"context": "Start All Services via REST"},
                "Body": {"ServiceInfo": {"state": "STARTED"}}}
        return_json = self._post(request, "clusters/{0}/services".format(self._cluster_name))
        if any(["Requests" not in return_json, "status" not in return_json["Requests"], 
            return_json["Requests"]["status"] != "Accepted"]):
            raise subprocess.CalledProcessError
        return_json = self.get_services()
        service_names = [service["ServiceInfo"]["service_name"] for
                         service in return_json["items"]]

        # continue polling until when all serivces are started
        while True:
            service_info = [self.get_service_info(service_name) for
                            service_name in service_names]
            
            if all([True if info["ServiceInfo"]["state"] == "STARTED" else False
                   for info in service_info]):
                print("All Services Started!")
                return
            print("Still processing...")
            time.sleep(1.0)

    def stop_all_services(self):
        request = {"RequestInfo": {"context": "Stop All Services via REST"},
                "Body": {"ServiceInfo": {"state": "INSTALLED"}}}
        return_json = self._post(request, "clusters/{0}/services".format(self._cluster_name))
        if any(["Requests" not in return_json, "status" not in return_json["Requests"], 
            return_json["Requests"]["status"] != "Accepted"]):
            raise subprocess.CalledProcessError
        return_json = self.get_services()
        service_names = [service["ServiceInfo"]["service_name"] for
                         service in return_json["items"]]

        # continue polling until when all serivces are stopped
        while True:
            services_info = [self.get_service_info(service_name) for
                            service_name in service_names]

            # 'INSTALLED' means 'stopped'
            if all([True if info["ServiceInfo"]["state"] == "INSTALLED" else False
                   for info in services_info]):
                print("All Services Stopped!")
                return
            print("Still processing...")
            time.sleep(1.0)

def usage():
    print("Usage: python ./{0} (start_all|stop_all|get_services)".format(__file__))

def main():
    ac = AmbariClient(CLUSTER_NAME)
    try:
        if len(sys.argv) == 1: 
            usage()
            return 1
        if sys.argv[1] == "start_all":
            ac.start_all_services()
        elif sys.argv[1] == "stop_all": 
            ac.stop_all_services()
        elif sys.argv[1] == "get_services":
            pprint(ac.get_services())
        else:
            usage()
            return 1
    except subprocess.CalledProcessError:
        # if one of the rest api is failed, this error would be thrown
        traceback.print_exc()
        return 1
    return 0

if __name__ == "__main__":

    # create console handler and set level to debug
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)
    
    # create formatter
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    
    # add formatter to ch
    ch.setFormatter(formatter)
    
    # add ch to logger
    logger.addHandler(ch)
    sys.exit(main())
