import requests
import json


class QueryAPI:

    @classmethod
    def get_games_query(cls, querystring):
        from app import RAPID_API_KEY, END_POINT
        url = f"https://{END_POINT}/api/games"
        headers = {
            'x-rapidapi-host': END_POINT,
            'x-rapidapi-key': RAPID_API_KEY
        }
        response = requests.request("GET", url, headers=headers, params=querystring)
        jsondata = None
        if response.status_code == 200:
            jsondata = json.loads(response.text)
        return jsondata
