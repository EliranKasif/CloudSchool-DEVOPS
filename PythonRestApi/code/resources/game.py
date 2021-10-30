from flask_restful import Resource
from flask import render_template, Response
from connectors.externalAPI import QueryAPI


class Game(Resource):
    def get (self, name):
        querystring = {"category": name}
        jsondata = QueryAPI.get_games_query(querystring)
        return Response(render_template("game.html", games=jsondata, mimetype='text/html'))


class GameList(Resource):
    def get (self):
        jsondata = QueryAPI.get_games_query(None)
        return Response(render_template("game.html", games=jsondata, mimetype='text/html'))

