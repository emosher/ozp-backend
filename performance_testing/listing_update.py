import json
import uuid
import os
from timeit import default_timer as timer

from multiprocessing import Pool, TimeoutError, Process, current_process


import requests


class ProcessResponse(object):

    def __init__(self, data=None):
        self.data = data or {}



URL='http://127.0.0.1:8001/'
AUTH_TUPLE=('bigbrother', 'password')

def update_listing(input_id):
    proc_name = os.getpid()
    currrent_url = '{}api/listing/{}/'.format(URL, input_id)
    listing_data_request = requests.get(currrent_url, auth=AUTH_TUPLE)
    listing_data =  listing_data_request.json()
    print('process: {} , currrent_url:{}, get_status_code:{}'.format(proc_name, currrent_url, listing_data_request.status_code))

    uuid_string = str(uuid.uuid1())

    if "=" in listing_data['title']:
        param, value = listing_data['title'].split("=",1)
        new_title = '{}={}'.format(param, uuid_string)
    else:
        new_title = '{}={}'.format(listing_data['title'], uuid_string)

    listing_data['title']=new_title

    headers = {'Content-Type': 'application/json'}

    start = timer()
    listing_post_request = requests.put(currrent_url, data=json.dumps(listing_data, indent=2), auth=AUTH_TUPLE, headers=headers)
    end = timer()

    if listing_post_request.status_code == 200:
        print(listing_post_request.json()['title'])
        # print(json.dumps(listing_post_request.json(), indent=2))
    else:
        print(listing_post_request.text)
        return 0

    return ProcessResponse(data={'time_to_post': (end-start)})


if __name__ == '__main__':
    proc_name = os.getpid()

    print('Root PID:{}'.format(proc_name))


    pool = Pool(processes=30)

    results = []
    for n in range(1,10):
        for i in range(1, 150):
            results.append(pool.apply_async(update_listing, (i,)))

    # Wait till all tasks in pool are finished
    pool.close()
    pool.join()

    times = []

    for result_future in results:
        process_response = result_future.get()
        times.append(process_response.data['time_to_post'])


    print('Performance Testing for updating listing')

    # print('==Times for each call')
    #
    # for i in times:
    #     print('\t{}'.format(i))

    print('==Average: {}'.format(sum(times)/len(times)))
    print('==Len: {}'.format(len(times)))
