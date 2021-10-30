from flask_restful import Resource, reqparse
from flask import render_template, Response
import requests
import json



class Game(Resource):
    def get (self, name):
        url = "https://free-to-play-games-database.p.rapidapi.com/api/games"

        querystring = {"category": name}

        headers = {
            'x-rapidapi-host': "free-to-play-games-database.p.rapidapi.com",
            'x-rapidapi-key': "fc010fb2aemshe9c83f856d3bae5p183940jsn675a512bbb3a"
        }

        response = requests.request("GET", url, headers=headers, params=querystring)
        jsondata = json.loads(response.text)

        return Response(render_template("game.html", games=jsondata, mimetype='text/html'))


class GameList(Resource):
    def get (self):
        url = "https://free-to-play-games-database.p.rapidapi.com/api/games"
        headers = {
            'x-rapidapi-host': "free-to-play-games-database.p.rapidapi.com",
            'x-rapidapi-key': "fc010fb2aemshe9c83f856d3bae5p183940jsn675a512bbb3a"
        }

        response = requests.request("GET", url, headers=headers)
        jsondata = json.loads(response.text)

        return Response(render_template("game.html", games=jsondata, mimetype='text/html'))

class GameCategory(Resource):
    def get (self, name):
        url = "https://free-to-play-games-database.p.rapidapi.com/api/games"

        querystring = {"category": name}

        headers = {
            'x-rapidapi-host': "free-to-play-games-database.p.rapidapi.com",
            'x-rapidapi-key': "fc010fb2aemshe9c83f856d3bae5p183940jsn675a512bbb3a"
        }

        response = requests.request("GET", url, headers=headers, params=querystring)
        jsondata = json.loads(response.text)

        return Response(render_template("game.html", games=jsondata, mimetype='text/html'))
