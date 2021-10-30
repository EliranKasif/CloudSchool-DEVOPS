from flask_restful import Resource
from flask import render_template, Response
from connectors.externalAPI import QueryAPI


class Game(Resource):
    def get (self, name):
        querystring = {"category": name}
        jsondata = QueryAPI.get_games_query(querystring)
        if jsondata == None:
            return Response(render_template("error.html", mimetype='text/html') , status = 404)
        return Response(render_template("game.html", games=jsondata, mimetype='text/html'), status = 200)


class GameList(Resource):
    def get (self):
        jsondata = QueryAPI.get_games_query(None)
        if jsondata == None:
            return Response(render_template("error.html", mimetype='text/html'), status = 404)
        return Response(render_template("game.html", games=jsondata, mimetype='text/html'), status = 200)

